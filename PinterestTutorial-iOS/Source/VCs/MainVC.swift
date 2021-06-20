//
//  MainVC.swift
//  PinterestTutorial-iOS
//
//  Created by kimhyungyu on 2021/06/20.
//

import UIKit

class MainVC: UIViewController {
    
    //MARK: - Properties
    private var imageList = [ImageModel]()
    
    //MARK: - @IBOutlet Properties
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
        setList()
    }
    
    // MARK: - Methods
    func setList() {
        imageList.append(contentsOf:[
            ImageModel(image: "a", title: "첫번째"),
            ImageModel(image: "b", title: "두번째"),
            ImageModel(image: "c", title: "세번째"),
            ImageModel(image: "d", title: "네번째"),
                            ])
    }
    
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "MainCollectionCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "MainCollectionCell")
    }
}

// MARK: - UICollectionViewDelegate
extension MainVC: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDataSource
extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionCell", for: indexPath) as? MainCollectionCell else {
            return UICollectionViewCell()
        }
        cell.setData(image: imageList[indexPath.row].image, title: imageList[indexPath.row].title)
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 이것보다 좋은 코드는 없을까? 왜냐면 같은 내용을 두번쓰니까
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionCell", for: indexPath) as? MainCollectionCell else {
            return CGSize.zero
        }
        cell.setData(image: imageList[indexPath.row].image, title: imageList[indexPath.row].title)
        
        let width = UIScreen.main.bounds.width
        let cellWidth = width * (177/375)
        let cellHeight = cell.imageView.frame.height
        
        return CGSize(width: cellWidth, height: cellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
