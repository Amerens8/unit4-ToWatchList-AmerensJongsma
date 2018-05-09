//
//  toWatch.swift
//  ToDoList
//
//  Created by Amerens Geeske Jongsma on 06/05/2018.
//

import Foundation

struct ToWatch: Codable {
    
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var recommend: String?
    
    // creating a Dateformatter to be used in all instances of the model
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    // path to store data
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("towatch").appendingPathExtension("plist")
    
    static func loadToWatch() -> [ToWatch]?  {
        guard let codedToWatch = try? Data(contentsOf: ArchiveURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToWatch>.self, from: codedToWatch)
    }
    

    // define some initial movies to watch on the list
    static func loadSampleToWatchs() -> [ToWatch] {
        let towatch1 = ToWatch(title: "The Truman Show", isComplete: false, dueDate: Date(), recommend: "Recommended by Jette")
        let towatch2 = ToWatch(title: "Legally Blond", isComplete: false, dueDate: Date(), recommend: "Recommended by Jacob")
        let towatch3 = ToWatch(title: "Dirty Dancing", isComplete: false, dueDate: Date(), recommend: "Recommended by Jette")
        
        return [towatch1, towatch2, towatch3]
    }
    
    static func saveToWatch(_ towatch: [ToWatch]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToWatch = try? propertyListEncoder.encode(towatch)
        try? codedToWatch?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
    

}
