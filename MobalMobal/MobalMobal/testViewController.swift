//
//  testViewController.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/03/05.
//

import SnapKit
import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        print("✨add")
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        button.snp.makeConstraints{ make in
            make.center.equalToSuperview()
        }
        self.navigationController?.title = "d"
    }
    
    let button: UIButton = {
        let button: UIButton = UIButton()
        button.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        button.backgroundColor = .red
        return button
    }()

    @objc func btnClick(sender: UIButton!) {
        print("✨btn clicked")
        let vc = InputChargingPointViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
