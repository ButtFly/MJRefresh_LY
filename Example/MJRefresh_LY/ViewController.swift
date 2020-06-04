//
//  ViewController.swift
//  MJRefresh_LY
//
//  Created by ButtFly on 03/09/2020.
//  Copyright (c) 2020 ButtFly. All rights reserved.
//

import UIKit
import MJRefresh_LY

class ViewController: UIViewController, MJRefreshLYProtocol {
    
    typealias T = String
    
    var contentTable: UITableView = UITableView(frame: .zero)
    
    var datas: [String] = [String]()
    
    var pageSize: Int = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(contentTable)
        contentTable.frame = view.bounds
        contentTable.dataSource = self
        contentTable.delegate = self
        contentTable.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        MJRefreshLY.addRefreshHeaderFor(aObj: self)
        MJRefreshLY.addRefreshFooterFor(aObj: self)
    }                                                                                  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func lyLoadDatasWithPage(_ page: Int, complete: @escaping ([String]?, Int?) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2) {
            DispatchQueue.main.async {
                if page < 9 {
                    complete(["时间段\(page)", "就是", "下是", "华盛顿", "网页", "污水", "一点半", "遇人不淑", "有啥办法", "我还是"], 10)
                } else {
                    complete(["时间段\(page)"], 10)
                }
            }
        }
    }

}






extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let str = datas[indexPath.row]
        cell.textLabel?.text = str
        return cell
    }
    
    
    
    
}




