//
//  MainViewController.swift
//  MobalMobal
//
//  Created by 김재희 on 2021/02/27.
//

import SnapKit
import Then
import UIKit

class MainViewController: UIViewController {
    // MARK: - UIComponent
    let titleView: UIView = {
        let view: UIView = UIView(frame: .zero)
        view.backgroundColor = .backgroundColor
        return view
    }()
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.text = "Hi, jaehui"
        label.font = UIFont(name: "Futura-Bold", size: 30)
        label.textColor = .white
        return label
    }()
    
    let notiListButton: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.setImage(UIImage(named: "icMyProfile"), for: .normal)
        return button
    }()
    
    let profileImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "icAlarm")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .backgroundColor
//        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    // MARK: - property
    var lastContentOffset: CGFloat = 0.0
    
    let sectionTitle: [String] = ["나의 진행", "진행중"]
    let myCellIdentifier: String = "MainMyDonationTableViewCell"
    let ongoingCellIdentifier: String = "MainOngoingDonationTableViewCell"
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setTableView()
        setLayout()
    }
    
    // MARK: - Action
    
    // MARK: - Method
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainMyDonationTableViewCell.self, forCellReuseIdentifier: myCellIdentifier)
        tableView.register(MainOngoingDonationTableViewCell.self, forCellReuseIdentifier: ongoingCellIdentifier)
        tableView.layer.masksToBounds = true
        tableView.clipsToBounds = true
    }
    
    private func setLayout() {
        [titleView, tableView].forEach { view.addSubview($0) }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        [titleLabel, notiListButton, profileImageView].forEach { titleView.addSubview($0) }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.equalToSuperview().inset(22)
            make.bottom.equalToSuperview().inset(10)
        }
        
        notiListButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.size.equalTo(44)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.leading.equalTo(notiListButton.snp.trailing)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(titleLabel)
            make.size.equalTo(44)
        }
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.lastContentOffset <= 0 {
            titleLabel.font = UIFont(name: "Futura-Bold", size: 25)
            titleLabel.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(30)
            }
        } else if self.lastContentOffset < scrollView.contentOffset.y {
            titleLabel.font = UIFont(name: "Futura-Bold", size: 16)
            titleLabel.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(13)
            }
        }
        self.lastContentOffset = scrollView.contentOffset.y
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell: MainMyDonationTableViewCell = tableView.dequeueReusableCell(withIdentifier: myCellIdentifier, for: indexPath) as? MainMyDonationTableViewCell else { return .init() }
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell: MainOngoingDonationTableViewCell = tableView.dequeueReusableCell(withIdentifier: ongoingCellIdentifier, for: indexPath) as? MainOngoingDonationTableViewCell else { return .init() }
            cell.selectionStyle = .none
            return cell
        default:
            return .init()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 184
        case 1:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
}
