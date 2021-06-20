//
//  MainCollectionCell.swift
//  PinterestTutorial-iOS
//
//  Created by kimhyungyu on 2021/06/20.
//

import UIKit

class MainCollectionCell: UICollectionViewCell {

    // MARK: - @IBOulet Properties
    @IBOutlet weak var touchBtn: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Methods
    func setData(image: String, title: String) {
        if let image = UIImage(named: image) {
            imageView.image = image
        }
        imageView.contentMode = .scaleAspectFill
        textLabel.text = title
    }

}
