//
//  DonateMoneyViewController.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/12.
//

import UIKit

class DonateMoneyViewController: UIViewController {
    // MARK: - UIComponents
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.backgroundColor = .darkGreyTwo
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - Properties
    private let headerString: String = "후원"
    private let moneyStrings: [String] = ["1,000원", "2,000원", "5,000원", "10,000원", "50,000원", "100,000원", "직접입력"]
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
    
    override func updateViewConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(458)
        }
        super.updateViewConstraints()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
}

// MARK: - Protocols
extension DonateMoneyViewController: UITableViewDelegate { }

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
        headerLabel.snp.makeConstraints { make in make.center.equalToSuperview() }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        62
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moneyStrings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        cell.backgroundColor = .darkGreyTwo
        cell.largeContentTitle = moneyStrings[indexPath.row]
        return cell
    }
}
