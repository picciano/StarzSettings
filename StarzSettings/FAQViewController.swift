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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    
    var faqs:Array<Section>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.textView.selectable = true
        self.textView.panGestureRecognizer.allowedTouchTypes = [UITouchType.Indirect.rawValue]
        
        FAQ.sharedInstance.loadFAQs { (result, error) -> Void in
            if let result = result {
                self.faqs = result
                self.updateView()
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.textView.becomeFirstResponder()
    }

    func updateView() {
        if let section = self.faqs?.first {
            self.updateText(section)
        }
        
        self.tableView.reloadData()
    }
    
    func updateText(section: Section) {
        self.textView.text = ""
        
        for question in section.questions! {
            self.textView.text.appendContentsOf(question.question!)
            self.textView.text.appendContentsOf("\n\n")
            self.textView.text.appendContentsOf(question.answer!)
            self.textView.text.appendContentsOf("\n\n")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let faqs = self.faqs {
            return faqs.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        if let section = self.faqs?[indexPath.row] {
            cell.textLabel?.text = section.name
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let section = self.faqs?[indexPath.row] {
            self.updateText(section)
        }
    }
    
    func tableView(tableView: UITableView, canFocusRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

}
