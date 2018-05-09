//
//  ToWatchCell.swift
//  ToDoList
//
//  Created by Amerens Geeske Jongsma on 09/05/2018.
//  Copyright © 2018 Amerens Jongsma. All rights reserved.
//

import UIKit
@objc protocol ToWatchCellDelegate: class {
    func checkmarkTapped(sender: ToWatchCell)
}


class ToWatchCell: UITableViewCell {
    var delegate: ToWatchCellDelegate?

    // outlet connection to round button
    @IBOutlet weak var isCompleteButton: UIButton!
    
    //outlet connection to the text LABEL
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBAction func completeButtonTapped() {
        delegate?.checkmarkTapped(sender: self)
    }
    

    
}

