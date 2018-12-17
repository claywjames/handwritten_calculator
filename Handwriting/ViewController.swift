//
//  ViewController.swift
//  Handwriting
//
//  Created by Clay James on 12/11/18.
//  Copyright © 2018 Clay James. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var drawing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.allowedTouchTypes = [NSTouch.TouchTypeMask.indirect, NSTouch.TouchTypeMask.direct]
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func touchesBegan(with event: NSEvent) {
        if (drawing) {
            print(event.touches(matching: NSTouch.Phase.began, in: self.view))
        }
    }
    
    @IBAction func drawClicked(_ sender: NSButton) {
        drawing = true
    }
}

