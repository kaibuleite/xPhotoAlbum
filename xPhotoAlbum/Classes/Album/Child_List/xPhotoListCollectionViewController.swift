//
//  xPhotoListCollectionViewController.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/7.
//

import UIKit

class xPhotoListCollectionViewController: UICollectionViewController {
    
    // MARK: - Public Property
    var dataArray = [xPhoto]()
    var choosePhotoArray = [xPhoto]()
    
    // MARK: - 内存释放
    deinit {
        let info = self.xClassInfoStruct
        let space = info.space
        let name = info.name
        print("🔸【\(space).\(name)】")
    }
    
    // MARK: - Override Func
    override class func xDefaultViewController() -> Self {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = .init(top: 1, left: 1, bottom: 1, right: 1)
        layout.itemSize = xThumbMidSize
        let cvc = xPhotoListCollectionViewController.init(collectionViewLayout: layout)
        return cvc as! Self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 基本配置
        self.collectionView.backgroundColor = .clear
        self.registerCells()
    } 
    
}
