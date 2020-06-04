//
//  MJRefresh_LY.swift
//  MJRefresh_LY
//
//  Created by 阿卡丽 on 2020/3/9.
//

import UIKit
import MJRefresh

public enum MJRefreshLY {
    public static func addRefreshHeaderFor<T: MJRefreshLYProtocol>(aObj: T) -> Void {
        weak var weakObj = aObj
        aObj.contentTable.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            guard let weakObj = weakObj else {
                return
            }
            
            weakObj.lyLoadDatasWithPage(0) { (datas, totalPage) in
                weakObj.contentTable.mj_header?.endRefreshing()
                guard let datas = datas else {
                    weakObj.contentTable.mj_footer?.endRefreshing()
                    return
                }
                weakObj.datas = datas
                let loadedPage = Int(ceil(Double(weakObj.datas.count) / Double(weakObj.pageSize)))

                if let totalPage = totalPage, totalPage > loadedPage {
                    weakObj.contentTable.mj_footer?.resetNoMoreData()
                    weakObj.contentTable.mj_footer?.endRefreshing()
                } else {
                    weakObj.contentTable.mj_footer?.endRefreshingWithNoMoreData()
                }
                weakObj.contentTable.reloadData()
            }
        })
    }
    public static func addRefreshFooterFor<T: MJRefreshLYProtocol>(aObj: T) -> Void {
        weak var weakObj = aObj
        aObj.contentTable.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            guard let weakObj = weakObj else {
                return
            }
            var loadedPage = Int(ceil(Double(weakObj.datas.count) / Double(weakObj.pageSize)))
            weakObj.lyLoadDatasWithPage(loadedPage) { (datas, totalPage) in
                weakObj.contentTable.mj_header?.endRefreshing()
                guard let datas = datas else {
                    weakObj.contentTable.mj_footer?.endRefreshing()
                    return
                }
                weakObj.datas.append(contentsOf: datas)
                loadedPage = Int(ceil(Double(weakObj.datas.count) / Double(weakObj.pageSize)))

                if let totalPage = totalPage, totalPage > loadedPage {
                    weakObj.contentTable.mj_footer?.resetNoMoreData()
                    weakObj.contentTable.mj_footer?.endRefreshing()
                } else {
                    weakObj.contentTable.mj_footer?.endRefreshingWithNoMoreData()
                }
                weakObj.contentTable.reloadData()
            }
        })
    }
}

public protocol MJRefreshLYProtocol: NSObject {
    
    associatedtype T
    
    var contentTable: UITableView { get }
    var datas: [T] { get set }
    var pageSize: Int { get }
    
    func lyLoadDatasWithPage(_ page: Int, complete: @escaping (_ datas: [T]?, _ allPage: Int?) -> Void) -> Void
    
}
