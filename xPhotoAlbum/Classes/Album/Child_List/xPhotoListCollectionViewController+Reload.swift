//
//  xPhotoListCollectionViewController+Reload.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/10.
//

import Foundation
 
extension xPhotoListCollectionViewController {
    
    // MARK: - 清除选中照片
    /// 清除选中照片
    func clearChoosePhotoData()
    {
        for photo in self.choosePhotoArray {
            photo.xIsChoose = false
            photo.xChooseNumber = nil
        }
        self.choosePhotoArray.removeAll()
    }
    
    // MARK: - 重新加载数据
    /// 重新加载数据
    func reloadData(_ array : [xPhoto])
    {
        self.dataArray = array
        self.collectionView.reloadData()
    }
    
    // MARK: - 更新底部数据
    /// 更新底部数据
    func reloadBottomData()
    {
        guard let parent = self.parent as? xAlbumViewController else { return }
        parent.reloadPreviewData()
        parent.reloadSureData()
        parent.reloadImageSize()
    }
    
}
