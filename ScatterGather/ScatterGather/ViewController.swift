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
        lambdaLabels.forEach {
            $0.font = .systemFont(ofSize: 60, weight: .bold)
            $0.translatesAutoresizingMaskIntoConstraints = false
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
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6) {
                self.lambdaLabels.forEach {
                    let minX = self.view.safeAreaInsets.left
                    let minY = self.view.safeAreaInsets.top
                    let maxX = self.view.frame.width - $0.frame.width - self.view.safeAreaInsets.right
                    let maxY = self.view.frame.height - $0.frame.height - self.view.safeAreaInsets.bottom
                    
                    let randomOrigin = CGPoint(x: .random(in: minX...maxX), y: .random(in: minY...maxY))
                    let convertedOrigin = self.view.convert(randomOrigin, to: self.stackView)
                    $0.frame.origin = convertedOrigin
                }
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.6, animations: {
                self.lambdaLabels.forEach {
                    $0.textColor = .random
                    $0.backgroundColor = .random
                }
            })
        }
        
        UIView.animateKeyframes(withDuration: 4.0, delay: 0, options: [], animations: scatterAnimationBlock, completion: nil)
    }
    
    func performGatherAnimation() {
        
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

extension UIColor {
    static var random: UIColor {
        .init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
    }
}
