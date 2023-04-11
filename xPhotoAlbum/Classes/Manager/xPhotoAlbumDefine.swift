//
//  xPhotoAlbumDefine.swift
//  xPhotoAlbum
//
//  Created by Mac on 2023/4/10.
//

@_exported import Foundation
@_exported import UIKit

@_exported import xDefine
@_exported import xExtension

// MARK: - 缩略图尺寸
var xThumbSmallSize : CGSize = {
    let height = CGFloat(50)
    var size = CGSize.zero
    size.width = height
    size.height = height
    return size
}()
var xThumbMidSize : CGSize = {
    let height = (xScreenWidth - 1 * 5) / 4
    var size = CGSize.zero
    size.width = height
    size.height = height
    return size
}()
var xThumbLargeSize : CGSize = {
    var size = CGSize.zero
    size.width = xScreenWidth
    size.height = xScreenHeight
    return size
}()

// MARK: - 获取内存大小
/// 获取内存大小
func xGetMemorySize(_ count : Int) -> String
{
    var size = Double(count)
    var unit = "B"
    if size > 1000 {
        size /= 1000
        unit = "KB"
    }
    if size > 1000 {
        size /= 1000
        unit = "MB"
    }
    if size > 1000 {
        size /= 1000
        unit = "GB"
    }
    let str = size.xToString(precision: 2) + unit
    return str
}
