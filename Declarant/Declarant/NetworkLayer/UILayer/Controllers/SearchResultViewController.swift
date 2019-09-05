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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil),  forCellReuseIdentifier: "AccountTableViewCell")
    }
    
}

extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell") as? AccountTableViewCell
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

