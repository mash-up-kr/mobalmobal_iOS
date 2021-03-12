//
//  ProfileViewController.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/02/27.
//

import SnapKit
import UIKit

class ProfileViewController: UIViewController {
    // MARK: - UIComponents
    private let scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.backgroundColor = .backgroundColor
        return scrollView
    }()
    private let contentView: UIView = {
        let contentView: UIView = UIView()
        contentView.backgroundColor = .backgroundColor
        return contentView
    }()
    private let mainTableView: UITableView = {
        let tableview: UITableView = UITableView(frame: .zero, style: .plain)
        return tableview
    }()
    
    // MARK: - Properties
    let sectionHeader: [String] = ["내 도네", "내 연 도네", "후원중인 도네", "종료된 도네"]
    private let profileCellIdentifier: String = "ProfileTableViewCell"
    private let myDonationCellIdentifier: String = "MyDonationTableViewCell"
    private let donatingCellIdentifier: String = "DonatingTableViewCell"

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setLayout()
    }
    
    // MARK: - Methods
    func setTableView() {
        self.mainTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: self.profileCellIdentifier)
        self.mainTableView.register(ProfileMyDonationTableViewCell.self, forCellReuseIdentifier: self.myDonationCellIdentifier)
        self.mainTableView.register(ProfileDonatingTableViewCell.self, forCellReuseIdentifier: self.donatingCellIdentifier)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = .backgroundColor
        mainTableView.separatorStyle = .none
        mainTableView.estimatedRowHeight = 160
        mainTableView.rowHeight = UITableView.automaticDimension
    }
    func setLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [mainTableView].forEach { contentView.addSubview($0) }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.edges.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height)        // 수정필요
        }
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let profileCell: ProfileTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: profileCellIdentifier, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
        guard let myDonationCell: ProfileMyDonationTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: myDonationCellIdentifier, for: indexPath) as? ProfileMyDonationTableViewCell else { return UITableViewCell() }
        return myDonationCell
    }
}
extension ProfileViewController: UITableViewDelegate {
}
