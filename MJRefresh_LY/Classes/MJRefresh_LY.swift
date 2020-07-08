//
//  MJRefresh_LY.swift
//  MJRefresh_LY
//
//  Created by 阿卡丽 on 2020/3/9.
//

import UIKit
import MJRefresh

public enum MJRefreshLY {
    
    /// 最短显示时间，防止加载过快的时候，动画一闪而过
    public static var minShowTime: Double = 0.5
    
    public static func addRefreshHeaderFor<T: MJRefreshLYProtocol>(aObj: T) -> Void {
        weak var weakObj = aObj
        aObj.contentTable.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            guard let weakObj = weakObj else {
                return
            }
            let start = Date.timeIntervalSinceReferenceDate
            weakObj.lyLoadDatasWithPage(0, pageSize: weakObj.pageSize) { (datas, totalPage) in
                let end = Date.timeIntervalSinceReferenceDate
                let min = minShowTime > 0 ? minShowTime : 0
                let d = end - start
                if d < min {
                    DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + min - d) {
                        DispatchQueue.main.async {
                            endRefresh(weakObj: weakObj, datas: datas, totalPage: totalPage)
                        }
                    }
                } else {
                    endRefresh(weakObj: weakObj, datas: datas, totalPage: totalPage)
                }
            }
        })
    }
    public static func addRefreshFooterFor<T: MJRefreshLYProtocol>(aObj: T) -> Void {
        weak var weakObj = aObj
        aObj.contentTable.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            guard let weakObj = weakObj else {
                return
            }
            let start = Date.timeIntervalSinceReferenceDate
            let loadedPage = Int(ceil(Double(weakObj.datas?.count ?? 0) / Double(weakObj.pageSize)))
            weakObj.lyLoadDatasWithPage(loadedPage, pageSize: weakObj.pageSize) { (datas, totalPage) in
                let end = Date.timeIntervalSinceReferenceDate
                let min = minShowTime > 0 ? minShowTime : 0
                let d = end - start
                if d < min {
                    DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + min - d) {
                        DispatchQueue.main.async {
                            endLoadMore(weakObj: weakObj, datas: datas, totalPage: totalPage)
                        }
                    }
                } else {
                    endLoadMore(weakObj: weakObj, datas: datas, totalPage: totalPage)
                }
            }
        })
        aObj.contentTable.mj_footer?.isHidden = (aObj.datas?.count ?? 0) == 0
    }
    
    fileprivate static func endRefresh<T: MJRefreshLYProtocol>(weakObj: T, datas: [T.T]?, totalPage: Int?) -> Void {
        
        weakObj.contentTable.mj_header?.endRefreshing()
        guard let datas = datas else {
            weakObj.contentTable.mj_footer?.endRefreshing()
            return
        }
        weakObj.datas = datas
        let loadedPage = Int(ceil(Double(weakObj.datas?.count ?? 0) / Double(weakObj.pageSize)))
        
        if (totalPage == nil) || (totalPage! > loadedPage) {
            weakObj.contentTable.mj_footer?.resetNoMoreData()
            weakObj.contentTable.mj_footer?.endRefreshing()
        } else {
            weakObj.contentTable.mj_footer?.endRefreshingWithNoMoreData()
        }
        weakObj.contentTable.mj_footer?.isHidden = (weakObj.datas?.count ?? 0) == 0
        weakObj.contentTable.reloadData()
        
    }
    
    fileprivate static func endLoadMore<T: MJRefreshLYProtocol>(weakObj: T, datas: [T.T]?, totalPage: Int?) -> Void {
        weakObj.contentTable.mj_header?.endRefreshing()
        guard let datas = datas else {
            weakObj.contentTable.mj_footer?.endRefreshing()
            return
        }
        if weakObj.datas == nil {
            weakObj.datas = [T.T]()
        }
        weakObj.datas!.append(contentsOf: datas)
        let loadedPage = Int(ceil(Double(weakObj.datas!.count) / Double(weakObj.pageSize)))
        
        if (totalPage == nil) || (totalPage! > loadedPage) {
            weakObj.contentTable.mj_footer?.resetNoMoreData()
            weakObj.contentTable.mj_footer?.endRefreshing()
        } else {
            weakObj.contentTable.mj_footer?.endRefreshingWithNoMoreData()
        }
        weakObj.contentTable.mj_footer?.isHidden = (weakObj.datas?.count ?? 0) == 0
        weakObj.contentTable.reloadData()
    }
    
}

public protocol MJRefreshLYProtocol: NSObject {
    
    associatedtype T
    
    var contentTable: UITableView { get }
    var datas: [T]? { get set }
    var pageSize: Int { get }
    
    func lyLoadDatasWithPage(_ page: Int, pageSize: Int, complete: @escaping (_ datas: [T]?, _ allPage: Int?) -> Void) -> Void
    
}


