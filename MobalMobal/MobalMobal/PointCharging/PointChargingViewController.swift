//
//  PointChargingViewController.swift
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
        pointTableView.backgroundColor = .darkGreyTwo
        return pointTableView
    }()
    private let pageTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "충전"
        label.font = .spoqaHanSansNeo(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.backgroundColor = .darkGreyTwo
        return label
    }()
    private let transparencyView: UIView = UIView()
    private let contentView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .darkGreyTwo
        view.layer.cornerRadius = 30.0
        view.layer.shadowColor = UIColor.black25.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 2
        view.layer.masksToBounds = false
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    // MARK: - Properties
    private let pointItemList: [String] = ["1,000원", "2,000원", "5,000원", "10,000원", "50,000원", "100,000원", "직접입력"]
    private let cellIdentifier: String = "PointChargingTableViewCell"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setViewDismissGesture()
        setLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Actions
    @objc
    func dismissVC() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    private func setLayout() {
        self.view.addSubviews([transparencyView, contentView])
        self.contentView.addSubviews([chargingTableView, pageTitle])

        chargingTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(contentView.snp.bottom).inset(21)
        }
        pageTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.bottom.equalTo(chargingTableView.snp.top).inset(-50)
            make.centerX.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(456)
        }
        transparencyView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(contentView.snp.top)
        }
    }
    private func setTableView() {
        self.chargingTableView.delegate = self
        self.chargingTableView.dataSource = self
        self.chargingTableView.register(PointChargingTableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        self.chargingTableView.separatorStyle = .none
        self.chargingTableView.isScrollEnabled = false
    }
    private func setViewDismissGesture() {
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        self.transparencyView.addGestureRecognizer(tapGestureRecognizer)
    }
}

 // MARK: - TableViewDataSource
extension PointChargingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.pointItemList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PointChargingTableViewCell = self.chargingTableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? PointChargingTableViewCell else { return UITableViewCell() }
        cell.pointPriceLabel.text = pointItemList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        49
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
        self.navigationController?.pushViewController(accountVC, animated: true)
    }
    func pushInputVC() {
        let inputVC: InputChargingPointViewController = InputChargingPointViewController()
        self.navigationController?.pushViewController(inputVC, animated: true)
    }
}
