//
//  LoginViewController.swift
//  CurricularTracker
//
//  Created by Aaron Gangemi on 11/2/19.
//  Copyright © 2019 Aaron Gangemi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class TeacherLoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pinCode: UITextField!
    var ref : DatabaseReference!
    @IBOutlet weak var login: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        schoolTextField.delegate = self
        pinCode.delegate = self
        emailField.delegate = self
    }
    
    
    @IBAction func loginButton(_ sender: Any)
    {
        collegeName = schoolTextField.text!
        if segmentedControl.selectedSegmentIndex == 1
        {
            guard let email = emailField.text, let password = pinCode.text
                else
            {
                print("Form not valid")
                return
            }
            Auth.auth().createUser(withEmail: email, password: password, completion: {(authResult, error) in
                guard (authResult?.user) != nil else
                {
                    return
                }
                self.ref = Database.database().reference(fromURL: "https://extra-curricular-app.firebaseio.com/")
                self.ref.child("Schools").childByAutoId().setValue(collegeName)
                print("Saved user successfully into Firebase Database")
            })
        }
        else if segmentedControl.selectedSegmentIndex == 0
        {
            guard let email = emailField.text, let password = pinCode.text
                else{
                    print("Invalid sign in")
                    return
            }
            Auth.auth().signIn(withEmail: email, password: password, completion: {(user,error) in
                if error != nil
                {
                    self.dismiss(animated: true, completion: nil)
                    return
                }
            })
        }
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

