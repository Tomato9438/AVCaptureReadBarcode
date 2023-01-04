//
//  CircleView.swift
//  AVCaptureTest
//
//  Created by JimmyHarrington on 2019/06/16.
//  Copyright © 2019 JimmyHarrington. All rights reserved.
//

import UIKit

class BadgeView: UIView {
    var fillColor: UIColor // fillColor
    var number: Int // number
    init(frame: CGRect, fillColor: UIColor, number: Int) {
        self.fillColor = fillColor
        self.number = number
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        /*
         UIColor.clear.set()
         UIRectFill(rect)
         */
        let inner: CGFloat = rect.width/20.0
        let circlePath0 = UIBezierPath(arcCenter: CGPoint(x: rect.width/2.0, y: rect.width/2.0), radius: rect.width/2.0, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        circlePath0.close()
        UIColor.white.set()
        circlePath0.fill()
        
        let circlePath1 = UIBezierPath(arcCenter: CGPoint(x: rect.width/2.0, y: rect.width/2.0), radius: rect.width/2.0 - inner, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        circlePath1.close()
        fillColor.set()
        circlePath1.fill()
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 6.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        
        let fontSize = rect.width/2.0
        let atext = NSMutableAttributedString(string: String(number))
        let font = UIFont.systemFont(ofSize: fontSize)
        let range = NSMakeRange(0, String(number).count)
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.alignment = .center
        atext.addAttributes([NSAttributedString.Key.font: font], range: range)
        atext.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], range: range)
        atext.addAttributes([NSAttributedString.Key.paragraphStyle: titleParagraphStyle], range: range)
        let asize = atext.size()
        atext.draw(at: CGPoint(x: (rect.width - asize.width)/2.0, y: (rect.height - asize.height)/2.0))
    }
}
