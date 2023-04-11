//
//  xPhotoAlbumManager.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/8.
//

import Photos

/* https://www.jianshu.com/p/3f8627d990f3 */

class xPhotoAlbumManager: PHCachingImageManager {
//class xPhotoAlbumManager: PHImageManager {
    
    /// 单例
    public static let shared = xPhotoAlbumManager.initDefaultsIvars()
    /// 从UserDefaults内读取初始值
    class func initDefaultsIvars() -> Self
    {
        let mgr = xPhotoAlbumManager()
        // 关闭缓存
//        mgr.allowsCachingHighQualityImages = false
        return mgr as! Self
    }
    var reqList = [String : PHImageRequestID]()
    
    // MARK: - 缓存图片
    /// 开始缓存图片
    static func startCachingImages(for assets: [PHAsset])
    {
        self.stopCachingAllAssets()
        
        let options = PHImageRequestOptions()
        options.resizeMode = .fast
        options.deliveryMode = .highQualityFormat
        shared.startCachingImages(for: assets, targetSize: xThumbMidSize, contentMode: .aspectFill, options: options)
    }
    /// 取消缓存图片
    static func stopCachingAllAssets() -> Void
    {
        shared.stopCachingImagesForAllAssets()
    }
    /// 取消剩余的下载
    static func cancelAllRequest()
    {
        for (_, v) in shared.reqList {
            shared.cancelImageRequest(v)
        }
        shared.reqList.removeAll()
    }
    
    // MARK: - 获取图片
    /// 获取图片
    static func getImage(for asset : PHAsset,
                         targetSize : CGSize = .zero,
                         options : PHImageRequestOptions,
                         completed : @escaping (UIImage?) -> Void)
    {
        let multiplier = CGFloat(asset.pixelHeight) / CGFloat(asset.pixelWidth)
        let contentMode : PHImageContentMode = (multiplier > 1 ? .aspectFit : .aspectFill)
        var size = targetSize
        if size == .zero {
            // 自适应宽高
            size = self.getImageAutoSize(for: asset, quality: 1)
        }
        let scale = UIScreen.main.scale
        size.width *= scale
        size.height *= scale
        let reqID = shared.requestImage(for: asset, targetSize: size, contentMode: contentMode, options: options) {
            (image, info) in
            shared.reqList["\reqID"] = nil
//            if let data = image?.jpegData(compressionQuality: 1) {
//                let size = xGetMemorySize(data.count)
//                print("A图片大小【\(size)】")
//            }
            completed(image)
        }
        shared.reqList["\(reqID)"] = reqID
    }
    
    // MARK: - 获取图片数据
    /// 获取图片数据（占用内存过大，慎用）
    static func getImageData(for asset : PHAsset,
                             options : PHImageRequestOptions,
                             completed : @escaping (Data?) -> Void)
    {
        let reqID = shared.requestImageData(for: asset, options: options) {
            (imageData, imageName, orientation, info) in
            // imageData 图像数据 imageName 图像的名字 orientation 图像展示的方向 info 图像的信息
            shared.reqList["\reqID"] = nil
//            if let data = imageData {
//                let size = xGetMemorySize(data.count)
//                print("B图片大小【\(size)】")
//            } else {
//                print("⚠️ 读取图片失败")
//                if let obj = info { print(obj) }
//            }
            completed(imageData)
        }
        shared.reqList["\(reqID)"] = reqID
    }
    
    // MARK: - 自动计算图片宽高
    /// 自动计算图片宽高
    static func getImageAutoSize(for asset : PHAsset,
                                 quality : CGFloat) -> CGSize
    {
        let pixW = CGFloat(asset.pixelWidth)
        let pixH = CGFloat(asset.pixelHeight)
        var size = xScreenSize
        if pixW >= pixH {
            // 宽>高，高度设为屏幕高度，宽度自适应
            size.width = size.height * pixW / pixH
        } else {
            // 高>宽，宽度设为屏幕高度，高度自适应
            size.height = size.width * pixH / pixW
        }
        if quality > 0, quality <= 1 {
            size.width *= quality
            size.height *= quality
        }
        return size
    }
}
