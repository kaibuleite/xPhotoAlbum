//
//  xPhotoAlbum.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/8.
//

import Foundation
import Photos

class xAlbum: NSObject {
    
    /// 相册集合
    var xCollection = PHAssetCollection()
    /// 相册名称
    var xName = ""
    /// 封面
    var xThumbPhoto = xPhoto()
    /// 照片数量
    var xPhotoCount = 0
    /// 照片信息
    var xPhotoList = [xPhoto]()
    
    // MARK: - 实例化对象
    override init() {
        super.init()
    }
    init(from collection: PHAssetCollection) {
        // 过滤视频，只要照片
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
        options.predicate = NSPredicate(format:"mediaType = %d", PHAssetMediaType.image.rawValue)
        let assets = PHAsset.fetchAssets(in: collection, options: options)
        let count = assets.count
        // 保存数据
        self.xCollection = collection
        self.xPhotoCount = count
        self.xName = collection.localizedTitle ?? "" 
        // 保存相片
        var photoList = [xPhoto]()
        for i in 0 ..< count {
            print("开始加载照片\(count)\(i)\t\(Date())")
            let asset = assets.object(at: i)
            print("照片\(count)-\(i)加载完成\t\(Date())")
            let photo = xPhoto.init(from: asset)
            print("照片\(count)-\(i)初始化完成\t\(Date())")
            photoList.append(photo)
        }
        print("保存相片完成\t\(Date())")
        self.xPhotoList = photoList
        if let obj = photoList.last {
            self.xThumbPhoto = obj
        }
    }
    
}
