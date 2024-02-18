//
//  HistoryTVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 17.02.2024.
//

import UIKit

class HistoryTVC: UITableViewCell {
    
    var delegate: MovieProtocol?
    
    let movie: [Movie] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
    }

}
