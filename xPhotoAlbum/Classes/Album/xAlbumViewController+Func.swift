//
//  xAlbumViewController+Func.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/8.
//

import Foundation 

extension xAlbumViewController {
    
    // MARK: - 添加回调
    /// 添加回调
    public func addChoosePhotos(handler : @escaping xAlbumViewController.xHandlerChoosePhotos)
    {
        self.choosePhotosHandler = handler
    } 
    
    // MARK: - 获取选中的照片
    /// 获取选中的照片
    func getChoosePhotoArray() -> [xPhoto]
    {
        let list = self.childList.choosePhotoArray
        return list
    }
    
    // MARK: - 更新下方按钮状态
    /// 更新预览按钮状态
    func updatePreviewButton(isEnable: Bool)
    {
        let color : UIColor = (isEnable ? .white : .lightGray)
        self.previewBtn.setTitleColor(color, for: .normal)
        self.previewBtn.isEnabled = isEnable
    }
    /// 更新原图按钮状态
    func updateOriginalButton(isEnable: Bool)
    {
        let color : UIColor = (isEnable ? .white : .lightGray)
        self.originalBtn.setTitleColor(color, for: .normal)
        self.originalBtn.isEnabled = isEnable
    }
    /// 更新确定按钮状态
    func updateSureButton(isEnable: Bool)
    {
        let color : UIColor = (isEnable ? .systemGreen : .lightGray)
        self.sureBtn.backgroundColor = color
        self.sureBtn.isEnabled = isEnable
    }
    
}
