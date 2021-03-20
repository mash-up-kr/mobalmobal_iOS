//
//  ModifyProfileViewController.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/03/20.
//

import SnapKit
import UIKit

class ModifyProfileViewController: UIViewController {
    // MARK: - UIComponents
    private lazy var profileImageView: UIImageView = {
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
    
    private lazy var nickNameView: UIView = ModifyProfileCustomView(imageName: "iconlyLightProfile", inputText: dummyUserName)
    private lazy var phoneNumberView: UIView = ModifyProfileCustomView(imageName: "iconlyLightCall", inputText: dummyUserPhoneNumber)
    private lazy var emailView: UIView = ModifyProfileCustomView(imageName: "iconlyLightMessage", inputText: dummyUserEmail)
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
        return button
    }()
    // MARK: - Properties
    // dummy data
    var dummyUserName = "Jercy"
    let dummyUserPhoneNumber = "01012345678"
    let dummyUserEmail = "mobalmobal@naver.com"
    
    private let imagePicker: UIImagePickerController = UIImagePickerController()
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        setProfileImgGestureRecognizer()
        self.imagePicker.delegate = self
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
    func getProfileImgByLibrary() {
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Methods
    func setStackViewHeight(of view: UIView) {
        view.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(345)
        }
    }
    func setProfileImgGestureRecognizer() {
        let gestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(getProfileImgByLibrary))
        profileImageView.isUserInteractionEnabled = true
        self.profileImageView.addGestureRecognizer(gestureRecognizer)
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
