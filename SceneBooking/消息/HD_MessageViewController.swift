//
//  HD_MessageViewController.swift
//  SceneBooking
//
//  Created by 段新瑞 on 2019/3/20.
//  Copyright © 2019 谢樘飞燕. All rights reserved.
//

import UIKit

class HD_MessageViewController: HD_BaseVC {

    var modelList: [HD_MessageModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "消息"
        customUI()
        reloadListData()
    }
    
    func customUI() {
        addMJRefresh()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.HD_registerCell(cell: HD_MessageTableViewCell.self)
    }
    
    func addMJRefresh() {
        /// 顶部刷新
        tableView.mj_header = HD_RefreshHeader(refreshingBlock: { [weak self] in
            self!.tableView.mj_header.endRefreshing()
            self!.reloadListData()
        })
    }
    
    /// 获取美甲列表数据
    func reloadListData() {
        self.tableView.ly_startLoading()
        showLoading()
        let provider = HD_Network<HD_NetworManager>()
        provider.request(HD_NetworManager.messageList(), sucess: { (json) in
            self.hidenLoading()
            self.tableView.mj_header.endRefreshing()
            guard let json = json else { return }
            let jsonArrays = json["message"] as? [Any];
            self.modelList = [HD_MessageModel].deserialize(from: jsonArrays) as! [HD_MessageModel]
            self.tableView.reloadData()
            self.tableView.ly_emptyView = self.noDataView;
            self.tableView.ly_endLoading()
            
        }) { (error) in
            self.hidenLoading()
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
            self.tableView.ly_emptyView = self.noNetworkView
            self.tableView.ly_endLoading()
        }
    }
    
    
}

extension HD_MessageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.HD_dequeueReusableCell(indexPath: indexPath) as HD_MessageTableViewCell
        let model = self.modelList[indexPath.row]
        cell.contentLabel.text = model.message_content ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

