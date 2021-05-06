//
//  MainViewController.swift
//  MobalMobal
//
//  Created by 김재희 on 2021/02/27.
//

import Kingfisher
import SnapKit
import Then
import UIKit

class MainViewController: DoneBaseViewController {
    // MARK: - UIComponents
    let titleView: UIView = {
        let view: UIView = UIView(frame: .zero)
        view.backgroundColor = .backgroundColor
        return view
    }()
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.text = "Hi, \(UserInfo.shared.nickName ?? "Guest")"
        label.font = UIFont(name: "Futura-Bold", size: 25)
        label.textColor = .white
        return label
    }()
    
    let profileButton: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.setImage(UIImage(named: "icMyProfile"), for: .normal)
        button.addTarget(self, action: #selector(touchProfileButton), for: .touchUpInside)
        return button
    }()
    
    let notiListButton: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.setImage(UIImage(named: "icAlarm"), for: .normal)
        button.addTarget(self, action: #selector(touchNotiListButton), for: .touchUpInside)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .backgroundColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layer.masksToBounds = true
        collectionView.clipsToBounds = true
        collectionView.refreshControl = refreshControl
        return collectionView
    }()
    
    let refreshControl: UIRefreshControl = {
        let refreshControl: UIRefreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(scrollDown(_:)), for: .valueChanged)
//        refreshControl.attributedTitle = NSAttributedString(string: "새로고침")
        return refreshControl
    }()
    
    // MARK: - Properties
    var viewModel: MainViewModel
    
    var lastContentOffset: CGFloat = 0.0
    var lastMinContentOffset: CGFloat = 0.0
    
    private let itemsPerRow: CGFloat = 2
    private let firstSectionInsets: UIEdgeInsets = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
    private let secondSectionInsets: UIEdgeInsets = UIEdgeInsets(top: 15.0, left: 22.0, bottom: 15.0, right: 22.0)
    
    let sectionTitle: [String] = ["나의 진행", "진행중"]
    let myCellIdentifier: String = "MainMyDonationCollectionViewCell"
    let ongoingCellIdentifier: String = "MainOngoingDonationCollectionViewCell"
    let ongoingHeaderIdentifier: String = "MainOngoingDonationHeaderView"
    let indicatorCellIdentifier: String = "MainIndicatorCollectionViewCell"
    
    // MARK: - Initializer
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.mainViewModelDelegate = self
        view.backgroundColor = .backgroundColor
        setCollectionView()
        setLayout()
        
        viewModel.callUserInfoApi { return }
        viewModel.callMainPostsApi { return }
        viewModel.callMyDonationAPI { return }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        if UserInfo.shared.needToUpdate {
            viewModel.refresh { return }
        }
    }
    
    // MARK: - Actions
    @objc
    private func touchProfileButton() {
        if KeychainManager.isEmptyUserToken() {
            presentLoginVC()
        } else {
            pushProfileVC()
        }
    }
    @objc
    private func touchNotiListButton() {
        if KeychainManager.isEmptyUserToken() {
            presentLoginVC()
        } else {
            presentNotiListVC()
        }
    }
    @objc
    private func scrollDown(_ sender: Any) {
        viewModel.refresh {
            self.refreshControl.endRefreshing()
        }
    }
    
    private func pushProfileVC() {
        let profileVC: ProfileViewController = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func presentLoginVC() {
        let loginVC: LoginViewController = LoginViewController()
        let navVc: UINavigationController = UINavigationController(rootViewController: loginVC)
        navVc.modalPresentationStyle = .fullScreen
        self.present(navVc, animated: true)
    }
    
    // 변경 가능
    private func presentNotiListVC() {
        // let notiListVC: NotiListViewController = NotiListViewController()
        // let navigation: UINavigationController = UINavigationController(rootViewController: notiListVC)
        // navigation.modalPresentationStyle = .fullScreen
        // present(navigation, animated: true, completion: nil)
    }
    
    func presentDonationDetailVC(donationId: Int) {
        let detailVC: DonationDetailViewController = DonationDetailViewController(donationId: donationId)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // 변경 가능
    func presentAddMyDonationVC() {
        let viewController = UIStoryboard(name: "CreateDonation", bundle: nil).instantiateViewController(withIdentifier: "CreateDonationViewController2")
        let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.isNavigationBarHidden = true
        present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - Methods
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MainMyDonationCollectionViewCell.self, forCellWithReuseIdentifier: myCellIdentifier)
        collectionView.register(MainOngoingDonationCollectionViewCell.self, forCellWithReuseIdentifier: ongoingCellIdentifier)
        collectionView.register(MainOngoingDonationHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ongoingHeaderIdentifier)
        collectionView.register(MainIndicatorCollectionViewCell.self, forCellWithReuseIdentifier: indicatorCellIdentifier)
        collectionView.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    private func setLayout() {
        view.addSubviews([collectionView, titleView])
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(-20)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        titleView.addSubviews([titleLabel, profileButton]) // notiListButton 임시 삭제
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.equalToSuperview().inset(22)
            make.bottom.equalToSuperview().inset(10)
        }
        
        profileButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(titleLabel)
            make.size.equalTo(44)
        }
        
//        notiListButton.snp.makeConstraints { make in
//            make.leading.equalTo(profileButton.snp.trailing)
//            make.trailing.equalToSuperview().inset(10)
//            make.centerY.equalTo(titleLabel)
//            make.size.equalTo(44)
//        }
    }
}

// MARK: - MainViewModelDelegate
extension MainViewController: MainViewModelDelegate {
    func didNicknameChanged(to nickname: String?) {
        titleLabel.text =  "Hi, \(nickname ?? "Guest")"
    }
    
    func didPostsChanged(to posts: [MainPost]) {
        collectionView.reloadData()
    }
    
    func didMyDonationsChanged(to myDonations: [MydonationPost]) {
        collectionView.reloadData()
    }
    
    func failedGetPosts(message: String) {
        showToastMessage(message)
    }
    
    func failedGetMyDonations(message: String) {
        showToastMessage(message)
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    // 스크롤 - 헤더뷰 사이즈 조정
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            if lastMinContentOffset > scrollView.contentOffset.y {
                lastMinContentOffset = scrollView.contentOffset.y
            }
            let maxSize = min(16 - lastMinContentOffset, 25)
            let maxInset = min(13 - lastMinContentOffset, 30)
            titleLabel.font = UIFont(name: "Futura-Bold", size: maxSize)
            titleLabel.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(maxInset)
            }
        } else if self.lastContentOffset < scrollView.contentOffset.y {
            let minSize = max(25 - scrollView.contentOffset.y, 16)
            let minInset = max(30 - scrollView.contentOffset.y, 13)
            titleLabel.font = UIFont(name: "Futura-Bold", size: minSize)
            titleLabel.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(minInset)
            }
            
            lastMinContentOffset = 0
        }
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    // 아이템 터치
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            presentDonationDetailVC(donationId: viewModel.posts[indexPath.item].postID)
        default:
            break
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if viewModel.isEnd {
                return viewModel.posts.count
            }
            return viewModel.posts.count + 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isIndicatorCell(indexPath) {
            viewModel.item = viewModel.posts[indexPath.item - 1].postID - 1
            viewModel.callMainPostsApi { return }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            return getMyDonationCell(indexPath)
        default:
            if isIndicatorCell(indexPath) {
                return getIndicatorCell(indexPath)
            }
            return getDonationCell(indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView: MainOngoingDonationHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ongoingHeaderIdentifier, for: indexPath as IndexPath) as? MainOngoingDonationHeaderView else { return .init() }
            return headerView
        default:
            return .init()
        }
    }
    
    private func isIndicatorCell(_ indexPath: IndexPath) -> Bool {
        if viewModel.posts.isEmpty { return false }
        return indexPath.item == viewModel.posts.count
    }
    
    private func getMyDonationCell(_ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MainMyDonationCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: myCellIdentifier, for: indexPath) as? MainMyDonationCollectionViewCell else { return .init() }
        cell.delegate = self
        cell.viewModel = self.viewModel
        cell.viewModel?.mainMyOngoingDelegate = cell
        return cell
    }
    
    private func getIndicatorCell(_ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MainIndicatorCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: indicatorCellIdentifier, for: indexPath) as? MainIndicatorCollectionViewCell else { return .init() }
        cell.animationIndicatorView()
        return cell
    }
    
    private func getDonationCell(_ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MainOngoingDonationCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ongoingCellIdentifier, for: indexPath) as? MainOngoingDonationCollectionViewCell else { return .init() }
        
        if viewModel.posts.isEmpty { return cell }
        let post = viewModel.posts[indexPath.item]
        let progress = post.goal == 0 ? 100.0 : Float(post.currentAmount) / Float(post.goal)
        cell.setModel(dday: post.endAt, money: post.currentAmount, title: post.title, progress: progress, indexPath: indexPath)
        
        // 이미지 다운로드 후 인덱스 비교하여 셋팅
        cell.setImage(nil)
        guard let urlString: String = post.postImage, let imageURL: URL = URL(string: urlString) else { return cell }
        KingfisherManager.shared.retrieveImage(with: imageURL) { result in
            switch result {
            case .success(let value):
                if cell.isIndexPathEqual(with: indexPath) {
                    cell.setImage(value.image)
                }
            default:
                break
            }
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    // cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            let availableWidth: CGFloat = view.frame.width - (firstSectionInsets.left * 2)
            return CGSize(width: availableWidth, height: 142)
            
        case 1:
            let insetSpace: CGFloat = secondSectionInsets.left * 2
            let paddingSpace: CGFloat = 12 * (itemsPerRow - 1)
            if isIndicatorCell(indexPath) {
                return CGSize(width: view.frame.width - insetSpace, height: 65)
            }
            let availableWidth: CGFloat = view.frame.width - insetSpace - paddingSpace
            let widthPerItem: CGFloat = availableWidth / itemsPerRow
            let heightPerItem: CGFloat = widthPerItem / 159 * 198
            return CGSize(width: widthPerItem, height: heightPerItem)
            
        default:
            return .zero
        }
    }
    
    // section inset
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return firstSectionInsets
        case 1:
            return secondSectionInsets
        default:
            return .zero
        }
    }
    
    // cell 사이의 간격
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 1:
            return 12
        default:
            return 0
        }
    }
    
    // header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 1:
            return CGSize(width: view.frame.width, height: 59)
        default:
            return .zero
        }
    }
}

// MARK: - MainMyDonationCollectionViewCellDelegate
extension MainViewController: MainMyDonationCollectionViewCellDelegate {
    func didSelectAddMyDonationButton() {
        if KeychainManager.isEmptyUserToken() {
            presentLoginVC()
        } else {
            print("🐰 나의 도네이션 추가하기")
            presentAddMyDonationVC()
        }
    }
    
    func didSelectMyOngoingDonationItem(at postId: Int) {
        presentDonationDetailVC(donationId: postId) // viewModel.posts[indexPath.item].postID
    }
}
