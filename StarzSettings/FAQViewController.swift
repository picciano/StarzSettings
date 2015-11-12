//
//  FAQViewController.swift
//  StarzSettings
//
//  Created by Anthony Picciano on 11/12/15.
//  Copyright © 2015 Anthony Picciano. All rights reserved.
//

import UIKit
import StarzLegal

class FAQViewController: UIViewController {

    @IBOutlet weak var faqTextView: UITextView!
    @IBOutlet weak var faqSectionStackView: UIStackView!
    
    var faqs:Array<Section>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        FAQ.sharedInstance.loadFAQs { (result, error) -> Void in
            if let result = result {
                self.faqs = result
                self.updateView()
            }
        }
    }

    func updateView() {
        for section in self.faqs! {
            let label = UILabel()
            label.text = section.name
            label.font = UIFont.boldSystemFontOfSize(32)
            self.faqSectionStackView.addArrangedSubview(label)
        }
        
        if let section = self.faqs?.first {
            self.faqTextView.text = ""
            
            for question in section.questions! {
                self.faqTextView.text.appendContentsOf(question.question!)
                self.faqTextView.text.appendContentsOf("\n\n")
                self.faqTextView.text.appendContentsOf(question.answer!)
                self.faqTextView.text.appendContentsOf("\n\n")
            }
        }
    }

}
