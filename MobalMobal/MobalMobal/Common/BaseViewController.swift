//
//  BaseViewController.swift
//  MobalMobal
//
//  Created by 이재성 on 2021/04/10.
//

import UIKit

class DoneBaseViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    deinit {
        Log(.deinit).logger(self)
    }
}