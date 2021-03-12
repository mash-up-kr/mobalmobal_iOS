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
    
    @IBAction func secondButtonIsTapped(_ sender: UIButton) {
        
    }
    
    @IBAction private func thirdButtonIsTapped(_ sender: UIButton) {
        let loginVC: LoginViewController = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }
    
    @IBAction func fourthButtonIsTapped(_ sender: UIButton) {
        let successChargingVC: SuccessChargingViewController = SuccessChargingViewController()
        successChargingVC.modalPresentationStyle = .fullScreen
        self.present(successChargingVC, animated: true, completion: nil)
    }
}
