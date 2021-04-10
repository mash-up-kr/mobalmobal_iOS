//
//  ModifyProfileViewController.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/03/20.
//

import SnapKit
import UIKit

class ModifyProfileViewController: DoneBaseViewController {
    // MARK: - UIComponents
    private var profileImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.backgroundColor = .darkGreyThree
        imageView.clipsToBounds = true
        return imageView
    }()
    private let cameraImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.image = UIImage(named: "iconlyLightCamera")
        return image
    }()
    
    private lazy var nickNameView: UIView = ModifyProfileCustomView(imageName: "iconlyLightProfile", inputText: dummyUserName, keyboardType: .default)
    private lazy var phoneNumberView: UIView = ModifyProfileCustomView(imageName: "iconlyLightCall", inputText: dummyUserPhoneNumber, keyboardType: .numberPad)
    private lazy var emailView: UIView = ModifyProfileCustomView(imageName: "iconlyLightMessage", inputText: dummyUserEmail, keyboardType: .emailAddress)
    private lazy var profileTextFieldStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        [nickNameView, phoneNumberView, emailView].forEach {
            stackView.addArrangedSubview($0)
            setStackViewHeight(of: $0)
        }
        stackView.spacing = 28
        return stackView
    }()
    private let modifyCompleteBtn: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("수정완료", for: .normal)
        button.titleLabel?.font = .spoqaHanSansNeo(ofSize: 18, weight: .medium)
        button.setTitleColor(.brownGreyTwo, for: .normal)
        button.backgroundColor = .greyishBrown
        button.layer.cornerRadius = 30
        button.isEnabled = false
        return button
    }()
    // MARK: - Properties
    // dummy data
    private var dummyUserName: String = "모발~모발~"
    private var dummyUserPhoneNumber: String = "01012345678"
    private var dummyUserEmail: String = "mobalmobal@naver.com"
    
    private let imagePicker: UIImagePickerController = UIImagePickerController()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        self.view.backgroundColor = .backgroundColor
        setProfileImgGestureRecognizer()
        setDismissKeyboard()
        setNavigationItems()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func updateViewConstraints() {
        self.view.addSubviews([profileImageView, profileTextFieldStackView, modifyCompleteBtn])
        self.profileImageView.addSubview(cameraImage)
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(40)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        cameraImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        profileTextFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(43)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(15)
        }
        modifyCompleteBtn.snp.makeConstraints { make in
            make.top.equalTo(profileTextFieldStackView.snp.bottom).offset(40)
            make.height.equalTo(60)
            make.width.equalTo(196)
            make.centerX.equalToSuperview()
        }
        super.updateViewConstraints()
    }
    // MARK: - Actions
    @objc
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    // TODO
    // 디자인 및 기획 수정되면 바꿔야합니다!!! 임의로 작업했스밍
    @objc
    private func showActionSheet() {
        let alertController: UIAlertController = UIAlertController(title: "프로필 사진 수정", message: nil, preferredStyle: .actionSheet)
        let selectLibrary: UIAlertAction = UIAlertAction(title: "앨범에서 선택", style: .default) { [weak self]_ in
            self?.getImgFromLibrary()
        }
        let selectCamera: UIAlertAction = UIAlertAction(title: "직접 찍기", style: .default) { [weak self]_ in
            self?.getImgFromCamera()
        }
        let deleteImg: UIAlertAction = UIAlertAction(title: "삭제하기", style: .default) { [weak self]_ in
            self?.profileImageView.image = nil
            self?.cameraImage.isHidden = false
        }
        let cancel: UIAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        [selectLibrary, selectCamera, deleteImg, cancel].forEach { alertController.addAction($0) }
        self.present(alertController, animated: true, completion: nil)
    }
    @objc
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    // MARK: - Methods
    private func setStackViewHeight(of view: UIView) {
        view.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(345)
        }
    }
    private func setProfileImgGestureRecognizer() {
        let gestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showActionSheet))
        profileImageView.isUserInteractionEnabled = true
        self.profileImageView.addGestureRecognizer(gestureRecognizer)
    }
    private func setDismissKeyboard() {
        let gestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    // 아직 dummy 데이터여서 실행시키지는 않았습니다.
    private func modifyCompletedBtnEnable() {
        modifyCompleteBtn.backgroundColor = .lightBluishGreen
        modifyCompleteBtn.titleLabel?.textColor = .blackThree
    }
    private func setNavigationItems() {
        setNavigationItems(title: "프로필 수정", backButtonImageName: "arrowChevronBigLeft", action: #selector(popVC))
    }
    private func getImgFromLibrary() {
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    private func getImgFromCamera() {
        self.imagePicker.sourceType = .camera
        self.imagePicker.cameraCaptureMode = .photo
        self.imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ModifyProfileViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        var newProfileImg: UIImage?
        if let editImage: UIImage = info[.editedImage] as? UIImage {
            newProfileImg = editImage
            cameraImage.isHidden = true
        } else if let originalImage: UIImage = info[.originalImage] as? UIImage {
            newProfileImg = originalImage
            cameraImage.isHidden = true
        }
        self.profileImageView.image = newProfileImg
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UINavigationControllerDelegate
extension ModifyProfileViewController: UINavigationControllerDelegate {
}
