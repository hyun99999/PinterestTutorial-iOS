# PinterestTutorial-iOS
π₯ΊPinterest Layout Tutorial

μ΄λ―Έμ§ ν¬κΈ°μ λ°λΌμ λμ μΌλ‘ μμ λ μ΄μμμ μ€μ νλ νν°λ μ€νΈ λ μ΄μμ κ΅¬νν΄ λ³΄μλ€.

### μμ±
<img src ="https://user-images.githubusercontent.com/69136340/122961623-86e06800-d3bf-11eb-896c-306b4af5ec59.png" width ="250">

### μ½λ

- UICollectionViewDelegateFlowLayout μ μλΈν΄λμ€μΈ PinterestLayout μμ±.
```swift
// PinterestLayout μμ κ° μ΄λ―Έμ§ λμ΄λ₯Ό μ μ μλλ‘ Delegate μμ±.
protocol PinterestLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

class PinterestLayout: UICollectionViewFlowLayout {
    
    // delegateλ‘ ViewController λ₯Ό λνλΈλ€.
    weak var delegate: PinterestLayoutDelegate?
    
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    // 1. μ½λ μ λ·°μ μ½νμΈ  μ¬μ΄μ¦λ₯Ό μ§μ ν©λλ€.
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    // λ€μ λ μ΄μμμ κ³μ°ν  νμκ° μλλ‘ λ©λͺ¨λ¦¬μ μ μ₯ν©λλ€.
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    // 2. μ½λ μ λ·°κ° μ²μ μ΄κΈ°νλκ±°λ λ·°κ° λ³κ²½λ  λ μ€νλ©λλ€. μ΄ λ©μλμμ λ μ΄μμμ
    //    λ―Έλ¦¬ κ³μ°νμ¬ λ©λͺ¨λ¦¬μ μ μ¬νκ³ , νμν  λλ§λ€ ν¨μ¨μ μΌλ‘ μ κ·Όν  μ μλλ‘ κ΅¬νν΄μΌ ν©λλ€.
    override func prepare() {
        guard let collectionView = collectionView, cache.isEmpty else { return }
        
        let numberOfColumns: Int = 2 // ν νμ μμ΄ν κ°―μ
        let cellPadding: CGFloat = 5
        let cellWidth: CGFloat = contentWidth / CGFloat(numberOfColumns)
        
        let xOffSet: [CGFloat] = [0, cellWidth] // cell μ x μμΉλ₯Ό λνλ΄λ λ°°μ΄
        var yOffSet: [CGFloat] = .init(repeating: 0, count: numberOfColumns) // // cell μ y μμΉλ₯Ό λνλ΄λ λ°°μ΄
        
        var column: Int = 0 // νμ¬ νμ μμΉ
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            // IndexPath μ λ§λ μμ ν¬κΈ°, μμΉλ₯Ό κ³μ°ν©λλ€.
            let indexPath = IndexPath(item: item, section: 0)
            let imageHeight = delegate?.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath) ?? 180
            let height = cellPadding * 2 + imageHeight
            
            let frame = CGRect(x: xOffSet[column],
                               y: yOffSet[column],
                               width: cellWidth,
                               height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // μμμ κ³μ°ν Frame μ κΈ°λ°μΌλ‘ cache μ λ€μ΄κ° λ μ΄μμ μ λ³΄λ₯Ό μΆκ°ν©λλ€.
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // μ½λ μ λ·°μ contentHeight λ₯Ό λ€μ μ§μ ν©λλ€.
            contentHeight = max(contentHeight, frame.maxY)
            yOffSet[column] = yOffSet[column] + height
            
            // λ€λ₯Έ μ΄λ―Έμ§ ν¬κΈ°λ‘ μΈν΄μ, νμͺ½ μ΄μλ§ μ΄λ―Έμ§κ° μΆκ°λλ κ²μ λ°©μ§ν©λλ€.
            column = yOffSet[0] > yOffSet[1] ? 1 : 0
        }
    }
    
    // 3. λͺ¨λ  μκ³Ό λ³΄μΆ© λ·°μ λ μ΄μμ μ λ³΄λ₯Ό λ¦¬ν΄ν©λλ€. νλ©΄ νμ μμ­ κΈ°λ°(Rect)μ μμ²­μ΄ λ€μ΄μ¬ λ μ¬μ©ν©λλ€.
        override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
            var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
            
            for attributes in cache {
                if attributes.frame.intersects(rect) { // μ frame κ³Ό μμ²­ Rect κ° κ΅μ°¨νλ€λ©΄, λ¦¬ν΄ κ°μ μΆκ°ν©λλ€.
                    visibleLayoutAttributes.append(attributes)
                }
            }
            
            return visibleLayoutAttributes
        }
        
        // 4. λͺ¨λ  μμ λ μ΄μμ μ λ³΄λ₯Ό λ¦¬ν΄ν©λλ€. IndexPath λ‘ μμ²­μ΄ λ€μ΄μ¬ λ μ΄ λ©μλλ₯Ό μ¬μ©ν©λλ€.
        override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
            return cache[indexPath.item]
        }
}
```
- MainVC μμ PinterestLayoutDelegate λ₯Ό μ±ν.

```swift
// MARK: - UICollectionViewDelegateFlowLayout
extension MainVC: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let cellWidth: CGFloat = (view.bounds.width - 4) / 2 // μ κ°λ‘ ν¬κΈ°
        let imageHeight = imageList[indexPath.item].image.size.height
        let imageWidth = imageList[indexPath.item].image.size.width
        // μ΄λ―Έμ§ λΉμ¨
        let imageRatio = imageHeight/imageWidth
        
        
        return imageRatio * cellWidth
    }
}
```

### μΆμ²
μΆμ²γ£[Swift. UICollectionView Pinterest λ μ΄μμ](https://devmjun.github.io/archive/CollectionView-Pinterest)
