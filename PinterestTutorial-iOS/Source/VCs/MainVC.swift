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
        let pinterestLayout = PinterestLayout()
        pinterestLayout.delegate = self
        collectionView.collectionViewLayout = pinterestLayout

        setList()
        setCollectionView()
        

    }
    
    // MARK: - Methods
    func setList() {
        // 더미 이미지 데이터 생성
        imageList.append(contentsOf:[
            ImageModel(title: "imperdiet est sed tincidunt bibendum.", image: "a"),
            ImageModel(title: "at felis in diam", image: "b"),
            ImageModel(title: "popular during the Renaissance", image: "c"),
            ImageModel(title: "Cicero are also ", image: "d"),
            ImageModel(title: "repeat predefined", image: "e"),
            ImageModel(title: "variations of passages", image: "f"),
            ImageModel(title: "content of a page", image: "g"),
            ImageModel(title: "third", image: "h"),
            ImageModel(title: "fifth", image: "i"),
            ImageModel(title: "fourth", image: "j"),
            ImageModel(title: "fifth", image: "k"),
            ImageModel(title: "second", image: "l")
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
extension MainVC: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let cellWidth: CGFloat = (view.bounds.width - 4) / 2 // 셀 가로 크기
        let imageHeight = imageList[indexPath.item].image.size.height // 이미지 비율
        let imageWidth = imageList[indexPath.item].image.size.width
        let imageRatio = imageHeight/imageWidth
        
        
        return imageRatio * cellWidth
    }
}
