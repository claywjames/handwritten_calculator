//
//  ViewController.swift
//  Handwriting
//
//  Created by Clay James on 12/11/18.
//  Copyright © 2018 Clay James. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func drawClicked(_ sender: NSButton) {
        print("clicked")
    }
}

