//
//  xPhotoListCollectionViewController+Delegate.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/10.
//

import Foundation

// MARK: - Cell
extension xPhotoListCollectionViewController {
    
    /// 注册Cell
    func registerCells() {
        let bundle = Bundle.init(for: self.classForCoder)
        let nib = UINib.init(nibName: "xPhotoCell", bundle: bundle)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "Cell")  
    }
}

// MARK: - Collection view data source
extension xPhotoListCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int
    {
        return self.dataArray.count
    }
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! xPhotoCell
        let photo = self.dataArray[indexPath.row]
        cell.setContentData(photo)
        
        return cell
    }
    
}

// MARK: - Collection view delegate
extension xPhotoListCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath)
    {
        collectionView.deselectItem(at: indexPath, animated: true)
        let photo = self.dataArray[indexPath.row]
        self.clickPhoto(photo)
    }
}
