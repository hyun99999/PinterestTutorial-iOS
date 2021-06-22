//
//  ImageModel.swift
//  PinterestTutorial-iOS
//
//  Created by kimhyungyu on 2021/06/20.
//

import Foundation
import UIKit

struct ImageModel {
    var image: UIImage
    var title: String

    init(title: String, image: String) {
        self.title = title
        self.image = UIImage(named: image) ?? UIImage()
    }
}
