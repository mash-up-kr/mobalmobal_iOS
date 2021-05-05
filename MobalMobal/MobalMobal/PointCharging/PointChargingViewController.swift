//
//  PointChargingViewController.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/02/27.
//

import Toast
import SnapKit
import UIKit

class PointChargingViewController: DoneBaseViewController {
    // MARK: - UIComponents
    private let clearView: UIView = UIView()
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.backgroundColor = .darkGreyTwo
        return tableView
    }()
    
    // MARK: - Properties
    private let pointItemList: [String] = ["1,000원", "2,000원", "5,000원", "10,000원", "50,000원", "100,000원", "직접 입력"]
    private let cellIdentifier: String = "PointChargingTableViewCell"
    private let viewModel: InputChargingPointViewModel = InputChargingPointViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setViewDismissGesture()
        setConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidLayoutSubviews() {
        tableView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        tableView.drawShadow(color: .black, alpha: 1.0, shadowX: 0, shadowY: 20, blur: 20, spread: 0)
    }
    // MARK: - Actions
    @objc
    func dismissVC() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods

    private func setConstraints() {
        view.addSubviews([tableView, clearView])
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(51 * (7) + 77)
        }
        clearView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tableView.snp.top)
        }
    }
    private func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(PointChargingTableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        self.tableView.separatorStyle = .none
        self.tableView.isScrollEnabled = false
    }
    private func setViewDismissGesture() {
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        self.clearView.addGestureRecognizer(tapGestureRecognizer)
    }
    private func tokenError() {
        let loginVC: LoginViewController = LoginViewController()
        let navigation: UINavigationController = UINavigationController(rootViewController: loginVC)
        navigation.modalPresentationStyle = .fullScreen
        self.present(navigation, animated: true, completion: nil)
    }
    private func networkError() {
        let toastPoint: CGPoint = CGPoint(x: view.frame.midX, y: view.frame.maxY - 60)
        self.view.makeToast("네트워크 연결을 다시 해주세요.", duration: 2.0, point: toastPoint, title: nil, image: nil, completion: nil)
    }
    private func setNetwork(_ textFieldText: String) {
        viewModel.amount = Int(textFieldText)!
        viewModel.userName = UserInfo.shared.nickName
        viewModel.chargedAt = Date().iso8601withFractionalSeconds
        let toastPoint: CGPoint = CGPoint(x: view.frame.midX, y: view.frame.maxY - 60)
        viewModel.postCharging { [weak self] result in
            switch result {
            case .success:
                print("🎉🎉chaging success🎉🎉")
            case .failure(.client):
                self?.networkError()
            case.failure(.noData):
                self?.view.makeToast("충전할 값을 다시 입력해주세요", duration: 2.0, point: toastPoint, title: nil, image: nil, completion: nil)
            case .failure(.server), .failure(.unknown):
                self?.tokenError()
            }
        }

    }
}

 // MARK: - TableViewDataSource
extension PointChargingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.pointItemList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PointChargingTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? PointChargingTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = pointItemList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        77
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = UIView()
        let headerLabel: UILabel = {
            let label: UILabel = UILabel()
            label.text = "충전"
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
}

 // MARK: - TableViewDelegate
extension PointChargingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexPath.row <= 5 ? pushAccountVC(indexPath.row) : pushInputVC()
    }
    func pushAccountVC(_ indexNumber: Int) {
        let accountVC: AccountViewController = AccountViewController()
        accountVC.charge = pointItemList[indexNumber]
        setNetwork(pointItemList[indexNumber].components(separatedBy: [",", "원"]).joined())
        self.navigationController?.pushViewController(accountVC, animated: true)
    }
    func pushInputVC() {
        let inputVC: InputChargingPointViewController = InputChargingPointViewController()
        self.navigationController?.pushViewController(inputVC, animated: true)
    }
}
