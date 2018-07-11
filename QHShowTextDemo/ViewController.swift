//
//  ViewController.swift
//  QHShowTextDemo
//
//  Created by Anakin chen on 2018/7/9.
//  Copyright © 2018年 Chen Network Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var textManager = QHTextManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showTextAction(_ sender: Any) {
        textManager.showIn(superView: view)
        textManager.play(data: QHTextTestConfig.testTextConfig())
    }
}

