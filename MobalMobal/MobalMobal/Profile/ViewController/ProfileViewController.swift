//
//  ProfileViewController.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/02/27.
//

import SnapKit
import UIKit

class ProfileViewController: DoneBaseViewController {
    // MARK: - UIComponents
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
    
    private let modifyVC: UIViewController = ModifyProfileViewController()
    private let chargingVC: UIViewController = PointChargingViewController()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setLayout()
        setNavigationItems()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Actions
    @objc
    private func popVC() {
        print("✨ pop viewcontroller")
        navigationController?.popViewController(animated: true)
    }
    @objc
    private func modifyInfo() {
        print("✨ modify user info")
        navigationController?.pushViewController(modifyVC, animated: true)
    }
    @objc
    private func pushSettingVC() {
        print("✨ push setting vc")
        
        // 임시로 PointCharging으로 이동하는 코드
        let navVC: UINavigationController = UINavigationController(rootViewController: chargingVC)
        navVC.modalPresentationStyle = .overFullScreen
        self.present(navVC, animated: true)
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
        [mainTableView].forEach { self.view.addSubview($0) }
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height)        
        }
    }
    private func setNavigationItems() {
        setNavigationItems(title: "Jercy", backButtonImageName: "arrowChevronBigLeft", action: #selector(popVC))
        
        // 추가 네비게이션 아이템
        let editBtn: UIButton = UIButton()
        editBtn.setImage(UIImage(named: "iconlyLightSetting"), for: .normal)
        editBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        editBtn.addTarget(self, action: #selector(pushSettingVC), for: .touchUpInside)
        let editBtnBarItem: UIBarButtonItem = UIBarButtonItem(customView: editBtn)
        
        let settingBtn: UIButton = UIButton()
        settingBtn.setImage(UIImage(named: "iconlyLightEditSquare"), for: .normal)
        settingBtn.addTarget(self, action: #selector(modifyInfo), for: .touchUpInside)
        settingBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        let settingBtnBarItem: UIBarButtonItem = UIBarButtonItem(customView: settingBtn)
        
        self.navigationItem.setRightBarButtonItems([editBtnBarItem, settingBtnBarItem], animated: true)
    }
    
    // 유동적으로 갯수가 변화하는 section인지 체크하는 메서드
    func checkDynamicSection(_ section: Int) -> Bool {
        if section < 2 { return false }
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
        if indexPath.section == 0 {
            guard let profileCell: ProfileTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: profileCellIdentifier, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
            profileCell.selectionStyle = .none
            return profileCell
        } else if indexPath.section == 1 {
            guard let myDonationCell: ProfileMyDonationTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: myDonationCellIdentifier, for: indexPath) as? ProfileMyDonationTableViewCell else { return UITableViewCell() }
            myDonationCell.selectionStyle = .none
            return myDonationCell
        } else {
            guard let donatingCell: ProfileDonatingTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: donatingCellIdentifier, for: indexPath) as? ProfileDonatingTableViewCell
            else { return UITableViewCell() }
            donatingCell.selectionStyle = .none
            return donatingCell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !checkDynamicSection(section) && checkNumberOfDonationIsZero(section) {
            return nil
        }
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 22))
        let headerLabel: UILabel = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.frame.width - 40, height: 22))
        headerLabel.text = sectionHeader[section - 2]
        headerLabel.textColor = .white
        headerLabel.font = .spoqaHanSansNeo(ofSize: 18, weight: .bold)
        
        headerView.addSubview(headerLabel)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if !checkDynamicSection(section) {
            return CGFloat.leastNormalMagnitude
        }
        return 35
    }
}

 // MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
}
