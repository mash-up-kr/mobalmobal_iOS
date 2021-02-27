//
//  PoingChargingViewController.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/02/27.
//

import SnapKit
import UIKit

class PointChargingViewController: UIViewController {
    // MARK: - UIComponents
    private let chargingTableView: UITableView = {
        let pointTableView: UITableView = UITableView(frame: .zero, style: .plain)
        return pointTableView
    }()
    private let pageTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "충전"
        label.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 18)
        label.textColor = .white
        return label
    }()
  
    // MARK: - Properties
    private let pointItems: [String] = ["1,000원", "2,000원", "5,000원", "10,000원", "50,000원", "100,000원", "직접입력"]
    private let cellIdentifier: String = "PointChargingTableViewCell"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chargingTableView.delegate = self
        self.chargingTableView.dataSource = self
        self.chargingTableView.register(PointChargingTableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        self.view.backgroundColor = .black
        self.chargingTableView.backgroundColor = .black
        self.chargingTableView.separatorStyle = .none
        setLayout()
    }
    
    // MARK: - Methods
    private func setLayout() {
        [chargingTableView, pageTitle].forEach { self.view.addSubview($0) }
        pageTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        chargingTableView.snp.makeConstraints { make in
            make.top.equalTo(pageTitle.snp.bottom).offset(53.2)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
}

 // MARK: - TableViewDataSource
extension PointChargingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.pointItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PointChargingTableViewCell = self.chargingTableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? PointChargingTableViewCell else { return UITableViewCell() }
        cell.pointPriceLabel.text = pointItems[indexPath.row]
        cell.pointPriceLabel.textColor = .white
        cell.pointPriceLabel.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 15)
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        return cell
    }
}

 // MARK: - TableViewDelegate
extension PointChargingViewController: UITableViewDelegate {
}
