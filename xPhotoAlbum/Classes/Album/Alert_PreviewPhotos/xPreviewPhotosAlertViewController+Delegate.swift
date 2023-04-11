//
//  xPreviewPhotosAlertViewController+Delegate.swift
//  Pods-xPhotoAlbum_Example
//
//  Created by Mac on 2023/4/10.
//

import Foundation

// MARK: - FlowLayout
class xPreviewPhotosListFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        self.collectionView?.isPagingEnabled = true
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        self.sectionInset = .zero
        if let size = self.collectionView?.bounds.size {
            self.itemSize = size
        }
    }
}

// MARK: - Cell
extension xPreviewPhotosAlertViewController {
    
    /// 注册Cell
    func registerCells() {
        let bundle = Bundle.init(for: self.classForCoder)
        let nib = UINib.init(nibName: "xPreviewPhotoCell", bundle: bundle)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
    }
}

// MARK: - Collection view data source
extension xPreviewPhotosAlertViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int
    {
        return self.dataArray.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! xPreviewPhotoCell
        let photo = self.dataArray[indexPath.row]
        cell.setContentData(photo)
        
        return cell
    }
}

// MARK: - Collection view delegate
extension xPreviewPhotosAlertViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath)
    {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.dismiss()
    }
}

// MARK: - Scroll view delegate
extension xPreviewPhotosAlertViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let w = scrollView.bounds.width
        let ofx = scrollView.contentOffset.x + w / 2
        let page = Int(ofx / w)
        self.titleLbl.text = "\(page + 1)/\(self.dataArray.count)"
    }
}
