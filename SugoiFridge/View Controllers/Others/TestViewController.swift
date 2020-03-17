//
//  TestViewController.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/7.
//  Copyright © 2020 TAR. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sugoi(_ sender: Any) {
        performSegue(withIdentifier: "sugoiSegue", sender: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
