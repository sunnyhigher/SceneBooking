//
//  HD_HomeViewController.swift
//  SceneBooking
//
//  Created by 段新瑞 on 2019/3/20.
//  Copyright © 2019 谢樘飞燕. All rights reserved.
//

import UIKit

class HD_HomeViewController: HD_BaseVC {

    var homeModelList: [HD_HomeListModel] = []
    
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
        reloadListData(true)
    }
    
    func customUI() {
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.backgroundColor = UIColor.mainBg
        self.navigationItem.title = "首页"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.HD_registerCell(cell: HD_HomeListTableViewCell.self)
        self.addMJRefresh()
    }
    
    func addMJRefresh() {
        /// 顶部刷新
        tableView.mj_header = HD_RefreshHeader(refreshingBlock: { [weak self] in
            self!.tableView.mj_header.endRefreshing()
            self!.reloadListData(true)
        })
        
        tableView.mj_footer = HD_RefreshFooter(refreshingBlock: { [weak self] in
            self!.reloadListData(false)
        })
    }
    
    /// 获取美甲列表数据
    func reloadListData(_ isRefresh: Bool) {
        self.tableView.ly_startLoading()
        let indexPage = page
        if isRefresh == true {
            self.showLoading()
            page = 0
        }
        let provider = HD_Network<HD_NetworManager>()
        provider.request(HD_NetworManager.homeList(page), sucess: { (json) in
            self.hidenLoading()
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            guard let json = json else { return }
            /// 下拉刷新,删除之前所有元素
            if isRefresh == true {
                self.homeModelList.removeAll()
            }
            let dict = json["root"] as! NSDictionary
            let objectsArrays = dict["list"] as? [Any];
            let modelList = [HD_HomeListModel].deserialize(from: objectsArrays) as! [HD_HomeListModel]
            self.homeModelList = self.homeModelList + modelList
            HDlog(self.homeModelList.first?.title)
            self.tableView.reloadData()
            self.tableView.ly_emptyView = self.noDataView;
            self.tableView.ly_endLoading()
            self.page += 1
        }) { (error) in
            if isRefresh == true { self.page = indexPage }
            self.hidenLoading()
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            self.tableView.reloadData()
            self.tableView.ly_emptyView = self.noNetworkView
            self.tableView.ly_endLoading()
        }
    }
    
    override func reloadNetworkData() {
        reloadListData(true)
    }
    
}

extension HD_HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.homeModelList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.HD_dequeueReusableCell(indexPath: indexPath) as HD_HomeListTableViewCell
        let model = self.homeModelList.safeObject(indexPath.section)
        if let model = model {
            let url = URL(string: model.imglink.urlEncoded())
            let resource = ImageResource(downloadURL: url!)
            cell.contentImage.kf.setImage(with: resource, placeholder:R.image.icon_no_map())
            cell.titleLabel.text = model.title
            cell.otherLabel.text = " 分享 \(model.sharearts) 阅读 \(model.readarts) 喜欢 \(model.likecount)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.homeModelList.safeObject(indexPath.section)
        if let model = model {
            /*
            let webViewVC = HD_WebVC()
            webViewVC.title = "详情"
            webViewVC.url = model.url.urlEncoded()
            self.rt_navigationController.pushViewController(webViewVC, animated: true)
             */
            
            let webVC = HD_DetailViewController()
            webVC.urlStr = model.url.urlEncoded()
            self.rt_navigationController.pushViewController(webVC, animated: true)
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
}
