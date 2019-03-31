//
//  HoursEditViewController.swift
//  CurricularCounter
//
//  Created by Aaron Gangemi on 31/1/19.
//  Copyright © 2019 Aaron Gangemi. All rights reserved.
//

import UIKit
import Firebase

class HoursEditViewController: UIViewController, UITextFieldDelegate {

    var ref : DatabaseReference!
   
    @IBOutlet weak var hourField: UITextField!
    
    @IBAction func Save(_ sender: Any)
    {
        if hourField.text == ""
        {
            hourField.text = "0"
        }
        if hourField.text == " "
        {
            hourField.text = "0"
        }
        curricularHours[myIndex] = curricularHours[myIndex] + Int(hourField.text!)!
        let userDefaultsC = UserDefaults.standard
        userDefaultsC.set(curricularHours, forKey: "C")
        let date = Date()
        let calendar = Calendar.current
        let day = String(calendar.component(.day, from: date))
        let month = String(calendar.component(.month, from: date))
        let year = String(calendar.component(.year, from: date))
        let hour = String(calendar.component(.hour, from: date))
        let minute = String(calendar.component(.minute, from: date))
        let second = String(calendar.component(.second, from: date))
        let temp = hourField.text!
        let calendarString = day + "/" + month + "/" + year + " " + hour + ":" + minute + ":" + second + " | " + temp + " Hours"
        let tempString = curricularName[myIndex] + " | " + calendarString + " at " + LocationArray[myIndex]
        goalArray[myIndex] = goalArray[myIndex] - Int(hourField.text!)!
        let userDefaultsD = UserDefaults.standard
        userDefaultsD.set(goalArray, forKey: "D")
        logArray.append(tempString)
        let userDefaultsH = UserDefaults.standard
        userDefaultsH.set(logArray, forKey: "H")
         let userID = Auth.auth().currentUser?.uid
         self.ref = Database.database().reference(fromURL: "https://extra-curricular-app.firebaseio.com/")
    self.ref.child("users").child(myCollege).child(userID!).child("Curriculars").childByAutoId().setValue(tempString)
        
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        hourField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = "1234567890"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
