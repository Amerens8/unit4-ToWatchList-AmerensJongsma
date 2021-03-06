//
//  ToWatchTableViewController.swift
//  ToDoList
//
//  Created by Amerens Geeske Jongsma on 06/05/2018.
//

import UIKit

// subclass to display collection of model
class ToWatchTableViewController: UITableViewController, ToWatchCellDelegate {

    // creating variable of type class ToWatch
    var towatch = [ToWatch]()

    // function to show initial input movies
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem

        if let savedToWatch = ToWatch.loadToWatch() {
            towatch = savedToWatch
        } else {
            towatch = ToWatch.loadSampleToWatchs()
        }
        tableView.reloadData()
    }

    // override methods to show data
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int
    {
        return towatch.count
    }
    
    // method to dequeue cells for new movies
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToWatchCellIdentifier") as? ToWatchCell else {
            fatalError("Could not dequeue a cell")
        }
        
        // when cell dequeued, set self as cell's delegate
        cell.delegate = self
        let watch = towatch[indexPath.row]
        cell.titleLabel?.text = watch.title
        cell.isCompleteButton.isSelected = watch.isComplete
        return cell
    }
    

    // adding swipe to delete functionality possibility
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // defining more closely method to delete movies
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            towatch.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToWatch.saveToWatch(towatch)
        }
    }
    // responding to segue when existing movie is clicked
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let TowatchViewController = segue.destination as! ToWatchViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedTowatch = towatch[indexPath.row]
            TowatchViewController.watch = selectedTowatch
        }
    }
    

    // adding cells for new members
    @IBAction func unwindToToWatchList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! ToWatchViewController
        
        if let watch = sourceViewController.watch {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                towatch[selectedIndexPath.row] = watch
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: towatch.count, section: 0)
                towatch.append(watch)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        ToWatch.saveToWatch(towatch)
    }
    
    // function to check whether mark is tapped and save movies
    func checkmarkTapped(sender: ToWatchCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var watch = towatch[indexPath.row]
            watch.isComplete = !watch.isComplete
            towatch[indexPath.row] = watch
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToWatch.saveToWatch(towatch)
        }
    }
}

