//
//  xPreviewPhotosAlertViewController+Func.swift
//  Pods-xPhotoAlbum_Example
//
//  Created by Mac on 2023/4/10.
//

import Foundation

extension xPreviewPhotosAlertViewController {
    
    // MARK: - 显示隐藏
    func display() {
        self.view.alpha = 1
        self.view.isHidden = false
        self.updateBottomButton(isEnable: false)
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 0 
        } completion: {
            (finish) in
            self.view.isHidden = true
            self.updateBottomButton(isEnable: true)
            // 移除，释放内存
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    // MARK: - 设置下方按钮状态
    /// 设置下方按钮状态
    private func updateBottomButton(isEnable: Bool)
    {
        guard let parent = self.parent as? xAlbumViewController else { return }
        parent.childPreviewContainer.isHidden = isEnable
        parent.updatePreviewButton(isEnable: isEnable)
//        parent.updateOriginalButton(isEnable: isEnable)
    }
}
