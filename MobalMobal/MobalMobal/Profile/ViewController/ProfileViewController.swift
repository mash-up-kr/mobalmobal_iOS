//
//  ProfileViewController.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/02/27.
//

import SnapKit
import UIKit

class ProfileViewController: UIViewController {
    private let profileCellIdentifier: String = "ProfileTableViewCell"
    private let myDonationCellIdentifier: String = "MyDonationTableViewCell"
    private let donatingCellIdentifier: String = "DonatingTableViewCell"
    
    private let mainTableView: UITableView = {
        let tableview: UITableView = UITableView(frame: .zero, style: .plain)
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.mainTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: self.profileCellIdentifier)
        self.mainTableView.register(ProfileMyDonationTableViewCell.self, forCellReuseIdentifier: self.myDonationCellIdentifier)
        self.mainTableView.register(ProfileDonatingTableViewCell.self, forCellReuseIdentifier: self.donatingCellIdentifier)
//        self.view.backgroundColor = UIColor(cgColor: CGColor(red: 21 / 255.0, green: 21 / 255.0, blue: 22 / 255.0, alpha: 1.0))
        setLayout()
//        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = .black
    }
    func setLayout() {
        [mainTableView].forEach{view.addSubview($0) }
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let profileCell: ProfileTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: self.profileCellIdentifier, for: indexPath) as? ProfileTableViewCell,
              let myDonationCell: ProfileMyDonationTableViewCell =  mainTableView.dequeueReusableCell(withIdentifier: self.myDonationCellIdentifier, for: indexPath) as? ProfileMyDonationTableViewCell,
              let donatingCell: ProfileDonatingTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: self.donatingCellIdentifier, for: indexPath) as? ProfileDonatingTableViewCell
        else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0:
            return profileCell
        case 1:
            return myDonationCell
        case 2:
            return donatingCell
        default:
            return profileCell
        }
    }
}
