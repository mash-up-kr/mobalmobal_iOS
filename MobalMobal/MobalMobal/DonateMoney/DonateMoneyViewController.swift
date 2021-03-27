//
//  DonateMoneyViewController.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/12.
//

import UIKit

class DonateMoneyViewController: UIViewController {
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
    private let headerString: String = "후원"
    private let moneyStrings: [String] = ["1,000원", "2,000원", "5,000원", "10,000원", "50,000원", "100,000원", "직접입력"]
    private let cellIdentifier: String = "DonateMoneyTableViewCell"
    
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
    
    // MARK: - Methods
    private func setConstraints() {
        view.addSubviews([tableView, clearView])
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(51 * moneyStrings.count + 77)
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
}

// MARK: - UITableViewDelegate
extension DonateMoneyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == moneyStrings.count - 1 {
            print("🐻 직접 입력 🐻")
            let inputDonateMoneyVC: InputDonationMoneyViewController = InputDonationMoneyViewController()
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
        moneyStrings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DonateMoneyTableViewCell else {
            return UITableViewCell()
        }
        cell.setTitle(moneyStrings[indexPath.row])
        return cell
    }
}
