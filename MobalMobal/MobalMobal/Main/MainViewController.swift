//
//  MainViewController.swift
//  MobalMobal
//
//  Created by 김재희 on 2021/02/27.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
    // MARK: - UIComponent
    let titleView: UIView = {
        let view: UIView = UIView(frame: .zero)
        view.backgroundColor = .systemBlue
        return view
    }()
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.text = "김재희님 어쩌고"
        label.font = UIFont(name: "futura-Bold", size: 30)
        return label
    }()
    
    let notiListButton: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.setTitle("알림", for: .normal)
        return button
    }()
    
    let profileImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: UIImage(systemName: "return"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero, style: .plain)
//        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    // MARK: - property
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
    }
    
    // MARK: - Action
    
    // MARK: - Method
    private func setLayout() {
        [titleView, tableView].forEach { view.addSubview($0) }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        [titleLabel, notiListButton, profileImageView].forEach { titleView.addSubview($0) }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        notiListButton.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.centerY.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.leading.equalTo(notiListButton.snp.trailing).offset(8)
            make.size.equalTo(60)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}
