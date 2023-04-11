//
//  xChooseAlbumAlertViewController+Func.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/10.
//

import Foundation

extension xChooseAlbumAlertViewController {
    
    // MARK: - 显示隐藏
    func display() {
        self.view.isHidden = false
        self.view.alpha = 0
        self.contentTopLayout.constant = -1 * self.view.bounds.height
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1
            self.contentTopLayout.constant = 0
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 0
            self.contentTopLayout.constant = -1 * self.view.bounds.height
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        } completion: {
            (finish) in
            self.view.isHidden = true
        }
    }
    
    // MARK: - 点击相册
    /// 点击相册
    func clickAlbum(_ album : xAlbum)
    {
        guard let parent = self.parent as? xAlbumViewController else { return }
        parent.reloadAlbumData(album)
    }
}
