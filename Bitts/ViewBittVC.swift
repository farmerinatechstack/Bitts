//
//  ViewBittVC.swift
//  Bitts
//
//  Created by Hassan Karaouni on 10/10/15.
//  Copyright © 2015 HKII Productions. All rights reserved.
//

import UIKit

class ViewBittVC: UIViewController {
    @IBOutlet weak var bittTitle: UITextField!
    @IBOutlet weak var bittText: UITextView!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    var bittTitleStr = ""
    var bittTextStr = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        //self.view.backgroundColor = UIColor(red: 74.0/255, green: 74.0/255, blue: 74.0/255, alpha: 1)
        
        cancelButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/4))
        
        bittTitle.text = bittTitleStr
        bittTitle.layer.cornerRadius = 5.0
        bittTitle.layer.borderColor = BittConstants.BITT_COLOR.CGColor
        bittTitle.layer.borderWidth = 2
        bittTitle.backgroundColor = BittConstants.BITT_COLOR_FADED

        bittText.text = bittTextStr
        bittText.layer.cornerRadius = 5.0
        bittText.layer.borderColor = BittConstants.BITT_COLOR.CGColor
        bittText.layer.borderWidth = 2
        bittText.backgroundColor = BittConstants.BITT_COLOR_FADED
    }
}

