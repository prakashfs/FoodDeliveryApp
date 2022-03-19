//
//  FloatingButton.swift
//  FoodDeliveryApp
//
//  Created by Prakash Sengirayar on 15/8/21.
//

import UIKit

class FloatingButton: UIButton {
    
    var badgeLabel = UILabel()
    
    var badge: Int? {
        didSet {
            addBadgeToButon(badge: badge)
        }
    }

    public var badgeBackgroundColor = UIColor.red {
        didSet {
            badgeLabel.backgroundColor = badgeBackgroundColor
        }
    }
    
    public var badgeTextColor = UIColor.white {
        didSet {
            badgeLabel.textColor = badgeTextColor
        }
    }
    
    public var badgeFont = UIFont.systemFont(ofSize: 12.0) {
        didSet {
            badgeLabel.font = badgeFont
        }
    }
    
    public var badgeEdgeInsets: UIEdgeInsets? {
        didSet {
            addBadgeToButon(badge: badge)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.updateUI()
        badgeLabel.textColor = badgeTextColor
        badgeLabel.backgroundColor = badgeBackgroundColor
        badgeLabel.font = badgeFont
        badgeLabel.textAlignment = .center
        
        badgeLabel.layer.masksToBounds = true
        addSubview(badgeLabel)
        self.addBadgeToButon(badge: nil)
    }
    
    func updateUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 25
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
    }
    
    func addBadgeToButon(badge: Int?) {
        guard let badge = badge else { return }
        badgeLabel.text = "\(badge)"
        badgeLabel.sizeToFit()
        self.updateBadgeLabelFrame()
        badgeLabel.layer.cornerRadius = badgeLabel.frame.height/2
        badgeLabel.isHidden = badge > 0 ? false : true
    }
    
    func updateBadgeLabelFrame() {
        let badgeSize = badgeLabel.frame.size
        
        let height = max(18, Double(badgeSize.height) + 5.0)
        let width = max(height, Double(badgeSize.width) + 10.0)
        
        var vertical: Double?, horizontal: Double?
        if let badgeInset = self.badgeEdgeInsets {
            vertical = Double(badgeInset.top) - Double(badgeInset.bottom)
            horizontal = Double(badgeInset.left) - Double(badgeInset.right)
            
            let x = (Double(bounds.size.width) - 10 + horizontal!)
            let y = -(Double(badgeSize.height) / 2) - 10 + vertical!
            badgeLabel.frame = CGRect(x: x, y: y, width: width, height: height)
        } else {
            let x = self.frame.width - CGFloat((width / 2.0))
            let y = CGFloat(-(height / 2.0))
            badgeLabel.frame = CGRect(x: x, y: y, width: CGFloat(width), height: CGFloat(height))
        }
        
    }
    
    func badgeCount() -> Int {
        guard let badgeText = badgeLabel.text, !badgeText.isEmpty else { return 0 }
        return Int(badgeText) ?? 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addBadgeToButon(badge: nil)
    }
}

