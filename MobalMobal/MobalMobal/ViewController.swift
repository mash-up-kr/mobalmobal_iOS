//
//  ViewController.swift
//  MobalMobal
//
//  Created by 김재희 on 2021/02/20.
//

import UIKit

class ViewController: DoneBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // - MARK : 각자 view로 넘어감
    @IBAction private func firstButtonIsTapped(_ sender: UIButton) {
        let vc: SignupViewController = SignupViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func secondButtonIsTapped(_ sender: UIButton) {
        let mainVC: MainViewController = MainViewController(viewModel: MainViewModel())
        mainVC.modalPresentationStyle = .fullScreen
        self.present(mainVC, animated: true, completion: nil)
    }
    
    @IBAction private func thirdButtonIsTapped(_ sender: UIButton) {
        let loginVC: LoginViewController = LoginViewController()
        let navVc: UINavigationController = UINavigationController(rootViewController: loginVC)
        navVc.modalPresentationStyle = .fullScreen
        self.present(navVc, animated: true)
//        loginVC.modalPresentationStyle = .fullScreen
//        self.present(loginVC, animated: true)
//        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func fourthButtonIsTapped(_ sender: UIButton) {
        let vc = PointChargingViewController()
        let navVc: UINavigationController = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .overFullScreen
//        vc.modalPresentationStyle = .fullScreen
        self.present(navVc, animated: true, completion: nil)
    }
}
