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
        let tableview: UITableView = UITableView(frame: .zero, style: .grouped)
        return tableview
    }()
    
    // MARK: - Properties
    let sectionHeader: [String] = ["내 연 도네", "후원중인 도네", "종료된 도네"]
    private let profileCellIdentifier: String = "ProfileTableViewCell"
    private let myDonationCellIdentifier: String = "MyDonationTableViewCell"
    private let donatingCellIdentifier: String = "DonatingTableViewCell"
    private let sectionHeaderCellIdentifier: String = "SectionHeaderCell"
    private let numberOfDonations: [Int] = [1, 1, 1]
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setLayout()
        setNavigation()
    }
    
    // MARK: - Actions
    @objc
    private func popVC() {
        print("✨ pop viewcontroller")
    }
    @objc
    private func modifyInfo() {
        print("✨ modify user info")
    }
    @objc
    private func pushSettingVC() {
        print("✨ push setting vc")
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
            make.height.equalTo(UIScreen.main.bounds.height)        
        }
    }
    private func setNavigation() {
        self.navigationController?.navigationBar.backgroundColor = .blackFour
        self.navigationController?.navigationBar.barTintColor = .blackFour
        self.navigationController?.navigationBar.isTranslucent = false
        // dummy data
        self.navigationItem.title = "Jercy"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.whiteTwo]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrowChevronBigLeft"), style: .plain, target: self, action: #selector(popVC))
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "iconlyLightEditSquare"), style: .plain, target: self, action: #selector(modifyInfo)),
            UIBarButtonItem(image: UIImage(named: "iconlyLightSetting"), style: .plain, target: self, action: #selector(pushSettingVC))
        ]
    }
    
    // 유동적으로 갯수가 변화하는 section인지 체크하는 메서드
    func checkDynamicSection(_ section: Int) -> Bool {
        if section == 0 || section == 1 {
            return false
        }
        return true
    }
    
    // 서버로부터 받아온 도네이션 갯수가 0개인지 체크하는 메서드
    func checkNumberOfDonationIsZero(_ section: Int) -> Bool {
        if numberOfDonations[section - 2] == 0 {
            return true
        }
        return false
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // profile / 내 도네 현황 / 내 연도네 / 후원중인도네 / 종료된도네
        5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !checkDynamicSection(section) {
            return 1
        } else {
            // 서버에서 받아온 값 만큼
            return numberOfDonations[section - 2]
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let profileCell: ProfileTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: profileCellIdentifier, for: indexPath) as? ProfileTableViewCell,
              let myDonationCell: ProfileMyDonationTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: myDonationCellIdentifier, for: indexPath) as? ProfileMyDonationTableViewCell,
              let donatingCell: ProfileDonatingTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: donatingCellIdentifier, for: indexPath) as? ProfileDonatingTableViewCell
        else { return UITableViewCell() }
        
        [profileCell, myDonationCell, donatingCell].forEach { $0.selectionStyle = .none }
        switch indexPath.section {
        case 0:
            return profileCell
        case 1:
            return myDonationCell
        case 2:
            return donatingCell
        case 3:
            return donatingCell
        case 4:
            return donatingCell
        default:
            return donatingCell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if checkDynamicSection(section) && !checkNumberOfDonationIsZero(section) {
            let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 22))
            let headerLabel: UILabel = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.frame.width - 40, height: 22))
            headerLabel.text = sectionHeader[section - 2]
            headerLabel.textColor = .white
            headerLabel.font = .spoqaHanSansNeo(ofSize: 18, weight: .bold)
            
            headerView.addSubview(headerLabel)
            return headerView
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if !checkDynamicSection(section) {
            return CGFloat.leastNormalMagnitude
        }
        return 35
    }
}
extension ProfileViewController: UITableViewDelegate {
}
