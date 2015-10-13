//
//  AddBittVC.swift
//  Bitts
//
//  Created by Hassan Karaouni on 10/10/15.
//  Copyright © 2015 HKII Productions. All rights reserved.
//

import UIKit

protocol AddBittDelegate {
    func addBitt(title: String, text: String)
}

class AddBittVC: UIViewController, UITextViewDelegate {
    @IBOutlet weak var bittTitle: UITextField!
    @IBOutlet weak var bittText: UITextView!
    var textEdited = false
    
    @IBOutlet weak var cancelButton: UIButton!

    var addDelegate: AddBittDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
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
    
    func setupView() {
        //self.view.backgroundColor = UIColor(red: 74.0/255, green: 74.0/255, blue: 74.0/255, alpha: 1)

        cancelButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/4))
        bittTitle.layer.cornerRadius = 5.0
        bittTitle.layer.borderColor = BittConstants.BITT_COLOR.CGColor
        bittTitle.layer.borderWidth = 2
        bittTitle.backgroundColor = BittConstants.BITT_COLOR_FADED

        bittText.delegate = self
        bittText.layer.cornerRadius = 5.0
        bittText.layer.borderColor = BittConstants.BITT_COLOR.CGColor
        bittText.layer.borderWidth = 2
        bittText.backgroundColor = BittConstants.BITT_COLOR_FADED
    }
    
    func textViewDidBeginEditing(bittText: UITextView) {
        if textEdited == false {
            textEdited = true
            bittText.text = ""
        }
    }
    
    func dismissKeyboard() {
        bittText.resignFirstResponder()
        bittTitle.resignFirstResponder()
    }
    
    @IBAction func addBittPressed(sender: UIButton) {
        addDelegate?.addBitt("", text: "")
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
