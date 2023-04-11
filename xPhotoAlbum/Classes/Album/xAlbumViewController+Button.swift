//
//  xAlbumViewController+Button.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/7.
//

import Foundation  

extension xAlbumViewController {
    
    // MARK: - 返回
    @IBAction func closeBtnClick()
    {
        print("\(#function) in \(type(of: self))")
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else
        if self.presentedViewController != nil {
            self.dismiss(animated: true)
        } else {
            print("⚠️ 无法返回")
        }
    }
    
    // MARK: - 切换数据源
    @IBAction func changeAlbumBtnClick()
    {
        print("\(#function) in \(type(of: self))")
        if self.alertChooseAlbum.view.isHidden {
            self.alertChooseAlbum.display()
        } else {
            self.alertChooseAlbum.dismiss()
        }
    }
    
    // MARK: - 预览
    @IBAction func previewBtnClick()
    {
        print("\(#function) in \(type(of: self))")
        self.alertChooseAlbum.dismiss()
        let photoList = self.getChoosePhotoArray()
        var previewList = [xPreviewPhoto]()
        for photo in photoList {
            let preview = xPreviewPhoto.init(from: photo)
            previewList.append(preview)
        }
        // 实时创建，方便释放内存
        let alertPreviewPhotos = xPreviewPhotosAlertViewController.xDefaultViewController()
        self.xAddChild(viewController: alertPreviewPhotos, in: self.childPreviewContainer)
        alertPreviewPhotos.reloadPhotosData(previewList)
        alertPreviewPhotos.display()
        
    }
    
    // MARK: - 原图
    @IBAction func originalBtnClick()
    {
        print("\(#function) in \(type(of: self))")
        self.alertChooseAlbum.dismiss()
        self.isUseOriginal = !self.isUseOriginal
        let bundle = Bundle.init(for: self.classForCoder)
        if self.isUseOriginal {
            self.originalBtn.setImage("xPhotoAlbum_choose".xToImage(in: bundle), for: .normal)
        } else {
            self.originalBtn.setImage("xPhotoAlbum_default".xToImage(in: bundle), for: .normal)
        }
        self.reloadImageSize()
    }
    
    // MARK: - 确定
    @IBAction func sureBtnClick()
    {
        print("\(#function) in \(type(of: self))")
        self.alertChooseAlbum.dismiss() 
        let array = self.getChoosePhotoArray()
        var list = [xPhoto]()
        for photo in array {
            let obj = xPhoto()  // 只拷贝需要的成员变量
            obj.xAsset = photo.xAsset
            obj.xThumbImage = photo.xThumbImage
            obj.xImageData = photo.xCompressImageData
            if self.isUseOriginal {
                obj.xImageData = photo.xOriginalImageData
            }
            list.append(obj)
        }
        self.choosePhotosHandler?(list)
        self.navigationController?.popViewController(animated: true)
    }
    
}
