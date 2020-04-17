//
//  CircularProgress.swift
//
//  Created by Nguyen on 4/16/20.
//

import UIKit

@IBDesignable
public final class CircularProgressView: UIView {

    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var trackLayer = CAShapeLayer()
    fileprivate var textLayer = CATextLayer()
    fileprivate let animationLabel = CATransition()
    fileprivate var duration: Double = 3
    fileprivate var timer: Timer!
    fileprivate var number: Int = 0
    fileprivate var value: Int = 0

    override public init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
    }

    @IBInspectable
    public var lineWidthTrack: CGFloat = 4.0 {
        didSet {
            trackLayer.lineWidth = lineWidthTrack
        }
    }

    @IBInspectable
    public var lineWidthProgress: CGFloat = 4.0 {
        didSet {
            progressLayer.lineWidth = lineWidthProgress
        }
    }

    @IBInspectable
    public var progressColor: UIColor = UIColor.red {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }

    @IBInspectable
    public var trackColor: UIColor = UIColor.lightGray {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }

    @IBInspectable
    public var textColor: UIColor = UIColor.red {
        didSet {
            textLayer.foregroundColor = textColor.cgColor
        }
    }

    @IBInspectable
    public var fontSize: CGFloat = 40.0 {
        didSet {
            textLayer.fontSize = fontSize
        }
    }

    fileprivate func createCircularPath() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width / 2.0
        let centerPoint = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        let circlePath = UIBezierPath(arcCenter: centerPoint, radius: (frame.size.width - 1.5)/2, startAngle: CGFloat(-(0.5 * Double.pi)), endAngle: CGFloat(1.5 * Double.pi), clockwise: true)

        trackLayer.path = circlePath.cgPath
        trackLayer.lineWidth = lineWidthTrack
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        layer.addSublayer(trackLayer)

        progressLayer.path = circlePath.cgPath
        progressLayer.lineWidth = lineWidthProgress
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)

        textLayer.frame = CGRect(x: 0, y: layer.frame.height / 2 - fontSize / 2, width: layer.frame.width, height: fontSize)
        textLayer.isWrapped = true
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.string = "0%"
        layer.addSublayer(textLayer)
    }

    public func setDuration(duration: Double) {
        self.duration = duration
    }

    public func setValue(value: Float) {
        self.number = 0
        self.value = Int(value * 100)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = value
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        progressLayer.add(animation, forKey: "progressAnim")

        timer = Timer.scheduledTimer(timeInterval: (duration / Double(value * 100)), target: self, selector: #selector(countUp), userInfo: nil, repeats: true)
    }

    @objc func countUp() {
        if number < value {
            number += 1
            textLayer.string = "\(number)%"
        } else {
            timer.invalidate()
        }
    }
}
