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
        button.setTitle("알림", for: .normal)
        return button
    }()
    
    let profileImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(frame: .zero)
//        imageView.image = UIImage
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .backgroundColor
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    // MARK: - property
    var lastContentOffset: CGFloat = 0.0
    
    let sectionTitle: [String] = ["나의 진행", "진행중"]
    let cellIdentifier: String = "MainMyDonationTableViewCell"
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainMyDonationTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        setLayout()
    }
    
    // MARK: - Action
    
    // MARK: - Method
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
            make.top.leading.bottom.equalToSuperview().inset(16)
        }
        
        notiListButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.size.equalTo(60)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.leading.equalTo(notiListButton.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(titleLabel)
            make.size.equalTo(30)
        }
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.lastContentOffset <= 0 {
            titleLabel.font = UIFont(name: "Futura-Bold", size: 25)
        } else if self.lastContentOffset < scrollView.contentOffset.y {
            titleLabel.font = UIFont(name: "Futura-Bold", size: 16)
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
            return 30
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = UIView(frame: .zero)
        headerView.backgroundColor = .clear
        
        let headerLabel: UILabel = UILabel(frame: .zero)
        headerLabel.font = UIFont(name: "Spoqa Han Sans Neo", size: 14)
        headerLabel.textColor = .white
        headerLabel.text = sectionTitle[section]
        
        [headerLabel].forEach { headerView.addSubview($0) }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.bottom.equalToSuperview().inset(10)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell: MainMyDonationTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MainMyDonationTableViewCell else { return .init() }
//            let cell: UITableViewCell = UITableViewCell()
            return cell
        case 1:
            let cell: UITableViewCell = UITableViewCell()
            cell.backgroundColor = .backgroundColor
            cell.textLabel?.text = "ddd"
            cell.selectionStyle = .none
            return cell
        default:
            return .init()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 132
        case 1:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
}
