//
//  ToWatchCell.swift
//  ToDoList
//
//  Created by Amerens Geeske Jongsma on 09/05/2018.
//

import UIKit
@objc protocol ToWatchCellDelegate: class {
    func checkmarkTapped(sender: ToWatchCell)
}

// creating a new class for the prototype cells
class ToWatchCell: UITableViewCell {
    var delegate: ToWatchCellDelegate?

    // outlet connection to round button
    @IBOutlet weak var isCompleteButton: UIButton!
    
    //outlet connection to the text LABEL
    @IBOutlet weak var titleLabel: UILabel!
    
    // outlet action in the case when the check button is touched/tapped
    @IBAction func completeButtonTapped() {
        delegate?.checkmarkTapped(sender: self)
    }

}

