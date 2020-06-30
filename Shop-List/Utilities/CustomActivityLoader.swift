//
//  CustomActivityLoader.swift
//  Shop-List
//
//  Created by Legends on 27/06/20.
//  Copyright © 2020 Legends. All rights reserved.
//

import UIKit

class CustomActivityLoader: UIView {
  
    fileprivate var overlayView: UIView!
    fileprivate var containerView: UIView!
    fileprivate var logoImageView: UIImageView!
    fileprivate var rightshapeLayer = CAShapeLayer()

    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

///        Creates a new HUD, adds it to provided view and shows it. The counterpart to this method is hideProgress:.
///        @param view The view that the HUD will be added to
    
    class func showProgress(_ view: UIView) {
        if CustomActivityLoader.hud(forView: view) == nil {
            view.addSubview(self.init(frame: view.bounds))
        }

    }

    fileprivate class func hud(forView view: UIView) -> CustomActivityLoader? {
        for hudView in view.subviews {
            if hudView.isKind(of: self) {
               return hudView as? CustomActivityLoader
            }
        }
        return nil
    }

///     Hides a HUD from the provided view..
///     @param view The view that the HUD will be removed from

    class func hideProgress(_ view: UIView) {
        for hudView in view.subviews {
            if hudView.isKind(of: self) {
                hudView.removeFromSuperview()
            }
        }
    }
}

extension CustomActivityLoader {
///        Only override draw() if you perform custom drawing.
///        An empty implementation adversely affects performance during animation.
       override func draw(_ rect: CGRect) {
///            Drawing code
       }

       override func layoutSubviews() {
           super.layoutSubviews()
       }
    
///        Intialize views and set the constraints
       fileprivate func commonInit() {
            self.setup()
            self.addOverlayContraints()
            self.addContainerViewConstraints()
            self.addImageViewConstraints()

            logoImageView.setNeedsLayout()
            logoImageView.layoutIfNeeded()

            containerView.setNeedsLayout()
            containerView.layoutIfNeeded()

            overlayView.setNeedsLayout()
            overlayView.layoutIfNeeded()

            self.addBezierCurve()
        }

       private func setup() {
           overlayView = UIView()
           overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
           overlayView.translatesAutoresizingMaskIntoConstraints = false
           self.addSubview(overlayView)

           containerView = UIView()
           containerView.backgroundColor = .clear
           containerView.translatesAutoresizingMaskIntoConstraints = false
           overlayView.addSubview(containerView)

           let image = UIImage(named: "logo-symbol")
          logoImageView = UIImageView(image: image)
          logoImageView.translatesAutoresizingMaskIntoConstraints = false
          containerView.addSubview(logoImageView)
       }

       fileprivate func addOverlayContraints() {
///           Leading
           self.addConstraint(NSLayoutConstraint(item: overlayView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))

///           Trailing
           self.addConstraint(NSLayoutConstraint(item: overlayView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))

///           Top
           self.addConstraint(NSLayoutConstraint(item: overlayView!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0))

///           Bottom
           self.addConstraint(NSLayoutConstraint(item: overlayView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0))
       }

       fileprivate func addContainerViewConstraints() {
///           Center X
           overlayView.addConstraint(NSLayoutConstraint(item: containerView!, attribute: .centerX, relatedBy: .equal, toItem: overlayView!, attribute: .centerX, multiplier: 1.0, constant: 0.0))

///            Center Y
            overlayView.addConstraint(NSLayoutConstraint(item: containerView!, attribute: .centerY, relatedBy: .equal, toItem: overlayView, attribute: .centerY, multiplier: 1.0, constant: 0.0))

///           Width
           overlayView.addConstraint(NSLayoutConstraint(item: containerView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80.0))

///           Height
           overlayView.addConstraint(NSLayoutConstraint(item: containerView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80.0))
       }

       fileprivate func addImageViewConstraints() {
///             Center X
             containerView.addConstraint(NSLayoutConstraint(item: logoImageView!, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
///             Center Y
             containerView.addConstraint(NSLayoutConstraint(item: logoImageView!, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
///             Width
               containerView.addConstraint(NSLayoutConstraint(item: logoImageView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60.0))
///             Height
             containerView.addConstraint(NSLayoutConstraint(item: logoImageView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60.0))
       }
       
///            Draw bezier curve (arc) around the image provided. Note that the logoImageView is added on top of containerView which is placed at the center w.r.t to parent view.
    
       fileprivate func addBezierCurve() {
            let size =  self.logoImageView.frame.size
            let lineWidth: CGFloat = 6.0
            let radius = size.width/2
            let bezierPath = UIBezierPath()
            let center = self.logoImageView.center
           bezierPath.addArc(withCenter: center, radius: radius, startAngle: CGFloat(Double.pi/2), endAngle: CGFloat((Double.pi)), clockwise: true)

               rightshapeLayer.path = bezierPath.cgPath
               rightshapeLayer.strokeColor = UIColor.appThemeColor().cgColor
               rightshapeLayer.fillColor = UIColor.clear.cgColor
               rightshapeLayer.lineWidth = lineWidth
               rightshapeLayer.lineCap = CAShapeLayerLineCap.round
               rightshapeLayer.bounds = self.containerView.bounds
               rightshapeLayer.position =  self.logoImageView.center
               containerView.layer.insertSublayer(rightshapeLayer, above: nil)

               let rotation = CABasicAnimation(keyPath: "transform.rotation")
               rotation.byValue = NSNumber(value: 2*Double.pi as Double)
               rotation.duration = 1.0
               rotation.repeatCount = Float.infinity
               rightshapeLayer.add(rotation, forKey: "lineRotation")
       }
}

extension UIViewController {

///        Show Progress in Caller View
    func showProgress() {
        DispatchQueue.main.async {
            CustomActivityLoader.showProgress(self.view)
        }
    }
///       Hide/Remove Progress from Caller View
    func hideProgress() {
        DispatchQueue.main.async {
            CustomActivityLoader.hideProgress(self.view)
        }
    }
}
