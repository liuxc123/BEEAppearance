//
//  ViewController.swift
//  BEEAppearanceSwift
//
//  Created by mac on 2021/8/24.
//  Copyright © 2021 liuxc123. All rights reserved.
//

import UIKit
import BEEAppearance

class ViewController: UIViewController {
    
    lazy var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        AppearanceManager.addTheme(["color": ["backgroundColor": "#f0f0f0"], "image": ["car": "car1"]], themeName: "default")
        AppearanceManager.addTheme(["color": ["backgroundColor": "#000000"], "image": ["car": "car2"]], themeName: "dark")
        AppearanceManager.defaultTheme("default")
        self.view.backgroundColor = BEEAppearanceColor("backgroundColor")
        self.view.addSubview(imageView)
        self.imageView.image = BEEAppearanceImage("car")
        
        self.view.themeDidChange = { themeName, bindView in
            /// XXX
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.imageView.center = view.center
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3) {
            if AppearanceManager.shared().currentTheme == "default" {
                AppearanceManager.changeTheme("dark")
            } else {
                AppearanceManager.changeTheme("default")
            }
        }
    }
}

