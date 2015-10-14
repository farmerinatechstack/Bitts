//
//  SignUpVC.swift
//  Bitts
//
//  Created by Hassan Karaouni on 10/13/15.
//  Copyright © 2015 HKII Productions. All rights reserved.
//

import Parse
import UIKit

class SignUpVC: UIViewController {
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
    
    @IBAction func signUpPressed(sender: UIButton) {
        let user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackgroundWithBlock {succeeded, error in
            if (succeeded) {
                self.performSegueWithIdentifier("SignUpLogIn", sender: nil)
            } else if let error = error {
                print("Signup Error: \(error)")
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
