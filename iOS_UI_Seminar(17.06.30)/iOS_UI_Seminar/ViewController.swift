//
//  ViewController.swift
//  iOS_UI_Seminar
//
//  Created by KOKONAK on 2017. 4. 10..
//  Copyright © 2017년 MyMusicTaste. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var fluidView: PTFluidView!
    
    let zoomInButton: UIButton = UIButton()
    let zoomOutButton: UIButton = UIButton()
    let cliptoBoundsButton: UIButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame: CGRect = self.view.bounds
        let rect: CGRect = CGRect(x: frame.width/3, y: frame.height/4, width: frame.width/3, height: frame.height/2)
        fluidView = PTFluidView(frame: rect)
        fluidView.clipsToBounds = false
        fluidView.layer.borderColor = UIColor.red.cgColor
        fluidView.layer.borderWidth = 1
        fluidView.startAnimation()
        self.view.addSubview(self.fluidView)
        
        
        // Start horizontal move animation of fluidView
        self.zoomInButton.setTitle("animate", for: UIControlState())
        self.zoomInButton.setTitleColor(UIColor.black, for: UIControlState())
        self.zoomInButton.addTarget(self, action: #selector(zoomIn(_:)), for: .touchUpInside)
        self.view.addSubview(self.zoomInButton)
        
        // Remove horizontal move animation of fluidView
        self.zoomOutButton.setTitle("remove", for: UIControlState())
        self.zoomOutButton.setTitleColor(UIColor.black, for: UIControlState())
        self.zoomOutButton.addTarget(self, action: #selector(zoomOut(_:)), for: .touchUpInside)
        self.view.addSubview(self.zoomOutButton)
        
        self.cliptoBoundsButton.setTitle("clipsToBounds", for: UIControlState())
        self.cliptoBoundsButton.setTitleColor(UIColor.black, for: UIControlState())
        self.cliptoBoundsButton.addTarget(self, action: #selector(cliptoBoundsTouch(_:)), for: .touchUpInside)
        self.view.addSubview(self.cliptoBoundsButton)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let frame: CGRect = self.view.bounds
        self.zoomInButton.frame = CGRect(x: 20, y: frame.height - 50, width: 100, height: 40)
        self.zoomOutButton.frame = CGRect(x: 20, y: frame.height - 50 - 50, width: 100, height: 40)
        self.cliptoBoundsButton.frame = CGRect(x: frame.width - 20 - 150, y: frame.height - 50, width: 150, height: 40)
    }
    
    func cliptoBoundsTouch(_ button: UIButton) {
        self.fluidView.clipsToBounds = !self.fluidView.clipsToBounds
    }
    
    func zoomIn(_ button: UIButton) {
        self.fluidView.addHorizontalAnimation()
    }
    func zoomOut(_ button: UIButton) {
        self.fluidView.removeHorizontalAnimation()
    }
}
