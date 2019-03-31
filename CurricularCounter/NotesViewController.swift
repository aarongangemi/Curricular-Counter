//
//  NotesViewController.swift
//  CurricularCounter
//
//  Created by Aaron Gangemi on 31/1/19.
//  Copyright © 2019 Aaron Gangemi. All rights reserved.
//

import UIKit
import Foundation

class NotesViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var notesText: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        notesText.delegate = self
        notesText.text = notesArray[myIndex]


        // Do any additional setup after loading the view.
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool
    {
        notesArray[myIndex] = notesText.text
        let userDefaultsH = UserDefaults.standard
        userDefaultsH.set(notesArray, forKey: "G")
        return true
    }
    
    @IBAction func Save(_ sender: Any)
    {
        notesArray[myIndex] = notesText.text!
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}
