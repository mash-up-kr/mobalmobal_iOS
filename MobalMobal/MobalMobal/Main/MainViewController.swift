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
        view.backgroundColor = .darkGrey
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
        tableView.backgroundColor = .darkGrey
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    // MARK: - property
    var lastContentOffset: CGFloat = 0.0
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGrey
        tableView.delegate = self
        tableView.dataSource = self
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        cell.backgroundColor = .darkGrey
        cell.textLabel?.text = "ddd"
        cell.selectionStyle = .none
        return cell
    }
}
