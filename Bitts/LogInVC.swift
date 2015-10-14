//
//  LogInVC.swift
//  Bitts
//
//  Created by Hassan Karaouni on 10/13/15.
//  Copyright © 2015 HKII Productions. All rights reserved.
//

import Parse
import UIKit

class LogInVC: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Setup the dismiss gestures for the keyboard.
        let swipe: UISwipeGestureRecognizer =
        UISwipeGestureRecognizer(target: self, action: "dismissKeyboard")
        swipe.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipe)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInPressed(sender: UIButton) {
        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!) { user, error in
            if user != nil {
                self.performSegueWithIdentifier("LogIn", sender: nil)
            } else if let error = error {
                print("Log In Error: \(error)")
            }
        }
    }
    
    func dismissKeyboard() {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
