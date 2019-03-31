//
//  TableViewViewController.swift
//  CurricularCounter
//
//  Created by Aaron Gangemi on 30/1/19.
//  Copyright © 2019 Aaron Gangemi. All rights reserved.
//

import UIKit
var curricularName : [String] = []
var curricularHours : [Int] = []
var LocationArray : [String] = []
var goalArray : [Int] = []
var startDateArray : [String] = []
var endDateArray : [String] = []
var notesArray : [String] = []
var logArray : [String] = []
var myIndex = 0

class TableViewController: UITableViewController
{
    override func viewDidLoad()
    {
      /*  super.viewDidLoad()
      curricularName.removeAll()
        LocationArray.removeAll()
        curricularHours.removeAll()
        goalArray.removeAll()
        startDateArray.removeAll()
        endDateArray.removeAll()
        notesArray.removeAll()
        logArray.removeAll()
        
        let userDefaultsA = UserDefaults.standard
        userDefaultsA.set(curricularName, forKey: "A")
        
        let userDefaultsB = UserDefaults.standard
        userDefaultsB.set(LocationArray, forKey: "B")
        
        let userDefaultsC = UserDefaults.standard
        userDefaultsC.set(curricularHours, forKey: "C")
        
        let userDefaultsD = UserDefaults.standard
        userDefaultsD.set(goalArray, forKey: "D")
        
        let userDefaultsE = UserDefaults.standard
        userDefaultsE.set(startDateArray, forKey: "E")
        
        let userDefaultsF = UserDefaults.standard
        userDefaultsF.set(endDateArray, forKey: "F")
        
        let userDefaultsG = UserDefaults.standard
        userDefaultsG.set(notesArray, forKey: "G")
        
        let userDefaultsH = UserDefaults.standard
        userDefaultsH.set(logArray, forKey: "H")*/
        
        let userDefaultsName = UserDefaults.standard
        curricularName = (userDefaultsName.object(forKey: "A") as? [String])!
        let userDefaultsLocation = UserDefaults.standard
        LocationArray = (userDefaultsLocation.object(forKey: "B") as? [String])!
        let userDefaultsHours = UserDefaults.standard
        curricularHours = (userDefaultsHours.object(forKey: "C") as? [Int])!
        let userDefaultsGoals = UserDefaults.standard
        goalArray = (userDefaultsGoals.object(forKey: "D") as? [Int])!
        let userDefaultsStart = UserDefaults.standard
        startDateArray = (userDefaultsStart.object(forKey: "E") as? [String])!
        let userDefaultsEnd = UserDefaults.standard
        endDateArray = (userDefaultsEnd.object(forKey: "F") as? [String])!
        let userDefaultsNotes = UserDefaults.standard
        notesArray = (userDefaultsNotes.object(forKey: "G") as? [String])!
        let userDefaultsLog = UserDefaults.standard
        logArray = (userDefaultsLog.object(forKey: "H") as? [String])!
      
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return curricularName.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = curricularName[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "Segue", sender: self)
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            curricularName.remove(at: indexPath.row)
            curricularHours.remove(at: indexPath.row)
            LocationArray.remove(at: indexPath.row)
            goalArray.remove(at: indexPath.row)
            startDateArray.remove(at: indexPath.row)
            endDateArray.remove(at: indexPath.row)
            notesArray.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            let userDefaultsA = UserDefaults.standard
            userDefaultsA.set(curricularName, forKey: "A")
            
            let userDefaultsB = UserDefaults.standard
            userDefaultsB.set(LocationArray, forKey: "B")
            
            let userDefaultsC = UserDefaults.standard
            userDefaultsC.set(curricularHours, forKey: "C")
            
            let userDefaultsD = UserDefaults.standard
            userDefaultsD.set(goalArray, forKey: "D")
            
            let userDefaultsE = UserDefaults.standard
            userDefaultsE.set(startDateArray, forKey: "E")
            
            let userDefaultsF = UserDefaults.standard
            userDefaultsF.set(endDateArray, forKey: "F")
            
            let userDefaultsG = UserDefaults.standard
            userDefaultsG.set(notesArray, forKey: "G")
            
            let userDefaultsH = UserDefaults.standard
            userDefaultsH.set(logArray, forKey: "H")
            
        }
    }
    
}
