//
//  TermsOfServiceViewController.swift
//  StarzSettings
//
//  Created by Anthony Picciano on 11/13/15.
//  Copyright © 2015 Anthony Picciano. All rights reserved.
//

import UIKit

import StarzLegal

class TermsOfServiceViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.selectable = true
        self.textView.panGestureRecognizer.allowedTouchTypes = [UITouchType.Indirect.rawValue]

        TermsOfService.sharedInstance.loadTermsOfServiceText { (result, error) -> Void in
            if let result = result {
                self.textView.text = result
            }
        }
    }

}
