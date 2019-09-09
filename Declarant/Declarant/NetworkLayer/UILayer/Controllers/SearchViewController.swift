//
//  SearchViewController.swift
//  Declarant
//
//  Created by Александр Крюков on 19/08/2019.
//  Copyright © 2019 Александр Крюков. All rights reserved.
//

import UIKit
import SafariServices

class SearchViewController: UIViewController {

    @IBOutlet var nameFieldOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameFieldOutlet.delegate = self 
    }
    @IBAction func searchButtonAction() {
        performSegue(withIdentifier: "showResult", sender: nil)
    }
    @IBAction func reportButtonAction() {
        if let reportURL = URL(string: NetworkLayer.reportString) {
             let safaryVC = SFSafariViewController(url: reportURL)
            
            self.present(safaryVC, animated: true, completion: nil)
        
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            
            let destination = segue.destination as? SearchResultViewController
            
            destination?.nameForSearch = nameFieldOutlet.text ?? ""
            
            let backButton = UIBarButtonItem()
            backButton.title = ""
            navigationItem.backBarButtonItem = backButton
        }
    }
}

// расширим
extension SearchViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButtonAction()
    return true
    }
}
