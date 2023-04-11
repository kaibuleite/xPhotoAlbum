//
//  xPreviewPhoto.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/11.
//

import UIKit

class xPreviewPhoto: NSObject {
    
    /// 图片路径
    var xImagePath = ""
    /// 图片数据
    var xImageData = Data()
    /// 生成的图片
    lazy var xImage : UIImage? = {
        // 减少内存占用
        if let image = UIImage.init(contentsOfFile: self.xImagePath) {
            return image
        } else {
            let image = UIImage.init(data: self.xImageData)
            return image
        }
    }()
    
    // MARK: - 实例化对象
    override init() {
        super.init()
    }
    init(from photo: xPhoto) {
        self.xImagePath = photo.xImagePath
        self.xImageData = photo.xCompressImageData
    }
    
}
