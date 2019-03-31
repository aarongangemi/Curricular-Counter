//
//  ViewController.swift
//  CurricularTracker
//
//  Created by Aaron Gangemi on 11/2/19.
//  Copyright © 2019 Aaron Gangemi. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase

var collegeName : String = ""
class readCCViewController: UIViewController {
    

    @IBOutlet weak var TextFieldCurricular: UITextView!
    
    var ref : DatabaseReference!
    var databaseHandle : DatabaseHandle!
    var snapshotArray : [Substring] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        ref = Database.database().reference(fromURL: "https://extra-curricular-app.firebaseio.com/")
        databaseHandle = ref.child("users").child(collegeName).observe(.childAdded, with: { (snapshot) in
            let curricularData = String(describing: snapshot.value)
            self.snapshotArray = curricularData.split(separator: ")")
            for index in 0...self.snapshotArray.count - 1
            {
                self.TextFieldCurricular.text = self.TextFieldCurricular.text + " " + self.snapshotArray[index] + "\n"
            }
        })
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}


