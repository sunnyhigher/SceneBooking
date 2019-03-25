//
//  HD_CollectionViewController.swift
//  SceneBooking
//
//  Created by 段新瑞 on 2019/3/25.
//  Copyright © 2019 谢樘飞燕. All rights reserved.
//

import UIKit

class HD_CollectionViewController: HD_BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的收藏"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.tableView.ly_emptyView = self.noDataView;
        self.tableView.ly_showEmpty()
    }
}

extension HD_CollectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
