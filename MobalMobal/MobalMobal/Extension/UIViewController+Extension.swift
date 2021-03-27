//
//  UIViewController+Extension.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/27.
//

import UIKit
extension UIViewController {
 
    func setNavigationItems(title: String, backButtonImageName: String, action: Selector?) {
        self.navigationItem.title = title
        
        guard let backButtonImage: UIImage = UIImage(named: backButtonImageName) else { return }
        let backButton: UIBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: action)
        navigationItem.leftBarButtonItem = backButton
    }
}
