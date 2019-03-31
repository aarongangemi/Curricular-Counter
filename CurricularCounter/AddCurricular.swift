//
//  AddCurricular.swift
//  CurricularCounter
//
//  Created by Aaron Gangemi on 31/1/19.
//  Copyright © 2019 Aaron Gangemi. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications
import Firebase
class AddCurricular: UIViewController, UITextFieldDelegate {

    var ref : DatabaseReference!
    @IBOutlet weak var segSwitch: UISwitch!
    @IBOutlet weak var NameOfCurricular: UITextField!
    @IBOutlet weak var CurricularLocation: UITextField!
    @IBOutlet weak var noOfHours: UITextField!
    @IBOutlet weak var goalHours: UITextField!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    private var startDatePicker : UIDatePicker?
    private var endDatePicker : UIDatePicker?
    @IBOutlet weak var NotesField: UITextField!
    
    @IBAction func Save(_ sender: Any)
    {
        if (NameOfCurricular.text?.isEmpty)!
        {
            NameOfCurricular.text = "Unknown"
        }
        if (noOfHours.text?.isEmpty)!
        {
            noOfHours.text = "0"
        }
        if (goalHours.text?.isEmpty)!
        {
            goalHours.text = "0"
        }
        if (NotesField.text?.isEmpty)!
        {
            NotesField.text = " "
        }
        if (CurricularLocation.text?.isEmpty)!
        {
            CurricularLocation.text = "Australia"
        }
        if (startDate.text?.isEmpty)!
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
            startDate.text = dateFormatter.string(from: Date())
        }
        if (endDate.text?.isEmpty)!
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
            endDate.text = dateFormatter.string(from: Date())
        }
        
        curricularName.append(NameOfCurricular.text!)
        curricularHours.append(Int(noOfHours.text!)!)
        LocationArray.append(CurricularLocation.text!)
        startDateArray.append(startDate.text!)
        endDateArray.append(endDate.text!)
        goalArray.append(Int(goalHours.text!)!)
        notesArray.append(NotesField.text!)
        let notificationString = self.NameOfCurricular.text!
        let date = Date()
        let calendar = Calendar.current
        let day = String(calendar.component(.day, from: date))
        let month = String(calendar.component(.month, from: date))
        let year = String(calendar.component(.year, from: date))
        let hour = String(calendar.component(.hour, from: date))
        let minute = String(calendar.component(.minute, from: date))
        let second = String(calendar.component(.second, from: date))
        let temp = noOfHours.text!
        let calendarString = day + "/" + month + "/" + year + " " + hour + ":" + minute + ":" + second + " | " + temp + " Hours"
        let tempString = NameOfCurricular.text! + " | " + calendarString + " at " + CurricularLocation.text!
        logArray.append(tempString)
        if segSwitch.isOn
        {
            let center = UNUserNotificationCenter.current()
            let options: UNAuthorizationOptions = [.alert];
            center.requestAuthorization(options: options) { (granted, error) in
                if !granted
                {
                    print("Something went wrong")
                }
                else
                {
                    let content = UNMutableNotificationContent()
                    content.title = NSString.localizedUserNotificationString(forKey: "Extra-Curricular Due Date reached", arguments: nil)
                    let contentString = notificationString + " has Expired"
                    content.body = NSString.localizedUserNotificationString(forKey: contentString, arguments: nil)
                    let endDateX = self.convertToDate()
                    let calendar = Calendar.current
                    let year = calendar.component(.year, from: endDateX)
                    let month = calendar.component(.month, from: endDateX)
                    let day = calendar.component(.day, from: endDateX)
                    let hour = calendar.component(.hour, from: endDateX)
                    let minute = calendar.component(.minute, from: endDateX)
                    var dateComponents = DateComponents()
                    dateComponents.calendar = calendar
                    dateComponents.year = year
                    dateComponents.month = month
                    dateComponents.day = day
                    dateComponents.hour = hour
                    dateComponents.minute = minute
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                    let uuidString = UUID().uuidString
                    let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
                    let notificationCenter = UNUserNotificationCenter.current()
                    notificationCenter.add(request) { (error) in
                        if error != nil {
                            //sender.isOn = false
                        }
                    }
                }
            }
        }
        
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
        
        let userID = Auth.auth().currentUser?.uid
        self.ref = Database.database().reference(fromURL: "https://extra-curricular-app.firebaseio.com/")
       
        let userDefaultsCollege = UserDefaults.standard
        myCollege = (userDefaultsCollege.string(forKey: "ZYX")!)
        self.ref.child("users").child(myCollege).child(userID!).child("Curriculars").childByAutoId().setValue(tempString)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segSwitch.setOn(false, animated: true)
        noOfHours.delegate = self
        goalHours.delegate = self
        startDatePicker = UIDatePicker()
        endDatePicker = UIDatePicker()
        startDatePicker?.datePickerMode = .dateAndTime
        startDatePicker?.addTarget(self, action: #selector(AddCurricular.dateChanged(datePicker:)), for: .valueChanged)
        endDatePicker?.datePickerMode = .dateAndTime
        endDatePicker?.addTarget(self, action: #selector(AddCurricular.dateChanged(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddCurricular.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        startDate.inputView = startDatePicker
        endDate.inputView = endDatePicker
        // Do any additional setup after loading the view.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = "1234567890"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }
    
    
    @objc func viewTapped(gestureRecognizer : UITapGestureRecognizer)
    {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker : UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        startDate.text = dateFormatter.string(from: (startDatePicker?.date)!)
        endDate.text = dateFormatter.string(from: (endDatePicker?.date)!)
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField)
    {
        textField.text = ""
    }
    
    
    func convertToDate() -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        let endDate = dateFormatter.date(from: endDateArray[myIndex])
        return endDate!
    }

}
