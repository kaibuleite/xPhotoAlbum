//
//  xPhoto.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/7.
//

import Foundation
import Photos

public class xPhoto: NSObject {
    
    /// 是否选中
    var xIsChoose = false
    /// 选中编号
    var xChooseNumber : String?
    /// GIF
    var xIsGIF = false
    /// 图片路径
    var xImagePath = ""
    /// 相片资源
    public var xAsset = PHAsset()
    /// 缩略图
    public var xThumbImage : UIImage?
    /// 图片数据
    public var xImageData = Data()
    /// 原始图片数据
    var xOriginalImageData = Data()
    var xOriginalImageDataSize = 0
    /// 压缩图片数据
    var xCompressImageData = Data()
    var xCompressImageDataSize = 0
    
    // MARK: - 实例化对象
    public override init() {
        super.init()
    }
    init(from asset: PHAsset) {
        self.xAsset = asset
        let resources = PHAssetResource.assetResources(for: asset)
//        print(resources)
        for resource in resources {
            // 根据统一类型标示符 kUTTypeG 判断图片类型 GIF
            if self.xIsGIF == false {
                let uti = resource.uniformTypeIdentifier
                if uti == "com.compuserve.gif" {
                    self.xIsGIF = true
                }
            }
            // 获取图片路径
            if self.xImagePath.count == 0 {
                if let url = resource.value(forKey: "privateFileURL") as? URL {
                    self.xImagePath = url.absoluteString
                }
            }
        }
    }
    
    // MARK: - 获取缩略图
    /// 获取缩略图
    func getThumbImage(targetSize : CGSize,
                       completed : @escaping (UIImage?) -> Void)
    {
        if let image = self.xThumbImage {
            completed(image)
            return
        }
        
        let options = PHImageRequestOptions()
        options.resizeMode = .fast
        options.deliveryMode = .highQualityFormat
//        options.isSynchronous //是否同步操作
        xPhotoAlbumManager.getImage(for: self.xAsset, targetSize: targetSize, options: options) {
            [weak self] (image) in
            guard let self = self else { return }
            self.xThumbImage = image
            completed(image)
        }
    }
    // MARK: - 获取原图、压缩图
    /// 获取原图
    func reloadImageData(completed : @escaping () -> Void)
    { 
        if self.xCompressImageDataSize > 0 {
            completed()
            return
        }
        let options = PHImageRequestOptions()
        options.version = .original
        options.resizeMode = .fast
        options.deliveryMode = .highQualityFormat
        xPhotoAlbumManager.getImageData(for: self.xAsset, options: options) {
            [weak self] (imageData) in
            guard let self = self else { return }
            self.xOriginalImageData = imageData ?? .init()
            self.xOriginalImageDataSize = self.xOriginalImageData.count
            var originalImage = UIImage.init(contentsOfFile: self.xImagePath)
            if originalImage == nil {
                originalImage = UIImage.init(data: self.xOriginalImageData)
            }
            // 压缩率
            let quality = CGFloat(0.5)
            let compressImageData = originalImage?.jpegData(compressionQuality: quality) ?? imageData
            self.xCompressImageData = compressImageData ?? .init()
            self.xCompressImageDataSize = self.xCompressImageData.count
            completed()
        }
    }
    
}
