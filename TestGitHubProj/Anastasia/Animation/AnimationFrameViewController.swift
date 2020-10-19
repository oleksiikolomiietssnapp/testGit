//
//  AnimationFrameViewController.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 16.10.2020.
//

import UIKit

class AnimationFrameViewController: UIViewController {
    var animationDuration = 10.0
    private let squareSideValue = 80.0
    private var squareMaxXPosition: Double {
        return Double(view.frame.width) - self.squareSideValue
    }
    private var squareMaxYPosition: Double {
        return Double(view.frame.height) - self.squareSideValue
    }
    private var xAxisMovementDuration: Double {
        return (Double(animationDuration / 2) / (Double(view.frame.height + view.frame.width) - squareSideValue * 2)) * Double(view.frame.width - squareSideValue)
    }
    private var yAxisMovementDuration: Double {
        return (Double(animationDuration / 2) / (Double(view.frame.height + view.frame.width)  - squareSideValue * 2)) * Double(view.frame.height - squareSideValue)
    }
    private var relativeXMovementDuration: Double {
        return xAxisMovementDuration / animationDuration
    }
    private var relativeYMovementDuration: Double {
        return yAxisMovementDuration / animationDuration
    }
    
    private lazy var square = { return UIView(frame: CGRect(x: 0, y: 0, width: squareSideValue, height: squareSideValue)) }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(square)
        view.backgroundColor = .systemGray
        square.backgroundColor = .red
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        square.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        square.translatesAutoresizingMaskIntoConstraints = false
        UIView.animateKeyframes(withDuration: animationDuration,
                                delay: 0,
                                options: [.repeat, .calculationModeLinear],
                                animations: { [self] in
                                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: relativeXMovementDuration) { [self] in
                                        square.frame.origin.x = view.frame.width - CGFloat(squareSideValue)
                                    }
                                    UIView.addKeyframe(withRelativeStartTime: relativeXMovementDuration, relativeDuration: relativeYMovementDuration) { [self] in
                                        square.frame.origin.y = view.frame.height - CGFloat(squareSideValue)
                                    }
                                    UIView.addKeyframe(withRelativeStartTime: relativeYMovementDuration + relativeXMovementDuration, relativeDuration: relativeXMovementDuration) { [self] in
                                        square.frame.origin.x = 0
                                    }
                                    UIView.addKeyframe(withRelativeStartTime: relativeXMovementDuration * 2 + relativeYMovementDuration, relativeDuration: relativeYMovementDuration) { [self] in
                                        square.frame.origin.y = 0
                                    }
                                })
    }
}
