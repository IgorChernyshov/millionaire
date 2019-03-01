//
//  DarkBlueGradientView.swift
//  millionaire
//
//  Created by Igor Chernyshov on 01/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit

@IBDesignable
class DarkBlueGradientView: UIView {
  
  @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1) {
    didSet {
      setNeedsLayout()
    }
  }
  
  @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) {
    didSet {
      setNeedsLayout()
    }
  }
  
  override func layoutSubviews() {
    addGradientLayer()
    createRoundedBorders()
  }
  
  private func addGradientLayer() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    // These points allow to create a gradient that has topColor from top to almost the bottom of the view
    // and a little bit of bottomColor on the bottom border of the view which make text easier to read.
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.4)
    gradientLayer.frame = bounds
    layer.insertSublayer(gradientLayer, at: 0)
  }
  
  private func createRoundedBorders() {
    clipsToBounds = true
    let halfOfViewHeight = frame.height / 2.0
    layer.cornerRadius = halfOfViewHeight
    layer.borderWidth = 2.0
    layer.borderColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
  }
  
}
