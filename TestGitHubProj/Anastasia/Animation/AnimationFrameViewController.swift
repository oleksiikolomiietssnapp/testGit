//
//  AnimationFrameViewController.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 16.10.2020.
//

import UIKit

class AnimationFrameViewController: UIViewController {
    var animationDuration = 1.0
    var reversed = false
    var repeated = false
    
    private let squareSideValue = 80.0
    
    private var xAxisMovementAnimator: UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: animationDuration, curve: .linear) { [self] in
            square.center.x = CGFloat(squareMaxXPosition)
        }
    }
    private var yAxisMovementAnimator: UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: animationDuration, curve: .linear) { [self] in
            square.center.y = CGFloat(squareMaxYPosition)
        }
    }
    
    private var squarePosition: CGPoint {
        return square.center
    }
    private var viewPerimetr: Double {
        return Double(view.frame.width + view.frame.height) * 2
    }
    private var squareMaxXPosition: Double {
        return Double(view.frame.width) - self.squareSideValue / 2
    }
    private var squareMaxYPosition: Double {
        return Double(view.frame.height) - self.squareSideValue / 2
    }
    private var xAxisMovementDuration: Double {
        let shift = Double(view.frame.width) - squareSideValue
        return (animationDuration / (viewPerimetr - squareSideValue * 4)) * shift
    }
    private var yAxisMovementDuration: Double {
        let shift = Double(view.frame.height) - squareSideValue
        return (animationDuration / (viewPerimetr - squareSideValue * 4)) * shift
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
        AnastasiiaAnimationViewController.delegate = self
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 0.4
        view.addSubview(square)
        square.frame.size = CGSize(width: squareSideValue, height: squareSideValue)
        square.backgroundColor = .red
    }
}

extension AnimationFrameViewController: AnimationDelegate {
    func startAnimation() {
        xAxisMovementAnimator.startAnimation()
        xAxisMovementAnimator.addCompletion({ _ in
                                                print(11)
                                                self.yAxisMovementAnimator.startAnimation() })
//                UIView.animateKeyframes(withDuration: animationDuration,
//                                        delay: 0,
//                                        options: [.repeat, .calculationModeLinear],
//                                        animations: { [self] in
//                                            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: relativeXMovementDuration) { [self] in
//                                                square.center.x = view.frame.width - CGFloat(squareSideValue / 2)
//                                            }
//                                            UIView.addKeyframe(withRelativeStartTime: relativeXMovementDuration, relativeDuration: relativeYMovementDuration) { [self] in
//                                                square.center.y = view.frame.height - CGFloat(squareSideValue / 2)
//                                            }
//                                            UIView.addKeyframe(withRelativeStartTime: relativeYMovementDuration + relativeXMovementDuration, relativeDuration: relativeXMovementDuration) { [self] in
//                                                square.center.x = CGFloat(squareSideValue / 2)
//                                            }
//                                            UIView.addKeyframe(withRelativeStartTime: relativeXMovementDuration * 2 + relativeYMovementDuration, relativeDuration: relativeYMovementDuration) { [self] in
//                                                square.center.y = CGFloat(squareSideValue / 2)
//                                            }
//                                        })
        
    }
    
    func pauseAnimation() {
        UIView.animateKeyframes(withDuration: 0, delay: 0, options: [], animations: { [self] in
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: relativeXMovementDuration) { [self] in
                square.center = squarePosition
            }
        })
        square.center = square.center
    }
    
    func stopAnimation() {
        square.center = CGPoint(x: squareSideValue / 2, y: squareSideValue / 2)
    }
    
    func continueAnimation() {
        
    }
    
}
