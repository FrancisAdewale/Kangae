//
//  ViewController.swift
//  Kangae
//
//  Created by Francis Adewale on 27/10/2020.
//

import UIKit
import NRSpeechToText
import AVFoundation



class ViewController: UIViewController {
    
    
    @IBOutlet weak var lightbulbImage: UIImageView!
    
    
    var timer: Timer? = nil
    var player: AVAudioPlayer?
    var sounds: [String] = ["Sword","Sword2"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        lightbulbImage.image = UIImage(named: "unlitBulb")
        self.timer = Timer.scheduledTimer(timeInterval: 1.9, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: false)
                
    }
        
    
    @objc func handleTimer() {
                
        lightbulbImage.image = UIImage(named: "litBulb")
        playSound()
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
            playSound()
            lightbulbImage.image = UIImage(named: "unlitBulb")
            NRSpeechToText.shared.stop()
        }
    }
    
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: sounds[Int.random(in: 0...1)], withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
    


