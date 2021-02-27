//
//  SettingViewController.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/02/27.
//

import SnapKit
import UIKit

class SettingViewController: UIViewController {
    // MARK: - UIView
    private let settingLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont(name: "futura", size: 18)
        label.textColor = .black
        label.text = "설정"
        return label
    }()
    
    private let dismissButton: UIButton = {
        let button: UIButton = UIButton()
        button.titleLabel?.text = "뒤로가기"
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc
    func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        return tableView
    }()
    
    // MARK: - Property
    private let cellIdentifier: String = "settingTableViewCell"
    private let settingLabelArray: [String] = ["내 계좌", "프로필 변경", "오픈소스 약관", "이용약관", "알림설정", "문의하기"]
    
    // MARK: - Method
    private func setup() {
        self.view.backgroundColor = .systemBackground
        self.setTitleLabel()
        self.setTableView()
        self.setConstraint()
    }
    
    private func setTitleLabel() {
        self.view.addSubview(settingLabel)
        self.view.addSubview(dismissButton)
        self.settingLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(view).offset(100)
        }
        self.dismissButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(100)
            make.leading.equalTo(view).offset(10)
        }
    }
    
    private func setTableView() {
        self.view.addSubview(tableView)
        self.tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        self.tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
        self.tableView.isScrollEnabled = false
    }
    
    private func setConstraint() {
        self.tableView.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(self.settingLabel).offset(100)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: - UITableViewDataSource
extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingLabelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeued: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        guard let cell = dequeued as? SettingTableViewCell else {
            return dequeued
        }
        
        cell.titleLabel.text = settingLabelArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - UITabelViewDelegate
extension SettingViewController: UITableViewDelegate {
}
