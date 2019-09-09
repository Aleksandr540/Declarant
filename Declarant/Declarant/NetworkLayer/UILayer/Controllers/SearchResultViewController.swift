//
//  SearchResultViewController.swift
//  Declarant
//
//  Created by Александр Крюков on 19/08/2019.
//  Copyright © 2019 Александр Крюков. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var nameForSearch: String = ""
    
    var currebtPage: PageModel?
    var isLoadingNow = false
    
    var foundAccounts: [AccountModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil),  forCellReuseIdentifier: "AccountTableViewCell")
        
        makeNetworkRequest(errorHandlwr: nil)
    }
    
    func makeNetworkRequest(errorHandlwr: (() -> Void)?) {
        if !isLoadingNow {
            isLoadingNow = true
            
            NetworkLayer.searchDeclarations(name: nameForSearch) { (accounts, page) in
                self.isLoadingNow = false
                if let accounts = accounts,
                    let page = page {
                    self.currebtPage = page
                    self.foundAccounts += accounts
                }
                
            }
        }
    }
    
}

extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return foundAccounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell") as? AccountTableViewCell
        
        cell?.setup(with: foundAccounts[indexPath.row])
        
        return cell!
    }
    
   
}

