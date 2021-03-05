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
        pointTableView.backgroundColor = .backgroundColor
        return pointTableView
    }()
    private let pageTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "충전"
        label.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 18)
        label.textColor = .white
        label.backgroundColor = .backgroundColor
        return label
    }()
    private let transparencyView: UIView = {
        let view: UIView = UIView()
        view.alpha = 0
        return view
    }()
    private let contentView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .backgroundColor
        view.layer.cornerRadius = 30.0
        return view
    }()
    // MARK: - Properties
    private let pointItems: [String] = ["1,000원", "2,000원", "5,000원", "10,000원", "50,000원", "100,000원", "직접입력"]
    private let cellIdentifier: String = "PointChargingTableViewCell"
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setLayout()
    }
    // MARK: - Methods
    private func setTableView() {
        self.chargingTableView.delegate = self
        self.chargingTableView.dataSource = self
        self.chargingTableView.register(PointChargingTableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        self.chargingTableView.separatorStyle = .none
        self.chargingTableView.isScrollEnabled = false
    }
    private func setLayout() {
        [ transparencyView, contentView].forEach { self.view.addSubview($0) }
        [ chargingTableView, pageTitle].forEach { self.contentView.addSubview($0) }

        chargingTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(contentView.snp.bottom).inset(34)
        }
        pageTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.bottom.equalTo(chargingTableView.snp.top).inset(-53.2)
            make.centerX.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(492.2 + 21)
        }
        transparencyView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(contentView.snp.top)
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
        return cell
    }
}
 // MARK: - TableViewDelegate
extension PointChargingViewController: UITableViewDelegate {
}

