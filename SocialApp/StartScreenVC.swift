//
//  ViewController.swift
//  SocialApp
//
//  Created by VLADISLAV TAIURSKIY on 22.06.16.
//  Copyright © 2016 Vladislav Taiurskiy. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class StartScreenVC: UIViewController {
    
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let videoURL: URL = Bundle.main().urlForResource("video", withExtension: "mov")!
        
        player = AVPlayer(url: videoURL)
        player?.actionAtItemEnd = .none
        player?.isMuted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        playerLayer.frame = view.frame
        
        view.layer.addSublayer(playerLayer)
        player?.play()
        
        // loop video
        NotificationCenter.default().addObserver(self,
                                                 selector: #selector(loopVideo),
                                                 name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                 object: nil)
        
    }
    
    func loopVideo() {
        player?.seek(to: kCMTimeZero)
        player?.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }


}

