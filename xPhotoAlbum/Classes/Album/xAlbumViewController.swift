//
//  xAlbumViewController.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/7.
//

import UIKit

public class xAlbumViewController: UIViewController {
    
    // MARK: - Handler
    public typealias xHandlerChoosePhotos = ([Data]) -> Void
    
    // MARK: - IBOutlet Property
    @IBOutlet weak var changeAlbumBtn: UIButton!
    @IBOutlet weak var childPhotosContainer: UIView!
    @IBOutlet weak var childPreviewContainer: UIView!
    @IBOutlet weak var previewBtn: UIButton!
    @IBOutlet weak var originalBtn: UIButton!
    @IBOutlet weak var originSizeLbl: UILabel!
    @IBOutlet weak var sureBtn: UIButton!
    
    // MARK: - Override Property
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Public Property
    /// 最多选择数
    public var maxCount = 6 
    var currentAlbum = xAlbum()
    var isUseOriginal = false
    var choosePhotosHandler : xAlbumViewController.xHandlerChoosePhotos?
    
    // MARK: - Alert
    let alertChooseAlbum = xChooseAlbumAlertViewController.xDefaultViewController()
    
    // MARK: - Child
    let childList = xPhotoListCollectionViewController.xDefaultViewController()
    
    // MARK: - 内存释放
    deinit {
        self.choosePhotosHandler = nil
        xPhotoAlbumManager.cancelAllRequest()
        xPhotoAlbumManager.stopCachingAllAssets()
        let info = self.xClassInfoStruct
        let space = info.space
        let name = info.name
        print("💠【\(space).\(name)】")
    }
    
    // MARK: - Override Func
    public override class func xDefaultViewController() -> Self {
        let vc = Self.xNew(storyboard: nil)
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // 基本配置
        self.view.backgroundColor = .black
        self.childPhotosContainer.backgroundColor = .clear
        self.childPreviewContainer.backgroundColor = .clear
        self.childPreviewContainer.isHidden = true
        self.reloadPreviewData()
        self.reloadSureData()
        self.reloadImageSize()
        // 按钮
        self.changeAlbumBtn.isHidden = true
        self.changeAlbumBtn.layer.cornerRadius = 17
        self.sureBtn.layer.cornerRadius = 4 
        // 预览 
        DispatchQueue.main.async {
            self.addKit()
            self.addChildren()
            self.requestData()
        }
    }
    
    public override func addChildren() {
        self.xAddChild(viewController: self.childList, in: self.childPhotosContainer)
        self.xAddChild(viewController: self.alertChooseAlbum, in: self.childPhotosContainer)
    }

}
