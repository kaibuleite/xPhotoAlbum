//
//  xAlbumViewController+Reload.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/8.
//

import Foundation
import Photos
import UIKit

extension xAlbumViewController {
    
    // MARK: - 重新加载相册数据
    /// 重新加载相册数据
    func reloadAlbumsData(_ albumsList : [xAlbum])
    {
        let albumCount = albumsList.count
        guard albumCount > 0 else {
            "没有相册数据".xAlertTip()
            self.navigationController?.popViewController(animated: true)
            return
        }
        self.alertChooseAlbum.reloadAlbumsData(albumsList)
        // 默认加载第一个相册
        guard let first = albumsList.first else { return }
        self.reloadAlbumData(first)
    }
    
    /// 重新加载相册数据
    func reloadAlbumData(_ album : xAlbum)
    {
        guard self.currentAlbum != album else { return }
        // 修改相册名称
        let title = "   \(album.xName)(\(album.xPhotoCount))   "
        self.changeAlbumBtn.setTitle(title, for: .normal)
        self.changeAlbumBtn.isHidden = false
        // 缓存相册相片
        let photoList = album.xPhotoList
        let assetList = photoList.map { return $0.xAsset }
        // 缓存相片
        xPhotoAlbumManager.startCachingImages(for: assetList)
        // 刷新相册相片
        self.currentAlbum = album
        self.childList.clearChoosePhotoData()
        self.childList.reloadData(photoList)
        self.reloadPreviewData()
        self.reloadSureData()
    }
    // MARK: - 重新加载操作按钮数据
    /// 重新加载预览按钮数据
    func reloadPreviewData()
    {
        let count = self.getChoosePhotoArray().count
        let isEnable = (count > 0)
        self.updatePreviewButton(isEnable: isEnable)
    }
    /// 重新加载确定按钮数据
    func reloadSureData()
    {
        let count = self.getChoosePhotoArray().count
        let isEnable = (count > 0)
        self.updateSureButton(isEnable: isEnable)
    }
    
    // MARK: - 重新加载原图大小
    /// 重新加载原图大小
    func reloadImageSize()
    {
        let list = self.getChoosePhotoArray()
        var totalSize = Int.zero
        for photo in list {
            if self.isUseOriginal {
                totalSize += photo.xOriginalImageDataSize
            } else {
                totalSize += photo.xCompressImageDataSize
            }
        }
        self.originSizeLbl.isHidden = (totalSize == 0)
        let str = xGetMemorySize(totalSize)
        self.originSizeLbl.text = str
    }
}
