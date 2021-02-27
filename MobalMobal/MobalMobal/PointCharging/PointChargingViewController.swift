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
        label.text = "충전 페이지"
        return label
    }()
  
    // MARK: - Properties
    private let pointItems: [String] = ["1,000원", "2,000원", "3,000원", "4,000원", "5,000원", "6,000원", "7,000원"]
    private let cellIdentifier: String = "PointChargingTableViewCell"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chargingTableView.delegate = self
        self.chargingTableView.dataSource = self
        self.chargingTableView.register(PointChargingTableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        self.view.backgroundColor = .white
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
            make.top.equalTo(pageTitle.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(10)
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
        cell.selectionStyle = .none
        return cell
    }
}

 // MARK: - TableViewDelegate
extension PointChargingViewController: UITableViewDelegate {
}
