//
//  xChooseAlbumAlertViewController.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/7.
//

import UIKit

class xChooseAlbumAlertViewController: UIViewController {
    
    // MARK: - IBOutlet Property
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var contentTopLayout: NSLayoutConstraint!
    @IBOutlet weak var contentHeightLayout: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Public Property
    var currentChooseRow = 0
    var dataArray = [xAlbum]()
    
    // MARK: - 内存释放
    deinit {
        self.tableView.dataSource = nil
        self.tableView.delegate = nil
        
        let info = self.xClassInfoStruct
        let space = info.space
        let name = info.name
        print("🔹【\(space).\(name)】")
    }
    
    // MARK: - Override Func
    override class func xDefaultViewController() -> Self {
        let vc = Self.xNew(xib: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 基本配置
        self.view.isHidden = true
        self.view.backgroundColor = .init(white: 0, alpha: 0.3)
        self.view.clipsToBounds = true
        
        self.tableView.backgroundColor = .clear
        self.tableView.rowHeight = xThumbSmallSize.height
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerCells()
    } 
    
    // MARK: - 关闭
    @IBAction func closeBtnClick()
    {
        print("\(#function) in \(type(of: self))")
        self.dismiss()
    }
    
}
