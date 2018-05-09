//
//  ToWatchViewController.swift
//  ToDoList
//
//  Created by Amerens Geeske Jongsma on 07/05/2018.
//


import UIKit

class ToWatchViewController: UITableViewController {
    
    var watch: ToWatch?
    // outlets for the new movie controller
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    
    // actions to perform when user changes date picker, text or when return is pressed
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    @IBAction func returnPressed(_ sender: UITextField) {
    titleTextField.resignFirstResponder()
    }
    
    // action to change the state picture of the button when clicked
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    
    // intial state of the view with known variables and data
    override func viewDidLoad() {
        super.viewDidLoad()
        if let watch = watch {
            navigationItem.title = "To Watch"
            titleTextField.text = watch.title
            isCompleteButton.isSelected = watch.isComplete
            dueDatePickerView.date = watch.dueDate
            notesTextView.text = watch.recommend
        } else {
            // letting the initial state of the data picker be 24 hours in the future
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
    }
    
    
    // making sure the Save Button can only be pressed if there is a text input
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    // creating a new movie input 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text ?? "No Title"
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let recommend = notesTextView.text
        
        watch = ToWatch(title: title, isComplete: isComplete, dueDate: dueDate, recommend: recommend)
    }
    
    
    // making the date picker small when not clicked on yet
    var isEndDatePickerHidden = false
    override func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath) {
        switch (indexPath) {
        case [1,0]:
            isEndDatePickerHidden = !isEndDatePickerHidden
            dueDateLabel.textColor = isEndDatePickerHidden ? .black : tableView.tintColor
            
            tableView.beginUpdates()
            tableView.endUpdates()
        default: break
        }
    }
    
    // helper function to update the date of the struct
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToWatch.dueDateFormatter.string(from: date)
    }
    
}
