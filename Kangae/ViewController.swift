//
//  ViewController.swift
//  Kangae
//
//  Created by Francis Adewale on 27/10/2020.
//

import UIKit
import NRSpeechToText


class ViewController: UIViewController {
    
    @IBOutlet weak var lightbulbImage: UIImageView!
    
    var timer: Timer? = nil // Property
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lightbulbImage.image = UIImage(named: "unlitBulb")
        self.timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: false)
    }
    
    @objc func handleTimer() {
        lightbulbImage.image = UIImage(named: "litBulb")
        let tap = UITapGestureRecognizer(target: self, action: #selector(stop))
        lightbulbImage.addGestureRecognizer(tap)
        lightbulbImage.isUserInteractionEnabled = true

        NRSpeechToText.shared.startRecording {(result: String?, isFinal: Bool, error: Error?) in
            if error == nil {
                if let speech = result {
                    print(speech)
                }
            } else {
                print("Could not retrieve recording")
            }
        }
    }
    
    @objc func stop() {
        if NRSpeechToText.shared.isRunning {
            NRSpeechToText.shared.stop()
        }
    }
    
}

