//
//  SwipeableCard.swift
//  Movier
//
//  Created by Ricardo Sanchez-Macias on 4/1/24.
//

import UIKit

protocol SwipeableCardViewDelegate: AnyObject {
    func didSwipeCard(_ direction: SwipeDirection)
}

enum SwipeDirection {
    case left
    case right
}

class SwipeableCardView: UIView {
    
    private var panGestureRecognizer: UIPanGestureRecognizer!
    private var originalCenter: CGPoint = .zero
    private var originalTransform: CGAffineTransform = .identity
    
    weak var delegate: SwipeableCardViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addShadow()
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        addGestureRecognizer(panGestureRecognizer)
    }
    
    private func addShadow() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
        showShadow()
    }
    
    func hideShadow() {
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func showShadow() {
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    @objc private func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        
        switch recognizer.state {
        case .began:
            self.panningDidStart()
        case .changed:
            self.handlePanning(translation: translation)
        case .ended:
            self.panningDidEnd(translation: translation)
        default:
            break
        }
    }
    
    private func panningDidStart() {
        originalCenter = center
        originalTransform = transform
    }
    
    private func handlePanning(translation: CGPoint) {
        // Property to tell how far have we moved horizontally from the center
        let screenWidth: CGFloat = CGFloat(self.window?.screen.bounds.width ?? 0)
        let translationStrength = max(min(translation.x / screenWidth, 1), -1)
        
        let rotationAngle = (CGFloat.pi / 8) * translationStrength
        let scaleFactor = 1 - abs(translationStrength) / 4
        let scale = max(scaleFactor, 0.93)
        
        let transform = CGAffineTransform(rotationAngle: rotationAngle)
            .translatedBy(x: translation.x, y: translation.y)
            .scaledBy(x: scale, y: scale)
        self.transform = transform
    }
    
    private func panningDidEnd(translation: CGPoint) {
        if translation.x > 100 {
            animateSwipe(translation: CGPoint(x: bounds.width * 2, y: 0))
            delegate?.didSwipeCard(.right)
        } else if translation.x < -100 {
            animateSwipe(translation: CGPoint(x: -bounds.width * 2, y: 0))
            delegate?.didSwipeCard(.left)
        } else {
            resetCardPosition()
        }
    }
    
    private func animateSwipe(translation: CGPoint) {
        UIView.animate(withDuration: 0.3, animations: {
            self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    private func resetCardPosition() {
        UIView.animate(withDuration: 0.2) {
            self.center = self.originalCenter
            self.transform = self.originalTransform
        }
    }
}
