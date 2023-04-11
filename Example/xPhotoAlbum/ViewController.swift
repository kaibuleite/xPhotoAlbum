//
//  ViewController.swift
//  xPhotoAlbum
//
//  Created by kaibuleite on 04/10/2023.
//  Copyright (c) 2023 kaibuleite. All rights reserved.
//

import UIKit
import xPhotoAlbum

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - 选择相片
    @IBAction func choosePhotoBtnClick()
    {
        print("\(#function) in \(type(of: self))")
        
        xAlbumViewController.push(from: self, max: 4) {
            (list) in
            print("选中图片")
            print(list)
        }
        
//        let vc = xAlbumViewController.xDefaultViewController()
//        vc.maxCount = 4
//        vc.addChoosePhotos {
//            (list) in
//            print("选中图片")
//            print(list)
//        }
//        self.navigationController?.pushViewController(vc, animated: true)
    }

}

