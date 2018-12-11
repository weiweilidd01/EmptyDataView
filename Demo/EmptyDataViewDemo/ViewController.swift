//
//  ViewController.swift
//  EmptyDataViewDemo
//
//  Created by USER on 2018/12/11.
//  Copyright © 2018 dd01.leo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func nodataAction(_ sender: Any) {
        let vc = TableViewController()
        vc.dataType = .common
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func licenseAction(_ sender: Any) {
        let vc = TableViewController()
        vc.dataType = .license
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func activityAction(_ sender: Any) {
        let vc = TableViewController()
        vc.dataType = .activity
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func integralAction(_ sender: Any) {
        let vc = TableViewController()
        vc.dataType = .integral
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func messageAction(_ sender: Any) {
        let vc = TableViewController()
        vc.dataType = .message
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func noNetAction(_ sender: Any) {
        let vc = TableViewController()
        vc.dataType = .wifi
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func searchAction(_ sender: Any) {
        let vc = TableViewController()
        vc.dataType = .search
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func todoAction(_ sender: Any) {
        let vc = TableViewController()
        vc.dataType = .todo
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func commentAction(_ sender: Any) {
        let vc = TableViewController()
        vc.dataType = .comment
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func likeAction(_ sender: Any) {
        let vc = TableViewController()
        vc.dataType = .like
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func customAction(_ sender: Any) {
        let vc = TableViewController()
        vc.dataType = .custom
        navigationController?.pushViewController(vc, animated: true)
    }
}

