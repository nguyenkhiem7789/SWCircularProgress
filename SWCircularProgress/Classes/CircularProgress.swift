//
//  CircularProgress.swift
//
//  Created by Nguyen on 4/16/20.
//

import UIKit

class CircularProgress: UIView {

    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var trackLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    var progressColor: UIColor = UIColor.red {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }

    override var trackColor: UIColor = UIColor.lightGray {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }

    fileprivate func createCircularPath() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width / 2.0
        let centerPoint = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        let circlePath = UIBezierPath(arcCenter: centerPoint, radius: (frame.size.width - 1.5)/2, startAngle: -(0.5 * Double.pi), endAngle: (1.5 * Double.pi), clockwise: true)
    }

}
