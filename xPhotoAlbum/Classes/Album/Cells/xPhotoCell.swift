//
//  xPhotoCell.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/7.
//

import UIKit

class xPhotoCell: UICollectionViewCell {

    // MARK: - IBOutlet Property
    @IBOutlet weak var thumbIcon: UIImageView!
    @IBOutlet weak var chooseView: UIView!
    @IBOutlet weak var chooseFlagIcon: UIImageView!
    @IBOutlet weak var chooseNumberLbl: UILabel!
    @IBOutlet weak var gifFlagLbl: UILabel!
    
    // MARK: - Public Property
    
    
    // MARK: - Override Func
    override func awakeFromNib() {
        super.awakeFromNib() 
        self.chooseView.backgroundColor = .init(white: 0, alpha: 0.3)
    }
    
    // MARK: - 内容填充
    /// 普通填充
    func setContentData(_ photo: xPhoto)
    {
        photo.getThumbImage(targetSize: xThumbMidSize) {
            [weak self] (image) in
            guard let self = self else { return }
            self.thumbIcon.image = image 
        }
        self.chooseView.isHidden = !photo.xIsChoose
        self.chooseFlagIcon.isHidden = !photo.xIsChoose
        self.chooseNumberLbl.isHidden = !photo.xIsChoose
        self.chooseNumberLbl.text = photo.xChooseNumber
        self.gifFlagLbl.isHidden = !photo.xIsGIF
    } 

}
