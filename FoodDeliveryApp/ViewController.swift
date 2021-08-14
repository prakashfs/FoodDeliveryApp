//
//  ViewController.swift
//  FoodDeliveryApp
//
//  Created by Prakash Sengirayar on 8/8/21.
//

import UIKit

class ViewController: UIViewController {

    var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHomeUI()
    }
    
    func setupHomeUI() {
        
        let collectiViewLayout = UICollectionViewFlowLayout()
        //collectiViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectiViewLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        
//        collectiViewLayout.itemSize = CGSize(width: self.view.frame.width - 40, height: 500)
//        collectiViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 5, right: 15)
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: collectiViewLayout)
        myCollectionView?.register(HomeImageSliderView.self,
                                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                   withReuseIdentifier: Constant.collectionViewHeaderIdentifier)
        
        myCollectionView.register(UINib.init(nibName: "FoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constant.collectionViewCellIdentifier)
//        myCollectionView?.register(FoodInfoCell.self, forCellWithReuseIdentifier: Constant.collectionViewCellIdentifier )
        
        
        
        myCollectionView.backgroundColor = .white
        myCollectionView?.delegate = self
        myCollectionView?.dataSource = self
        myCollectionView.showsVerticalScrollIndicator = false
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(myCollectionView)
    }


}

