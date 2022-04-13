//
//  DoneVC.swift
//  TheMallApp
//
//  Created by M1 on 06/04/22.
//

import UIKit

class DoneVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func continueTapped(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        self.navigationController?.pushViewController(vc, animated: false)
    }

}
