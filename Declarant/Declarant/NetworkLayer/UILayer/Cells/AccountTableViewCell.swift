//
//  AccountTableViewCell.swift
//  Declarant
//
//  Created by Александр Крюков on 16/08/2019.
//  Copyright © 2019 Александр Крюков. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var pdfIcon: UIImageView!
    @IBOutlet private var placeOfWork: UILabel!
    
    
    func setup(with account: AccountModel) {
        nameLabel.text = "\(account.firstname) \( account.lastname)"
        placeOfWork.text = account.placeOfWork ?? "Неизвестно"
        pdfIcon.isHidden = account.linkPDF == nil
    }
    
}
