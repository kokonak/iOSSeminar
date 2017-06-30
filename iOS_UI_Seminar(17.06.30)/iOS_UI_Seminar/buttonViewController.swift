//
//  buttonViewController.swift
//  iOS_UI_Seminar
//
//  Created by KOKONAK on 2017. 6. 26..
//  Copyright © 2017년 MyMusicTaste. All rights reserved.
//

import UIKit

class buttonViewController: UIViewController {
    @IBOutlet weak var submitButton: AnimationButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.submitButton.backgroundColor = UIColor.white
        self.submitButton.setTitleColor(UIColor.clear, for: UIControlState())
        self.submitButton.layer.cornerRadius = 50
        self.submitButton.clipsToBounds = true
//        self.submitButton.isEnabled = 

        let gesture: UITapGestureRecognizer = UITapGestureRecognizer()
        self.view.addGestureRecognizer(gesture)
        
        gesture.addTarget(self, action: #selector(resign))
    }
    func resign() {
        self.textField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startAnimation(_ sender: Any) {
        self.resign()
        
        self.submitButton.animationStop()
        
        if let duration = self.textField.text {
            self.submitButton.duration = Double(duration)!
        }
        else {
            self.submitButton.duration = 0.1
        }
        self.submitButton.startLoadingAnimation()
    }
    @IBAction func stopAnimation(_ sender: Any) {
        self.resign()
        self.submitButton.animationStop()
    }
    
}
