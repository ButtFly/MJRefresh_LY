# MJRefresh_LY

[![CI Status](https://img.shields.io/travis/ButtFly/MJRefresh_LY.svg?style=flat)](https://travis-ci.org/ButtFly/MJRefresh_LY)
[![Version](https://img.shields.io/cocoapods/v/MJRefresh_LY.svg?style=flat)](https://cocoapods.org/pods/MJRefresh_LY)
[![License](https://img.shields.io/cocoapods/l/MJRefresh_LY.svg?style=flat)](https://cocoapods.org/pods/MJRefresh_LY)
[![Platform](https://img.shields.io/cocoapods/p/MJRefresh_LY.svg?style=flat)](https://cocoapods.org/pods/MJRefresh_LY)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```
class ViewController: UIViewController {
    
    /// 协议的 contentTable
    let contentTable = UITableView()
    
    /// 协议的 datas
    var datas: [URL?]? = nil
    
    /// 协议的 pageSize
    var pageSize: Int = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(contentTable)
        contentTable.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
        contentTable.delegate = self
        contentTable.dataSource = self
        contentTable.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        MJRefreshLY.addRefreshHeaderFor(aObj: self)
        MJRefreshLY.addRefreshFooterFor(aObj: self)
    }
    
    func getSouceUrlWithPage(_ page: Int, pageSize: Int) -> [URL?] {
        
        let arr = ["url", ...]
        let count = arr.count
        
        var res = [URL?]()
        
        let start = page * pageSize
        for i in 0..<pageSize {
            let idx = (start + i) % count
            res.append(URL(string: arr[idx]))
        }
        return res
        
    }


}


/// 遵循协议，协议的属性在上面已经给出
extension ViewController: MJRefreshLYProtocol {
    
    /// 协议的加载方法，去请求指定页面大小的第几页数据
    func lyLoadDatasWithPage(_ page: Int, pageSize: Int, complete: @escaping ([URL?]?, Int?) -> Void) {
        complete(getSouceUrlWithPage(page, pageSize: pageSize), nil)
    }
    
    typealias T = URL?
    
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        guard let datas = datas else {
            return cell
        }
        cell.textLabel?.text = datas[indexPath.row]?.absoluteString
        return cell
    }
    
    
}
```

## Installation

MJRefresh_LY is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MJRefresh_LY'
```

## Author

ButtFly, 315585758@qq.com

## License

MJRefresh_LY is available under the MIT license. See the LICENSE file for more info.
