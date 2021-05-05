//
//  UIViewController+Extension.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/27.
//

import Toast
import UIKit

extension UIViewController {
    func setNavigationItems(title: String, backButtonImageName: String, action: Selector?) {
        navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = title
        
        guard let backButtonImage: UIImage = UIImage(named: backButtonImageName) else { return }
        let backButton: UIBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: action)
        navigationItem.leftBarButtonItem = backButton
    }
    
    func alertController(_ message: String) {
        let alertController: UIAlertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let alertAction: UIAlertAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showToastMessage(_ message: String) {
        let toastPoint: CGPoint = CGPoint(x: view.frame.midX, y: view.frame.maxY - 60)
        view.makeToast(message, duration: 2.0, point: toastPoint, title: nil, image: nil, completion: nil)
    }
}
