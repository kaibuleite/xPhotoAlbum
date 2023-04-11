//
//  xAlbumCell.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/8.
//

import UIKit

class xAlbumCell: UITableViewCell {

    // MARK: - IBOutlet Property
    @IBOutlet weak var thumbIcon: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var chooseFlagLbl: UILabel!
    
    // MARK: - Public Property
    
    // MARK: - Override Func
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - 内容填充
    /// 普通填充
    func setContentData(_ album: xAlbum)
    {
        let photo = album.xThumbPhoto
        photo.getThumbImage(targetSize: xThumbSmallSize) {
            [weak self] (image) in
            guard let self = self else { return }
            self.thumbIcon.image = image 
        }
        self.nameLbl.text = album.xName
        self.countLbl.text = "(\(album.xPhotoCount))" 
    }  
    
}
