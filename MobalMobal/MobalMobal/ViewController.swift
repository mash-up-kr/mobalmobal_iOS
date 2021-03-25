//
//  ViewController.swift
//  MobalMobal
//
//  Created by 김재희 on 2021/02/20.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // - MARK : 각자 view로 넘어감
    @IBAction private func firstButtonIsTapped(_ sender: UIButton) {
        let viewController = SignupViewController()
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction private func secondButtonIsTapped(_ sender: UIButton) {
        let mainVC: MainViewController = MainViewController()
        mainVC.modalPresentationStyle = .fullScreen
        self.present(mainVC, animated: true, completion: nil)
    }
    
    @IBAction private func thirdButtonIsTapped(_ sender: UIButton) {
        let loginVC: LoginViewController = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }
    
    @IBAction func fourthButtonIsTapped(_ sender: UIButton) {
        let vc = ModifyProfileViewController()
//        let navVc: UINavigationController = UINavigationController(rootViewController: vc)
//        navVc.modalPresentationStyle = .overFullScreen
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
