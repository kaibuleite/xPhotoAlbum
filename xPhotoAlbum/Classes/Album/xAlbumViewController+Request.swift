//
//  xAlbumViewController+Request.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/7.
//

import Foundation
import Photos 

extension xAlbumViewController {
    
    public override func requestData()
    {
        let library = PHPhotoLibrary.authorizationStatus()
        if (library == PHAuthorizationStatus.denied ||
            library == PHAuthorizationStatus.restricted ||
            library == PHAuthorizationStatus.notDetermined) {
            "没有获得权限".xAlertTip()
            self.navigationController?.popViewController(animated: true)
        } else {
            
        }
//        // 获取所有相册
//        let allPhotoOptions = PHFetchOptions() 
//        allPhotoOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
//        let allPhotos = PHAsset.fetchAssets(with: allPhotoOptions)
//        let userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil) 
        // 获取相册列表
        let systemAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
        let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
        let albums = [smartAlbums, systemAlbums]
        self.reloadAlbumsData(albums)
    }
}

/*
 PHAssetCollectionType
    case Album       //在 照片 应用中创建的相簿或者通过iTunes同步的在iOS设备上显示的相簿
    case SmartAlbum  //照片 应用中内置的相簿
    case Moment      //照片 应用中的 时刻
 
 PHAssetCollectionSubtype
    case AlbumRegular              //用户在 Photos 中创建的相册，也就是我所谓的逻辑相册
     case AlbumSyncedEvent          //使用 iTunes 从 Photos 照片库或者 iPhoto 照片库同步过来的事件。然而，在iTunes 12 以及iOS 9.0 beta4上，选用该类型没法获取同步的事件相册，而必须使用AlbumSyncedAlbum。
     case AlbumSyncedFaces          //使用 iTunes 从 Photos 照片库或者 iPhoto 照片库同步的人物相册。
     case AlbumSyncedAlbum          //做了 AlbumSyncedEvent 应该做的事
     case AlbumImported             //从相机或是外部存储导入的相册，完全没有这方面的使用经验，没法验证。
     case AlbumMyPhotoStream        //用户的 iCloud 照片流
     case AlbumCloudShared          //用户使用 iCloud 共享的相册
     case SmartAlbumGeneric         //文档解释为非特殊类型的相册，主要包括从 iPhoto 同步过来的相册。由于本人的 iPhoto 已被 Photos 替代，无法验证。不过，在我的 iPad mini 上是无法获取的，而下面类型的相册，尽管没有包含照片或视频，但能够获取到。
     case SmartAlbumPanoramas       //相机拍摄的全景照片
     case SmartAlbumVideos          //相机拍摄的视频
     case SmartAlbumFavorites       //收藏文件夹
     case SmartAlbumTimelapses      //延时视频文件夹，同时也会出现在视频文件夹中
     case SmartAlbumAllHidden       //包含隐藏照片或视频的文件夹
     case SmartAlbumRecentlyAdded   //相机近期拍摄的照片或视频
     case SmartAlbumBursts          //连拍模式拍摄的照片，在 iPad mini 上按住快门不放就可以了，但是照片依然没有存放在这个文件夹下，而是在相机相册里。
     case SmartAlbumSlomoVideos     //Slomo 是 slow motion 的缩写，高速摄影慢动作解析，在该模式下，iOS 设备以120帧拍摄。不过我的 iPad mini 不支持，没法验证。
     case SmartAlbumUserLibrary     //这个命名最神奇了，就是相机相册，所有相机拍摄的照片或视频都会出现在该相册中，而且使用其他应用保存的照片也会出现在这里。
     case Any                       //包含所有类型
 */
