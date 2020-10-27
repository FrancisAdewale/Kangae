//
//  ViewController.swift
//  Kangae
//
//  Created by Francis Adewale on 27/10/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lightbulbImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lightbulbImage.image = UIImage(named: "unlitBulb")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let timer = Timer(fire: <#T##Date#>, interval: <#T##TimeInterval#>, repeats: <#T##Bool#>, block: <#T##(Timer) -> Void#>)
        lightbulbImage.image = UIImage(named: "litBulb")
    }


}

