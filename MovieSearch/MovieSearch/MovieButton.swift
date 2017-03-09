//
//  MovieButton.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/4/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

@IBDesignable
class SearchButton: UIButton {
    
    @IBInspectable var startColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var endColor: UIColor = UIColor.black {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var isHorizontal: Bool = false {
        didSet{
            setupView()
        }
    }
    
    
    @IBInspectable var isGradientType: Bool = true {
        didSet {
            layer.addSublayer(gradientLayer)
            //layer.insertSublayer(gradientLayer, above: layer)
//            if isGradientType == true {
//                layer.insertSublayer(gradientLayer, above: layer)
//            }
        }
    }
    
    
    @IBInspectable var roundedButton: Bool {
        didSet {
            // layer.cornerRadius = 4
           // backgroundColor = .blue
            setTitleColor(.white, for: .normal)
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var background: UIColor = UIColor() {
        didSet {
            //backgroundColor = background
        }
    }
    
    @IBInspectable var borderColor: UIColor? = UIColor() {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    override init(frame: CGRect) {
        roundedButton = true
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder? = nil) {
        roundedButton = true
        if let coder = aDecoder {
            super.init(coder: coder)!
        } else {
            super.init()
        }
    }
    
    
    private func setupView(){
        
        let colors:Array = [startColor.cgColor, endColor.cgColor]
        gradientLayer.colors = colors
        if isHorizontal {
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        } else {
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        }
        
        self.setNeedsDisplay()
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBInspectable var gradientLayer: CAGradientLayer {
        return CAGradientLayer(layer: layer)
    }
}
