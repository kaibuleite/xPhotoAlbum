//
//  xPreviewPhotosAlertViewController+Reload.swift
//  Pods-xPhotoAlbum_Example
//
//  Created by Mac on 2023/4/10.
//

import Foundation

extension xPreviewPhotosAlertViewController {
    
    // MARK: - 重新加载数据
    /// 重新加载数据
    func reloadPhotosData(_ array : [xPreviewPhoto])
    {
        self.dataArray = array
        self.collectionView.reloadData()
        self.titleLbl.text = "1/\(array.count)" 
    }
    
}
