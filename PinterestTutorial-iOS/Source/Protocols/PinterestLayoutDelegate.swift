//
//  PinterestLayoutDelegate.swift
//  PinterestTutorial-iOS
//
//  Created by kimhyungyu on 2021/06/21.
//

import Foundation
import UIKit

protocol PinterestLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}
