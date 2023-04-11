//
//  xPhotoListCollectionViewController+Func.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/8.
//

import Foundation

extension xPhotoListCollectionViewController {
    
    // MARK: - 点击照片
    /// 点击照片
    func clickPhoto(_ photo : xPhoto)
    {
        // 更新选中状态
        if photo.xIsChoose {
            self.cancelChoosePhoto(photo)
        } else {
            self.choosePhoto(photo)
        }
        // 更新选中编号
        for (i, photo) in self.choosePhotoArray.enumerated() {
            photo.xChooseNumber = "\(i + 1)"
        }
        self.collectionView.reloadData()
    }
    /// 选中照片
    private func choosePhoto(_ photo : xPhoto)
    {
        guard self.isChooseNewPhoto() else { return }
        // 选择照片
        photo.xIsChoose = true
        self.choosePhotoArray.append(photo)
        // 加载压缩图和原图
        photo.reloadImageData {
            [weak self] in
            guard let self = self else { return }
            self.reloadBottomData()
        }
    }
    /// 取消选中照片
    private func cancelChoosePhoto(_ photo : xPhoto)
    {
        photo.xIsChoose = false
        if let idx = self.choosePhotoArray.xIndex(with: photo) {
            self.choosePhotoArray.remove(at: idx)
        }
        self.reloadBottomData()
    }
    /// 判断是否超出数量限制
    private func isChooseNewPhoto() -> Bool
    {
        guard let parent = self.parent as? xAlbumViewController else { return false }
        let curCount = self.choosePhotoArray.count
        let maxCount = parent.maxCount
        if curCount >= maxCount {
            let alert = UIAlertController.init(title: "提示", message: "最多选择\(maxCount)张照片", preferredStyle: .alert)
            let sure = UIAlertAction.init(title: "确定", style: .cancel)
            alert.addAction(sure)
            self.present(alert, animated: true) 
            return false
        } else {
            return true
        }
    }
    
}
