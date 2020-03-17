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
    private var isScattered = false
    
    private let lLabel = UILabel(text: "L")
    private let aLabel = UILabel(text: "a")
    private let mLabel = UILabel(text: "m")
    private let bLabel = UILabel(text: "b")
    private let dLabel = UILabel(text: "d")
    private let a2Label = UILabel(text: "a")
    
    private var lambdaLabels: [UILabel] {
        [lLabel, aLabel, mLabel, bLabel, dLabel, a2Label]
    }
    
    
    private func setupLabels() {
        lambdaLabels.forEach {
            $0.font = .systemFont(ofSize: 60, weight: .bold)
        }
        
        let stackView = UIStackView(arrangedSubviews: lambdaLabels)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            NSLayoutConstraint(
                item: stackView,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: view,
                attribute: .centerY,
                multiplier: 0.5,
                constant: 0
            )
        ])
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        // Do any additional setup after loading the view.
    }


}

extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
    }
}