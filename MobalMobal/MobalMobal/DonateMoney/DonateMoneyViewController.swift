//
//  DonateMoneyViewController.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/12.
//

import UIKit

class DonateMoneyViewController: DoneBaseViewController {
    // MARK: - UIComponents
    private let clearView: UIView = UIView()
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.backgroundColor = .darkGreyTwo
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        
        // delegate, datasource 적용
        tableView.delegate = self
        tableView.dataSource = self
        
        // cell 적용
        tableView.register(DonateMoneyTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    // MARK: - Properties
    private lazy var viewModel: DonateMoneyViewModel = DonateMoneyViewModel(delegate: self)
    var donationCompletionHander: () -> Void = {}
    
    private let headerString: String = "후원"
    private let cellIdentifier: String = "DonateMoneyTableViewCell"
    
    // MARK: - Initializer
    init(postId: Int, nickname: String, giftName: String) {
        super.init(nibName: nil, bundle: nil)
        viewModel.setPostId(postId)
        viewModel.setNickname(nickname)
        viewModel.setGiftName(giftName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        setConstraints()
        setViewTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        tableView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        tableView.drawShadow(color: .black, alpha: 1.0, shadowX: 0, shadowY: 20, blur: 20, spread: 0)
    }
    
    // MARK: - Actions
    @objc
    private func dismissViewController() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    private func pushPointChargingVC() {
        let pointCharging: PointChargingViewController = PointChargingViewController()
        navigationController?.pushViewController(pointCharging, animated: false)
    }
    
    // MARK: - Methods
    private func setConstraints() {
        view.addSubviews([tableView, clearView])
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(51 * (viewModel.amounts.count + 1) + 77)
        }
        clearView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tableView.snp.top)
        }
    }
    private func setViewTapGesture() {
        let clearViewTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        clearView.addGestureRecognizer(clearViewTap)
    }
    private func showInsufficientPointAlert() {
        let alert: UIAlertController = UIAlertController(title: "포인트 잔액 부족", message: "포인트를 먼저 충전해주세요", preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "취소", style: .cancel)
        let moveAction: UIAlertAction = UIAlertAction(title: "충전 페이지로", style: .default) { [weak self] _ in
            self?.pushPointChargingVC()
        }
        alert.addAction(cancelAction)
        alert.addAction(moveAction)
        present(alert, animated: true)
    }
    private func showDonateFailAlert(message: String?) {
        var alertMessage: String = "에러가 발생했습니다. 잠시 후 다시 시도해주세요."
        if let message = message {
            alertMessage = message
        }
        let alert: UIAlertController = UIAlertController(title: "후원 실패", message: alertMessage, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.navigationController?.dismiss(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension DonateMoneyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < viewModel.amounts.count {
            viewModel.donate(amount: viewModel.amounts[indexPath.row])
        } else {
            let inputDonateMoneyVC: InputDonationMoneyViewController = InputDonationMoneyViewController(postId: viewModel.getPostId(), nickname: viewModel.getNickname(), giftName: viewModel.getGiftName())
            inputDonateMoneyVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(inputDonateMoneyVC, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource
extension DonateMoneyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = UIView()
        let headerLabel: UILabel = {
            let label: UILabel = UILabel()
            label.text = headerString
            label.font = .spoqaHanSansNeo(ofSize: 18, weight: .medium)
            label.textColor = .white
            return label
        }()
        
        headerView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        77
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.amounts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DonateMoneyTableViewCell else {
            return UITableViewCell()
        }
        if indexPath.row < viewModel.amounts.count {
            let title: String = viewModel.amounts[indexPath.row].changeToCommaFormat() ?? "???"
            cell.setTitle("\(title)원")
        } else {
            cell.setTitle("직접 입력")
        }
        return cell
    }
}

extension DonateMoneyViewController: DonateMoneyViewModelDelegate {
    func insufficientPoint() {
        showInsufficientPointAlert()
    }
    
    func failDonateMoney(message: String?) {
        showDonateFailAlert(message: message)
    }
    
    func completeDonateMoney(amount: Int) {
        // 후원완료 페이지로 이동
        let completeVC: DonateCompleteViewController = DonateCompleteViewController(nickname: viewModel.getNickname(), giftName: viewModel.getGiftName(), moneyAmount: amount)
        completeVC.donationCompletionHander = donationCompletionHander
        completeVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(completeVC, animated: true)
    }
}
