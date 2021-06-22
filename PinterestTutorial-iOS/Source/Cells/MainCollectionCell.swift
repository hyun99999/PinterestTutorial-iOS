//
//  MainCollectionCell.swift
//  PinterestTutorial-iOS
//
//  Created by kimhyungyu on 2021/06/20.
//

import UIKit

class MainCollectionCell: UICollectionViewCell {

    // MARK: - @IBOulet Properties
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var touchBtn: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.backgroundColor = .systemBlue
        touchBtn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
    }
    
    // MARK: - Methods
    func setData(image: UIImage, title: String) {
//        if let image = image {
            imageView.image = image
//        }
        view.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        textLabel.text = title
        textLabel.textColor = .white
    }
    @IBAction func detailBtnClicked(_ sender: Any) {
        print("clicked")
    }
    
}
