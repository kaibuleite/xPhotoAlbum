//
//  xPreviewPhotoCell.swift
//  Pods-xPhotoAlbum_Example
//
//  Created by Mac on 2023/4/10.
//

import UIKit

class xPreviewPhotoCell: UICollectionViewCell {

    // MARK: - IBOutlet Property
    @IBOutlet public weak var contentScroll: xPreviewPhotoScroll!
    
    // MARK: - Public Property
    var imageIcon : UIImageView?
    
    // MARK: - Override Func
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.backgroundColor = .xNewRandom(alpha: 0.3)
    }
    
    // MARK: - 内容填充
    /// 普通填充
    func setContentData(_ photo: xPreviewPhoto)
    {
        self.contentScroll.setZoomScale(1, animated: false)
        if self.imageIcon == nil {
            let icon = UIImageView(frame: self.bounds)
            icon.contentMode = .scaleAspectFit
            self.contentScroll.addSubview(icon)
            self.imageIcon = icon
        }
        self.imageIcon?.image = photo.xImage
    }
    
}

// MARK: - Scroll
class xPreviewPhotoScroll: UIScrollView {
    
    // MARK: - 内存释放
    deinit {
        self.delegate = nil
    }
    
    // MARK: - Override Func
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.maximumZoomScale = 3
        self.minimumZoomScale = 1
    }
    
    // MARK: - 手势传递
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.superview?.touchesBegan(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.superview?.touchesEnded(touches, with: event)
    }
}

// MARK: - Scroll view delegate
extension xPreviewPhotoScroll: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        let view = self.subviews.first
//        print("缩放对象 \(view)")
        return view
    }
    
}
