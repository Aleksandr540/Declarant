//
//  SearchResultViewController.swift
//  Declarant
//
//  Created by Александр Крюков on 19/08/2019.
//  Copyright © 2019 Александр Крюков. All rights reserved.
//

import UIKit
import SafariServices

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
        tableView.register(UINib(nibName: "ActivityTableViewCell", bundle: nil),  forCellReuseIdentifier: "ActivityTableViewCell")
        
        makeNetworkRequest {
            let alert = UIAlertController(title: "Ошибка", message:"По вашему запросу ничего не найдено", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Понятно", style: .cancel, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func makeNetworkRequest(errorHandler: (() -> Void)?) {
        if !isLoadingNow {
            isLoadingNow = true
            
            NetworkLayer.searchDeclarations(name: nameForSearch) { (accounts, page) in
                self.isLoadingNow = false
                if let accounts = accounts,
                    let page = page {
                    self.currebtPage = page
                    self.title = "Найдено: \(page.totalItems)"
                    self.foundAccounts += accounts
                } else {
                    errorHandler?()
                }
                
            }
        }
    }
    
}

extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if currebtPage == nil {
            return 2
        }
        
        // (общее кол-во / колв=во элемнтов на странице) ->  округлить в большую сторону
        if let curremtPage = currebtPage {
            
            if let totalItems = Double(curremtPage.totalItems) {
                let maxPage = (totalItems / Double(curremtPage.batchSize)).rounded(.up)
                return maxPage > Double(curremtPage.currentPage) ? 2: 1
            }
            
        }
        return 1
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? foundAccounts.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityTableViewCell") as? ActivityTableViewCell
            cell?.activityIndicator.startAnimating()
            return cell!
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell") as? AccountTableViewCell
        cell?.setup(with: foundAccounts[indexPath.row])
        return cell!
    }
    
    func  tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            makeNetworkRequest(errorHandler: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let account = foundAccounts[indexPath.row]
        
        if let pdfLink = account.linkPDF {
            
            let actionSheet = UIAlertController(title: "\(account.firstname) \(account.lastname)", message: "Открыть детальную информацию", preferredStyle: .actionSheet)
            
            actionSheet.addAction(UIAlertAction(title: "Интернет страница", style: .default, handler: { _ in
                if let reportURL = URL(string: NetworkLayer.publicString + account.id) {
                    let safaryVC = SFSafariViewController(url: reportURL)
                    self.present(safaryVC, animated: true, completion: nil)
                }
            }))
            
            actionSheet.addAction(UIAlertAction(title: "PDF", style: .default, handler: { _ in
                if let reportURL = URL(string: pdfLink) {
                    let safaryVC = SFSafariViewController(url: reportURL)
                    self.present(safaryVC, animated: true, completion: nil)
                }
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            
            self.present(actionSheet, animated: true, completion: nil)
            
        } else {
            
            if let reportURL = URL(string: NetworkLayer.publicString + account.id) {
                let safaryVC = SFSafariViewController(url: reportURL)
                self.present(safaryVC, animated: true, completion: nil)
            }
        }
    }
    
}
