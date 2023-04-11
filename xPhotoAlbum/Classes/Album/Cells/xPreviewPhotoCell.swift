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
    var imageIcon = UIImageView()
    
    // MARK: - Override Func
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.backgroundColor = .xNewRandom(alpha: 0.3)
        self.contentScroll.addSubview(self.imageIcon)
    }
    
    // MARK: - 内容填充
    /// 普通填充
    func setContentData(_ photo: xPreviewPhoto)
    {
        self.contentScroll.setZoomScale(1, animated: false)
        var frame = self.bounds
        let image = photo.xImage
        let imgW = image?.size.width ?? 1
        let imgH = image?.size.height ?? 1
        let scaleH = frame.width * imgH / imgW
        if scaleH > frame.height {
            frame.size.height = scaleH
        }
        self.imageIcon.frame = frame
        if imgW >= imgH {
            // 宽>高，高度设为屏幕高度，宽度自适应
            self.imageIcon.contentMode = .scaleAspectFit
        } else {
            // 高>宽，宽度设为屏幕高度，高度自适应
            self.imageIcon.contentMode = .scaleAspectFill
        }
        self.imageIcon.image = image
        self.contentScroll.contentSize = .init(width: 0, height: frame.height)
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
