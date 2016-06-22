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
        
        let path = Bundle.main().pathForResource("video", ofType: "mov")
        
        
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        player?.actionAtItemEnd = .none
        player?.allowsExternalPlayback = true
        player?.isMuted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        playerLayer.frame = view.frame
        
        
        self.view.layer.insertSublayer(playerLayer, at: 0)
        player?.seek(to: kCMTimeZero)
        
        // loop video
        NotificationCenter.default().addObserver(self,
                                                 selector: #selector(itemDidReachEnd),
                                                 name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                 object: self.player?.currentItem)
        
        NotificationCenter.default().addObserver(self,
                                                 selector: #selector(startPlaying),
                                                 name: NSNotification.Name.UIApplicationDidBecomeActive,
                                                 object: nil)
        
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        gradient.colors = [UIColor.black().cgColor, UIColor.clear().cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.opacity = 0.7
        self.view.layer.insertSublayer(gradient, at: 1)
        
      
        let vMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vMotionEffect.minimumRelativeValue = -20
        vMotionEffect.maximumRelativeValue = 20
        
        let hMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        hMotionEffect.minimumRelativeValue = -20
        hMotionEffect.maximumRelativeValue = 20
        
        let groupEffects = UIMotionEffectGroup()
        groupEffects.motionEffects = [vMotionEffect, hMotionEffect]
        self.view.addMotionEffect(groupEffects)
    
    
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.player?.pause()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.player?.play()
    }
    
    deinit {
        NotificationCenter.default().removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    func startPlaying() {
        self.player?.play()
    }
    
    func itemDidReachEnd() {
        self.player?.seek(to: kCMTimeZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }


}

