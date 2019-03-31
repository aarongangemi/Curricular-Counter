//
//  loginViewController.swift
//  CurricularCounter
//
//  Created by Aaron Gangemi on 31/1/19.
//  Copyright © 2019 Aaron Gangemi. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
var myCollege : String = ""


class loginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var ref : DatabaseReference!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var schoolField: UITextField!
    @IBOutlet weak var loginButon: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        schoolField.delegate = self
        segmentedControl.selectedSegmentIndex = 0
        nameField.isHidden = true
        schoolField.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func segController(_ sender: Any)
    {
        if segmentedControl.selectedSegmentIndex == 0
        {
            loginButon.titleLabel?.text = "Login"
            nameField.isHidden = true
            schoolField.isHidden = true
        }
        else if segmentedControl.selectedSegmentIndex == 1
        {
            loginButon.titleLabel?.text = "Start"
            nameField.isHidden = false
            schoolField.isHidden = false
        }
    }
    @IBAction func login(_ sender: Any)
    {
        if segmentedControl.selectedSegmentIndex == 1
        {
            guard let email = emailField.text, let password = passwordField.text, let name = nameField.text, let college = schoolField.text
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
                
                let userID = Auth.auth().currentUser?.uid
                self.ref = Database.database().reference(fromURL: "https://extra-curricular-app.firebaseio.com/")
                let userReference = self.ref.child("users").child(college).child((userID!))
                myCollege = college
                let userDefaultsZYX = UserDefaults.standard
                userDefaultsZYX.set(myCollege, forKey: "ZYX")
                let values = ["Academic Name" : name, "Academic Email": email, "College": college]
                userReference.updateChildValues(values, withCompletionBlock: {(err, ref) in
                    if err != nil
                    {
                        print(err!)
                        return
                    }
                    
                    guard (authResult?.user.uid) != nil else{
                        return
                    }
                    print("Saved user successfully into Firebase Database")
                })
            })
        }
        else if segmentedControl.selectedSegmentIndex == 0
        {
            guard let email = emailField.text, let password = passwordField.text
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
