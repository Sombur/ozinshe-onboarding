//
//  PlayerVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 22.02.2024.
//

import UIKit
import YouTubePlayer

//
class PlayerVC: UIViewController {

    var video_link = ""
    
    let player = {
        let view = YouTubePlayerView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgraundColor")
        view.addSubview(player)
        
        player.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        player.loadVideoID(video_link)
    }
}
