//
//  ViewController.swift
//  FoodDeliveryApp
//
//  Created by Prakash Sengirayar on 8/8/21.
//

import UIKit

class ViewController: UIViewController {
    
    var myCollectionView: UICollectionView!
    let floatingButton = FloatingButton()
    var foodDashboardViewModel = FoodDashboardViewModel.init(type: .Pizza)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHomeUI()
        self.setupMyCartButton()
        initiateAPIdata()
        initObserver()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    func setupMyCartButton() {
        
        let one4thOfScreenHeight = (view.frame.height/4)
        let floatingY = view.frame.height - (one4thOfScreenHeight/3) * 2
        floatingButton.frame = CGRect(x: ((view.frame.width/3) * 2.5), y: floatingY, width: 50, height: 50)
        floatingButton.setImage(UIImage(named: "cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        floatingButton.badgeEdgeInsets = UIEdgeInsets(top: 15, left: 2, bottom: 0, right: 10)
        floatingButton.addTarget(self, action: #selector(self.openCart), for: .touchDown)
        self.view.addSubview(floatingButton)
    }
    
    @objc func openCart() {
        //TODO open cart view controller
    }
    
    func initObserver() {
        
        let dispose = foodDashboardViewModel.parsedAPIresponse.asObservable().subscribe { foodCellModel in
            debugPrint("RX: response received. UPDATE UI")
            DispatchQueue.main.async {
                self.myCollectionView.reloadData()
            }
            
        } onError: { error in
            debugPrint("RX: Error received \(error.localizedDescription)")
        } onCompleted: {
            debugPrint("RX: completed")
        } onDisposed: {
            debugPrint("RX: disposed")
        }
        
        _ = foodDashboardViewModel.disposeBag.insert(dispose)
        
    }
    
    func initiateAPIdata() {
        self.foodDashboardViewModel.loadFoodItems(forType: .Pizza)
    }
    
    func setupHomeUI() {
        
        let collectiViewLayout = UICollectionViewFlowLayout()
        collectiViewLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: collectiViewLayout)
        myCollectionView?.register(HomeImageSliderView.self,
                                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                   withReuseIdentifier: Constant.collectionViewHeaderIdentifier)
        
        myCollectionView.register(UINib.init(nibName: Constant.collectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: Constant.collectionViewCellIdentifier)
        
        myCollectionView.backgroundColor = .white
        myCollectionView?.delegate = self
        myCollectionView?.dataSource = self
        myCollectionView.showsVerticalScrollIndicator = false
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(myCollectionView)
    }
    
    deinit {
        foodDashboardViewModel.disposeBag.dispose()
    }
}

