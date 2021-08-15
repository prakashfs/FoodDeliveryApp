//
//  HomeImageSliderView.swift
//  FoodDeliveryApp
//
//  Created by Prakash Sengirayar on 9/8/21.
//

import UIKit

struct HeaderCellModel {
    let imageNames: [String]?
    let title: String?
    let subTitle: String?
    let buttonTitles: [String]?
    let filterLable: String?
    let filterSpicyOption: String?
    let filterVeganOption: String?
}

class HomeImageSliderView: UICollectionReusableView {
    
    let imageNames = ["home_1","home_2","home_3","home_4"]
    let buttonTitles = ["Pizza","Sushi","Drinks"]
    var imageScrollView : UIScrollView!
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    var filterView: UIView!
    var foodMenuButtons = [UIButton]()
    var delegate: ProductUpdateDelegate?
    var headerModel : HeaderCellModel? {
        didSet {
            titleLabel.text = headerModel?.title
            subTitleLabel.text = headerModel?.subTitle
        }
    }
    
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
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        titleLabel.text = "DinDin Foods"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22.0)
        titleLabel.textColor = UIColor.white
        return titleLabel
    }
    
    fileprivate func getSubTitle() -> UILabel {
        subTitleLabel = UILabel(frame: CGRect(x: 0, y: self.titleLabel.frame.height, width: self.frame.width, height: 20))
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

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: itemWidth , height: itemHeight))
        label.text = "FILTERS"
        label.font = UIFont.init(name: "Verdana", size: 14)
        label.textColor = .lightGray
        let spicyButton = UIButton(frame: CGRect(x: Int(label.frame.width), y: 0, width: itemWidth, height: itemHeight))
        spicyButton.setTitle("Spicy", for: .normal)
        spicyButton.setTitleColor(.lightGray, for: .normal)
        spicyButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        spicyButton.layer.cornerRadius = 12
        spicyButton.layer.borderWidth = 1.0
        spicyButton.layer.borderColor = UIColor.lightGray.cgColor
        let veganButton = UIButton(frame: CGRect(x: Int(spicyButton.frame.maxX) + 10, y: 0, width: itemWidth, height: itemHeight))
        veganButton.setTitle("Vegan", for: .normal)
        veganButton.setTitleColor(.lightGray, for: .normal)
        veganButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        veganButton.layer.cornerRadius = 12
        veganButton.layer.borderWidth = 1.0
        veganButton.layer.borderColor = UIColor.lightGray.cgColor
        
        foodType.addSubview(label)
        foodType.addSubview(spicyButton)
        foodType.addSubview(veganButton)
        
    }
    
    fileprivate func alignViewCenter(_ buttonViews: UIView, _ foodType: UIView) {
        buttonViews.center = CGPoint(x: filterView.frame.size.width/2,
                                     y: filterView.bounds.origin.y + 60)
        foodType.center = CGPoint(x: filterView.frame.size.width/2,
                                  y: buttonViews.frame.size.height + 70)
    }
    
    func setupHeader() {
        
        imageScrollView = setupScollview()
        scrolledCount = 0
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(autoScrollImage), userInfo: nil, repeats: true)
        
        
        filterView = UIView(frame: CGRect(x: 0, y: imageScrollView.frame.height - 150, width: self.frame.width, height: 150))
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
        
        let foodType = UIView()
        composeFoodCategory(foodType, buttonViews, filterView)
        
        filterView.addSubview(buttonViews)
        filterView.addSubview(foodType)
        
        alignViewCenter(buttonViews, foodType)
        
        let titleLabel = getTitle()
        let subTitleLabel = getSubTitle()
        self.addSubview(imageScrollView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        self.addSubview(filterView)
        
        self.updateButtonState(.Pizza) //Defaulted for initial load
    }
    
    func mainFilterButton() -> [UIButton]? {
        let staticWidth = filterView.frame.size.width/CGFloat(buttonTitles.count)
        for buttonIndex in 0...buttonTitles.count-1 {
            let uiButton = UIButton(frame: CGRect(x: CGFloat(buttonIndex) * staticWidth,
                                                  y: 0,
                                                  width: staticWidth,
                                                  height: 50))
            uiButton.backgroundColor = .clear
            uiButton.setTitleColor(.lightGray, for: .normal)
            uiButton.setTitleColor(.black, for: .selected)
            uiButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
            uiButton.setTitle("\(buttonTitles[buttonIndex])", for: .normal)
            uiButton.contentHorizontalAlignment = .left
            uiButton.tag = buttonIndex + 1
            uiButton.addTarget(self, action: #selector(menuTapped(_:)), for: .touchUpInside)
            foodMenuButtons.append(uiButton)
        }
        return foodMenuButtons
    }
    
    @objc func menuTapped(_ sender: UIButton) {
        let selectedMenu = FoodType(rawValue: sender.tag)
        self.updateButtonState(selectedMenu)
        if delegate != nil {
            delegate?.loadProduct(type: selectedMenu)
        }
    }
    
    fileprivate func updateButtonState(_ selectedButton: FoodType?) {
        guard let selectedButton = selectedButton else { return }
        DispatchQueue.main.async {
            _ = self.foodMenuButtons.map{ $0.isSelected = ($0.tag == selectedButton.rawValue) }
        }
    }
    
    @objc func autoScrollImage() {
        scrolledCount = scrolledCount < imageNames.count - 1 ? scrolledCount + 1 : 0
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: { [self] in
                imageScrollView.contentOffset.x = CGFloat(self.scrolledCount) * self.frame.size.width
            }, completion: nil)
        }
        
    }
    
    func setupScollview() -> UIScrollView {
        let uiScrollview = UIScrollView()
        uiScrollview.frame = CGRect(x: 0, y: -statusBarHeight(), width: self.frame.width * CGFloat(imageNames.count), height: self.frame.height)
        uiScrollview.isPagingEnabled = true
        for (index, value) in imageNames.enumerated() {
            let imageView = UIImageView.init(frame: CGRect(x: CGFloat(index) * self.bounds.size.width, y: 0, width: self.frame.width, height: self.frame.height))
            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(named: value)
            uiScrollview.addSubview(imageView)
            
        }
        return uiScrollview
    }
    
    func statusBarHeight() -> CGFloat {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let height = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        return height
    }
    
}
