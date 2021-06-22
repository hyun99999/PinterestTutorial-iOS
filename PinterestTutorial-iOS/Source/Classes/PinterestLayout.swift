//
//  PinterestLayout.swift
//  PinterestTutorial-iOS
//
//  Created by kimhyungyu on 2021/06/21.
//

import Foundation
import UIKit

class PinterestLayout: UICollectionViewFlowLayout {
    
    // delegate로 ViewController 를 나타낸다.
    weak var delegate: PinterestLayoutDelegate?
    
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    // 1. 콜렉션 뷰의 콘텐츠 사이즈를 지정합니다.
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    // 다시 레이아웃을 계산할 필요가 없도록 메모리에 저장합니다.
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    // 2. 콜렉션 뷰가 처음 초기화되거나 뷰가 변경될 떄 실행됩니다. 이 메서드에서 레이아웃을
    //    미리 계산하여 메모리에 적재하고, 필요할 때마다 효율적으로 접근할 수 있도록 구현해야 합니다.
    override func prepare() {
        guard let collectionView = collectionView, cache.isEmpty else { return }
        
        let numberOfColumns: Int = 2 // 한 행의 아이템 갯수
        let cellPadding: CGFloat = 5
        let cellWidth: CGFloat = contentWidth / CGFloat(numberOfColumns)
        
        let xOffSet: [CGFloat] = [0, cellWidth] // cell 의 x 위치를 나타내는 배열
        var yOffSet: [CGFloat] = .init(repeating: 0, count: numberOfColumns) // // cell 의 y 위치를 나타내는 배열
        
        var column: Int = 0 // 현재 행의 위치
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            // IndexPath 에 맞는 셀의 크기, 위치를 계산합니다.
            let indexPath = IndexPath(item: item, section: 0)
            let imageHeight = delegate?.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath) ?? 180
            let height = cellPadding * 2 + imageHeight
            
            let frame = CGRect(x: xOffSet[column],
                               y: yOffSet[column],
                               width: cellWidth,
                               height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // 위에서 계산한 Frame 을 기반으로 cache 에 들어갈 레이아웃 정보를 추가합니다.
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // 콜렉션 뷰의 contentHeight 를 다시 지정합니다.
            contentHeight = max(contentHeight, frame.maxY)
            yOffSet[column] = yOffSet[column] + height
            
            // 다른 이미지 크기로 인해서, 한쪽 열에만 이미지가 추가되는 것을 방지합니다.
            column = yOffSet[0] > yOffSet[1] ? 1 : 0
        }
    }
    
    // 3. 모든 셀과 보충 뷰의 레이아웃 정보를 리턴합니다. 화면 표시 영역 기반(Rect)의 요청이 들어올 때 사용합니다.
        override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
            var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
            
            for attributes in cache {
                if attributes.frame.intersects(rect) { // 셀 frame 과 요청 Rect 가 교차한다면, 리턴 값에 추가합니다.
                    visibleLayoutAttributes.append(attributes)
                }
            }
            
            return visibleLayoutAttributes
        }
        
        // 4. 모든 셀의 레이아웃 정보를 리턴합니다. IndexPath 로 요청이 들어올 때 이 메서드를 사용합니다.
        override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
            return cache[indexPath.item]
        }
}
