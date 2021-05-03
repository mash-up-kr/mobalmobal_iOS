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
    private let sectionHeader: [String] = ["내 연 도네", "후원중인 도네", "종료된 도네"]
    private let profileCellIdentifier: String = "ProfileTableViewCell"
    private let myDonationCellIdentifier: String = "MyDonationTableViewCell"
    private let donatingCellIdentifier: String = "DonatingTableViewCell"
    private let sectionHeaderCellIdentifier: String = "SectionHeaderCell"
    private lazy var numberOfDonations: [Int] = [0, 0, 0]     // 내연, 후원중, 종료 갯수
    private let profileViewModel: ProfileViewModel = ProfileViewModel()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setLayout()
        setNavigation()
        callAPI()
        
        profileViewModel.mainDelegate = self
        mainTableView.tableFooterView = UIView(frame: .zero)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Actions
    @objc
    private func popVC() {
        navigationController?.popViewController(animated: true)
    }
    /* 1차배포 제외
    @objc
    private func modifyInfo() {
        print("✨ modify user info")
    }
     */
    @objc
    private func pushSettingVC() {
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
    // MARK: - Methods
    func callAPI() {
        profileViewModel.getMydontaionResponse()
        profileViewModel.getProfileResponse()
        profileViewModel.getMyDonateResponse()
    }
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
    private func setNavigation() {

        self.navigationController?.navigationBar.barTintColor = .blackFour
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationItem.title = profileViewModel.getUserNickname()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.whiteTwo]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrowChevronBigLeft"), style: .plain, target: self, action: #selector(popVC))
        
        // 1차배포 제외(프로필 수정)
//        let editBtn: UIButton = UIButton()
//        editBtn.setImage(UIImage(named: "iconlyLightEditSquare"), for: .normal)
//        editBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
//        editBtn.addTarget(self, action: #selector(pushSettingVC), for: .touchUpInside)
//        let editBtnBarItem: UIBarButtonItem = UIBarButtonItem(customView: editBtn)
        
        let settingBtn: UIButton = UIButton()
        settingBtn.setImage(UIImage(named: "iconlyLightSetting"), for: .normal)
        settingBtn.addTarget(self, action: #selector(pushSettingVC), for: .touchUpInside)
        settingBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        let settingBtnBarItem: UIBarButtonItem = UIBarButtonItem(customView: settingBtn)
        
        self.navigationItem.setRightBarButtonItems([settingBtnBarItem], animated: true)
    }
    
    // 유동적으로 갯수가 변화하는 section인지 체크하는 메서드
    func checkDynamicSection(_ section: Int) -> Bool {
        section >= 2 ? true : false
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
        5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("🍎🍎🍎🍎", profileViewModel.myInprogressResponseModel.count)
        print("🍎🍎🍎🍎", profileViewModel.myExpiredResponseModel.count)
        if !checkDynamicSection(section) {
            return 1
        } else {
            numberOfDonations = [0, 0, 0]
            numberOfDonations[0] = profileViewModel.myInprogressResponseModel.count
            numberOfDonations[1] = profileViewModel.myDonateResponseModel.count
            numberOfDonations[2] = profileViewModel.myExpiredResponseModel.count
            return numberOfDonations[section - 2]
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let profileCell: ProfileTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: profileCellIdentifier, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
            profileCell.selectionStyle = .none
            profileCell.pointChargingDelegate = self
            if let userProfileData: ProfileData = profileViewModel.profileResponseModel {
                profileCell.cellViewModel.setModel(userProfileData)
            }
            return profileCell
        } else if indexPath.section == 1 {
            guard let myDonationCell: ProfileMyDonationTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: myDonationCellIdentifier, for: indexPath) as? ProfileMyDonationTableViewCell else { return UITableViewCell() }
            myDonationCell.selectionStyle = .none
            
            myDonationCell.myDonationViewModel.setMyDonationModel(profileViewModel.mydonationResponseModel)
            myDonationCell.myDonationViewModel.setMyDonateModel(profileViewModel.myDonateResponseModel)
            return myDonationCell
        }
        // 내가 연 도네 && 종료도네.
        else if indexPath.section == 2 || indexPath.section == 4 {
            guard let donatingCell: ProfileDonatingTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: donatingCellIdentifier, for: indexPath) as? ProfileDonatingTableViewCell
            else { return UITableViewCell() }
            donatingCell.selectionStyle = .none
            donatingCell.headerLabelText = sectionHeader[indexPath.section - 2]
            if indexPath.section == 2 {
                donatingCell.viewModel.setMyDonationData(profileViewModel.myInprogressResponseModel[indexPath.row])
            } else {
                donatingCell.viewModel.setMyDonationData(profileViewModel.myExpiredResponseModel[indexPath.row])
            }
            
            return donatingCell
        } else {        // 내가 후원한 도네
            guard let donatingCell: ProfileDonatingTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: donatingCellIdentifier, for: indexPath) as? ProfileDonatingTableViewCell
            else { return UITableViewCell() }
            donatingCell.headerLabelText = sectionHeader[indexPath.section - 2]
            donatingCell.viewModel.setMyDonateData(profileViewModel.myDonateResponseModel[indexPath.row])
            donatingCell.selectionStyle = .none
            return donatingCell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if checkNumberOfDonationIsZero(section) {
            return nil
        }
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 42))
        let headerLabel: UILabel = UILabel(frame: CGRect(x: 20, y: 20, width: tableView.frame.width - 40, height: 45))
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
        if checkNumberOfDonationIsZero(section) {
            return CGFloat.leastNormalMagnitude
        }
        return 54
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
}

 // MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section >= 2 {
            guard let postId = profileViewModel.getPostId(section: indexPath.section, row: indexPath.row) else { return }
            let donationDetailVC: DonationDetailViewController = DonationDetailViewController(donationId: postId)
            self.navigationController?.pushViewController(donationDetailVC, animated: true)
        }
    }
}

// MARK: - ProfileViewModelDelegate
extension ProfileViewController: ProfileViewModelDelegate {
    func tableViewUpdate(section: IndexSet) {
        self.mainTableView.reloadSections(section, with: .automatic)
        self.navigationItem.title = profileViewModel.getUserNickname()
    }
}

// MARK: - ppointChargingActionDelegate
extension ProfileViewController: pointChargingActionDelegate {
    func presentPointChargingView() {
        let pointChargingVC: PointChargingViewController = PointChargingViewController()
        let navVc: UINavigationController = UINavigationController(rootViewController: pointChargingVC)
        navVc.modalPresentationStyle = .overFullScreen
        self.present(navVc, animated: true, completion: nil)
    }
}
