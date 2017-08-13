//
//  DetailViewController.swift
//  Musicmix2
//
//  Created by ロドリゲス海 on 2017/08/13.
//  Copyright © 2017年 ロドリゲス海. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class DetailViewController: AVPlayerViewController {
    
    var trackName: String!
    var previewUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = trackName // title設定
        
        if let previewUrl = previewUrl {
            let musicUrl = URL(string: previewUrl)
            player = AVPlayer(url: musicUrl! as URL)
            player?.play() // 自動再生
        }
    }

}
