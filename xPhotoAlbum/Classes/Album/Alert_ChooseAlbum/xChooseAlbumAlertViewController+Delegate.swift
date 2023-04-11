//
//  xChooseAlbumAlertViewController+Delegate.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/8.
//

import Foundation 

// MARK: - Cell
extension xChooseAlbumAlertViewController {
    
    /// 注册Cell
    func registerCells() {
        let bundle = Bundle.init(for: self.classForCoder)
        let nib = UINib.init(nibName: "xAlbumCell", bundle: bundle)
        self.tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
}

// MARK: - Table view data source
extension xChooseAlbumAlertViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! xAlbumCell
        // 数据填充
        let album = self.dataArray[indexPath.row]
        cell.setContentData(album)
        let isChoose = (self.currentChooseRow == indexPath.row)
        cell.chooseFlagLbl.alpha = (isChoose ? 1 : 0)
        
        return cell
    }
}

// MARK: - Table view delegate
extension xChooseAlbumAlertViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        defer {
            self.dismiss()
        }
        guard self.currentChooseRow != row else { return }
        self.currentChooseRow = row
        self.tableView.reloadData()
        let album = self.dataArray[row]
        self.clickAlbum(album)
    }
}

