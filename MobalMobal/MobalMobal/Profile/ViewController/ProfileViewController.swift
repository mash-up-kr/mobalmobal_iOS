//
//  ProfileViewController.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/02/27.
//

import SnapKit
import UIKit

class ProfileViewController: UIViewController {
    let sectionHeader: [String] = ["내 도네", "내 연 도네", "후원중인 도네", "종료된 도네"]
    private let profileCellIdentifier: String = "ProfileTableViewCell"
    private let myDonationCellIdentifier: String = "MyDonationTableViewCell"
    private let donatingCellIdentifier: String = "DonatingTableViewCell"
    
    private let mainTableView: UITableView = {
        let tableview: UITableView = UITableView(frame: .zero, style: .plain)
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: self.profileCellIdentifier)
        self.mainTableView.register(ProfileMyDonationTableViewCell.self, forCellReuseIdentifier: self.myDonationCellIdentifier)
        self.mainTableView.register(ProfileDonatingTableViewCell.self, forCellReuseIdentifier: self.donatingCellIdentifier)
        setLayout()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = .backgroundColor
        mainTableView.separatorStyle = .none
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.estimatedRowHeight = UITableView.automaticDimension
        mainTableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
    }
    func setLayout() {
        [mainTableView].forEach { view.addSubview($0) }
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        }
        else {
            // 나머지는 서버에ㅓㅅ 받아온 갯수에 따라서 나열됨.
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let profileCell: ProfileTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: self.profileCellIdentifier, for: indexPath) as? ProfileTableViewCell,
              let myDonationCell: ProfileMyDonationTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: self.myDonationCellIdentifier, for: indexPath) as? ProfileMyDonationTableViewCell,
              let donatingCell: ProfileDonatingTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: self.donatingCellIdentifier, for: indexPath) as? ProfileDonatingTableViewCell
        else {
            return UITableViewCell()
        }
        if indexPath.section == 0 {
            return profileCell
        }
        if indexPath.section == 1 {
            return myDonationCell
        }
        if indexPath.section >= 2 {
            return donatingCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0 :
            return nil
        case 1 :
            return sectionHeader[0]
        case 2 :
            return sectionHeader[1]
        case 3 :
            return sectionHeader[2]
        case 4:
            return sectionHeader[3]
        default:
            return nil
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        print("will display header view ✨")
//        let sectionHeader: [String] = ["내 도네", "내 연 도네", "후원중인 도네", "종료된 도네"]
//        let headerLabel: UILabel = {
//            let label: UILabel = UILabel()
//            switch section {
//            case 1 :
//                label.text = sectionHeader[0]
//            case 2 :
//                label.text = sectionHeader[1]
//            case 3 :
//                label.text = sectionHeader[2]
//            case 4:
//                label.text = sectionHeader[3]
//            default:
//                label.text = ""
//            }
//            label.font = UIFont(name: "futura", size: 24)
//            label.textColor = .white
//            return label
//        }()
//
//        let backgroundView: UIView = {
//            let view: UIView = UIView()
//            view.backgroundColor = .red
//            return view
//        }()
//        view.addSubview(backgroundView)
//        backgroundView.addSubview(headerLabel)
//        headerLabel.snp.makeConstraints { make in
//            make.top.equalTo(backgroundView)
//            make.leading.equalTo(backgroundView.snp.leading).offset(20)
//            make.bottom.equalTo(backgroundView.snp.bottom).inset(12)
//        }
//        backgroundView.snp.makeConstraints { make in
//            make.edges.equalTo(view)
//        }
//    }
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return 80
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return
//    }
}
