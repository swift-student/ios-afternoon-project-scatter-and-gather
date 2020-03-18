//
//  ViewController.swift
//  ScatterGather
//
//  Created by Shawn Gee on 3/17/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBActions
    
    @IBAction func toggleButtonPressed(_ sender: Any) {
        isScattered.toggle()
    }
    
    
    // MARK: - Private
    private var isScattered = false {
        didSet {
            if isScattered {
                performScatterAnimation()
            } else {
                performGatherAnimation()
            }
        }
    }
    
    private var lambdaLabels: [UILabel] = [
        UILabel(text: "L"),
        UILabel(text: "a"),
        UILabel(text: "m"),
        UILabel(text: "b"),
        UILabel(text: "d"),
        UILabel(text: "a")
    ]
    
    private lazy var stackView = UIStackView(arrangedSubviews: lambdaLabels)
    
    private var lambdaLogoView = UIImageView(image: UIImage(named: "lambda_logo"))
    
    private func setupLabels() {
        lambdaLabels.forEach { label in
            label.font = .systemFont(ofSize: 60, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        stackView.distribution = .fillProportionally

        
        lambdaLogoView.contentMode = .scaleAspectFit
        lambdaLogoView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        lambdaLogoView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(stackView)
        view.addSubview(lambdaLogoView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            NSLayoutConstraint(
                item: stackView,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: view,
                attribute: .centerY,
                multiplier: 0.5,
                constant: 0),
            lambdaLogoView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            lambdaLogoView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            lambdaLogoView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            lambdaLogoView.heightAnchor.constraint(lessThanOrEqualToConstant: 200)
        ])
        
    }
    
    func performScatterAnimation() {
        let scatterAnimationBlock = {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2) {
                self.lambdaLogoView.layer.opacity = 0
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0) {
                self.lambdaLabels.forEach { label in
                    let minX = self.view.safeAreaInsets.left
                    let minY = self.view.safeAreaInsets.top
                    let maxX = self.view.frame.width - label.frame.width - self.view.safeAreaInsets.right
                    let maxY = self.view.frame.height - label.frame.height - self.view.safeAreaInsets.bottom
                    
                    let randomOrigin = CGPoint(x: .random(in: minX...maxX), y: .random(in: minY...maxY))
                    let endOrigin = self.view.convert(randomOrigin, to: self.stackView)
                    
                    label.transform = .init(translationX: endOrigin.x - label.frame.origin.x, y: endOrigin.y - label.frame.origin.y)
                }
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.6, animations: {
                self.lambdaLabels.forEach { label in
                    label.layer.backgroundColor = .random
                    label.transform = label.transform.rotated(by: .random(in: 0...CGFloat.pi))
                }
            })
        }
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [], animations: scatterAnimationBlock, completion: nil)
    }
    
    func performGatherAnimation() {
        
        let gatherAnimationBlock = {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.lambdaLabels.forEach { label in
                    label.transform = .identity
                    label.layer.backgroundColor = .none
                }
            }
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                self.lambdaLogoView.layer.opacity = 1.0
            }
        }
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: [], animations: gatherAnimationBlock, completion: nil)
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
    }


}

extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
    }
}

extension CGColor {
    static var random: CGColor {
        .init(srgbRed: .random(in: 0...1), green: .random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
    }
}
