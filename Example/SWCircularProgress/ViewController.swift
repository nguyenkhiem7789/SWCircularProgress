//
//  ViewController.swift
//  SWCircularProgress
//
//  Created by nguyenkhiem7789@gmail.com on 04/15/2020.
//  Copyright (c) 2020 nguyenkhiem7789@gmail.com. All rights reserved.
//

import UIKit
import SWCircularProgress

class ViewController: UIViewController {

    @IBOutlet weak var progressView: CircularProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func clickChangeButton(_ sender: Any) {
        progressView.setValue(value: 0.7)
    }

}

