//
//  xChooseAlbumAlertViewController+Reload.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/8.
//

import Foundation

extension xChooseAlbumAlertViewController {
    
    // MARK: - 重新加载数据
    /// 重新加载数据
    func reloadAlbumsData(_ array : [xAlbum])
    {
        self.currentChooseRow = 0
        self.dataArray = array
        self.tableView.reloadData()
        // 更新高度
        var count = array.count
        if count > 8 { count = 8 }
        let height = self.tableView.rowHeight * CGFloat(count)
        self.contentHeightLayout.constant = height
        self.content.setNeedsLayout()
        self.content.layoutIfNeeded()
    }
    
}
