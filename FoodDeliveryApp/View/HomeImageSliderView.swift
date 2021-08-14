//
//  HomeImageSliderView.swift
//  FoodDeliveryApp
//
//  Created by Prakash Sengirayar on 9/8/21.
//

import UIKit

class HomeImageSliderView: UICollectionReusableView {
    
    let imageNames = ["Image_1","Image_2","Image_3","Image_4"]
    let buttonTitles = ["Pizza","Sushi","Drinks"]
    var imageScrollView : UIScrollView!
    
    var timer: Timer!
    var scrolledCount: Int!
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupHeader()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupHeader()
    }
    
    fileprivate func getTitle() -> UILabel {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        titleLabel.text = "Din Din Foods"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleLabel.textColor = UIColor.white
        return titleLabel
    }
    
    fileprivate func getSubTitle() -> UILabel {
        let subTitleLabel = UILabel(frame: CGRect(x: 0, y: 20, width: self.frame.width, height: 50))
        subTitleLabel.text = "delivery"
        subTitleLabel.textAlignment = .center
        subTitleLabel.font = UIFont.systemFont(ofSize: 20.0)
        subTitleLabel.textColor = UIColor.white
        return subTitleLabel
    }
    
    
    fileprivate func composeFoodCategory(_ foodType: UIView, _ buttonViews: UIView, _ filterView: UIView) {
        
        foodType.frame = CGRect(x: 0, y: 0, width: filterView.frame.size.width - 40, height: 50)
        
        let itemWidth = 80
        let itemHeight = 25

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: itemWidth + 20 , height: itemHeight))
        label.text = "F I L T E R S"
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .darkGray
        let spicyButton = UIButton(frame: CGRect(x: Int(label.frame.width), y: 0, width: itemWidth, height: itemHeight))
        spicyButton.setTitle("Spicy", for: .normal)
        spicyButton.setTitleColor(.darkGray, for: .normal)
        spicyButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        spicyButton.layer.cornerRadius = 12
        spicyButton.layer.borderWidth = 1.0
        spicyButton.layer.borderColor = UIColor.darkGray.cgColor
        let veganButton = UIButton(frame: CGRect(x: Int(spicyButton.frame.maxX) + 10, y: 0, width: itemWidth, height: itemHeight))
        veganButton.setTitle("Vegan", for: .normal)
        veganButton.setTitleColor(.darkGray, for: .normal)
        veganButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        veganButton.layer.cornerRadius = 12
        veganButton.layer.borderWidth = 1.0
        veganButton.layer.borderColor = UIColor.darkGray.cgColor
        
        foodType.addSubview(label)
        foodType.addSubview(spicyButton)
        foodType.addSubview(veganButton)
        
        foodType.center = CGPoint(x: filterView.frame.size.width/2,
                                  y: buttonViews.frame.size.height + 60)
    }
    
    func setupHeader() {
        debugPrint("\(#function) called")
        imageScrollView = setupScollview()
        scrolledCount = 0
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(autoScrollImage), userInfo: nil, repeats: true)
        
        
        let filterView = UIView(frame: CGRect(x: 0, y: imageScrollView.frame.height - 150, width: self.frame.width, height: 150))
        filterView.backgroundColor = .white
        filterView.clipsToBounds = true
        filterView.layer.cornerRadius = 50
        filterView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        let buttonViews = UIView()
        buttonViews.frame = CGRect(x: 0, y: filterView.frame.minY, width: filterView.frame.size.width - 40, height: 50)
        if let buttons = mainFilterButton() {
            for buttonView in buttons {
                buttonViews.addSubview(buttonView)
            }
        }
        buttonViews.center = CGPoint(x: filterView.frame.size.width/2,
                                     y: filterView.bounds.origin.y + 50)
        
        filterView.addSubview(buttonViews)
        
        let foodType = UIView()
        composeFoodCategory(foodType, buttonViews, filterView)
        
        filterView.addSubview(foodType)
        
        let titleLabel = getTitle()
        let subTitleLabel = getSubTitle()
        self.addSubview(imageScrollView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        self.addSubview(filterView)
    }
    
    func mainFilterButton() -> [UIButton]? {
        var uiButtons = [UIButton]()
        
        let staticWidth = 120
        for i in 0...2 {
            let uiButton = UIButton(frame: CGRect(x: i * staticWidth,
                                                  y: 0,
                                                  width: staticWidth,
                                                  height: 50))
            uiButton.backgroundColor = .clear
            uiButton.setTitleColor(.black, for: .normal)
            uiButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
            uiButton.setTitle("\(buttonTitles[i])", for: .normal)
            uiButtons.append(uiButton)
        }
        return uiButtons
    }
    
    @objc func autoScrollImage() {
        debugPrint("\(#function) called \( CGFloat(self.scrolledCount) * self.bounds.size.width)")
        scrolledCount = scrolledCount < imageNames.count - 1 ? scrolledCount + 1 : 0
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: { [self] in
                imageScrollView.contentOffset.x = CGFloat(self.scrolledCount) * self.bounds.size.width
            }, completion: nil)
        }
        
    }
    
    func setupScollview() -> UIScrollView {
        let uiScrollview = UIScrollView()
        uiScrollview.frame = CGRect(x: 0, y: -45, width: self.frame.width * CGFloat(imageNames.count), height: self.frame.height)
        uiScrollview.isPagingEnabled = true
        for (index, value) in imageNames.enumerated() {
            let imageView = UIImageView.init(frame: CGRect(x: CGFloat(index) * self.bounds.size.width, y: 0, width: self.frame.width, height: self.frame.height))
            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(named: value)
            uiScrollview.addSubview(imageView)
            
        }
        return uiScrollview
    }
}
