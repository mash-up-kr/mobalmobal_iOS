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
    @IBAction func firstButtonIsTapped(_ sender: UIButton) {
       
    }
    
    @IBAction func secondButtonIsTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func thirdButtonIsTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func fourthButtonIsTapped(_ sender: UIButton) {
       let chargingInputVC: InputChargingPointViewController = InputChargingPointViewController()
        chargingInputVC.modalPresentationStyle = .fullScreen
        self.present(chargingInputVC, animated: true, completion: nil)
    }
}

