//
//  TabBarDataViewController.swift
//  Remote Control
//
//  Created by Pengju Zhang on 3/1/22.
//

import UIKit

class TabBarDataViewController: UITabBarController {

    // DEFAULT
    var favoriteChannelData = [
        0: ["ABC", 1],
        1: ["NBC", 2],
        2: ["CBS", 3],
        3: ["FOX", 4]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
