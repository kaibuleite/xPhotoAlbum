//
//  xPreviewPhotosAlertViewController.swift
//  Pods-xPhotoAlbum_Example
//
//  Created by Mac on 2023/4/10.
//

import UIKit

class xPreviewPhotosAlertViewController: UIViewController {
    
    // MARK: - IBOutlet Property
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Public Property
    var dataArray = [xPreviewPhoto]()
    
    // MARK: - 内存释放
    deinit {
        self.collectionView.dataSource = nil
        self.collectionView.delegate = nil
        
        let info = self.xClassInfoStruct
        let space = info.space
        let name = info.name
        print("🔹【\(space).\(name)】")
    }
    
    // MARK: - Override Func
    override class func xDefaultViewController() -> Self {
        let vc = Self.xNew(xib: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 基本配置
        self.view.isHidden = true
        self.view.backgroundColor = .black
        
        self.collectionView.backgroundColor = .clear
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.registerCells()
    }

}
