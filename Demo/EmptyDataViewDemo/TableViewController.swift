//
//  TableViewController.swift
//  EmptyDataViewDemo
//
//  Created by USER on 2018/12/11.
//  Copyright © 2018 dd01.leo. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    public var dataType: EmptyDataType = .common
    
    var rows:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        rows = 0
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.tableFooterView = UIView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.asyncAfter()
        }
    }
    
    deinit {
        print(self)
    }
    
    func asyncAfter() {
        rows = 0
        let res = rows == 0 ? false : true
        
        switch dataType {
        case .common:
            tableView.emptyDataView(type: .common, hasData: res)
            
        case .license:
            tableView.emptyDataView(type: .license, hasData: res, showButton: true, btnTitle: "添加") {[weak self] in
                self?.clickAction()
            }
            
        case .activity:
            tableView.emptyDataView(type: .activity, hasData: res)
         
        case .integral:
            tableView.emptyDataView(type: .integral, hasData: res)
            
        case .message:
            tableView.emptyDataView(type: .message, hasData: res)
            
        case .wifi:
            tableView.emptyDataView(type: .wifi, hasData: res, showButton: true, btnTitle: "点击重试") {[weak self] in
                self?.clickAction()
            }
            
        case .search:
            tableView.emptyDataView(type: .search, hasData: res)
            
        case .todo:
            tableView.emptyDataView(type: .todo, hasData: res)
            
        case .comment:
            tableView.emptyDataView(type: .comment, hasData: res)
            
        case .like:
            tableView.emptyDataView(type: .like, hasData: res)
            
        case .custom:
            //emptyDataDelegate一定要设置在加载前面
            tableView.emptyDataDelegate = self
            tableView.emptyDataView(type: .custom, hasData: res, offSet: CGPoint(x: 0, y:-100))
    
        }

        tableView.reloadData()
    }
    
    
    func clickAction() {

        self.rows = 10
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)

        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
}

extension TableViewController: EmptyDataDelegate {
    func emptyData(_ view: UIView) -> EmptyDataConfig {
        let config = EmptyDataConfig(title: "我是自定义", image: UIImage(named: "blankpage_common"))
        return config
    }
}
