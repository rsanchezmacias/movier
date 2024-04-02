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
    private var tapGestureRecognizer: UITapGestureRecognizer!
    private var tapFeedbackGenerator: UINotificationFeedbackGenerator!
    
    private var originalCenter: CGPoint = .zero
    private var originalTransform: CGAffineTransform = .identity
    private var angleDirection: CGFloat = 1
    
    // MARK: - Settable properties
    
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
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        addGestureRecognizer(panGestureRecognizer)
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        addGestureRecognizer(tapGestureRecognizer)
        
        tapFeedbackGenerator = UINotificationFeedbackGenerator()
        
        addShadow()
    }
    
    private func addShadow() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    func hideShadow() {
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 0
    }
    
    func showShadow() {
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 10
    }
    
}

// MARK: - Touch Gesture

extension SwipeableCardView {
    
    @objc private func handleTapGesture(_ recognizer: UITapGestureRecognizer) {
        originalTransform = transform
        originalCenter = center
        tapFeedbackGenerator.notificationOccurred(.warning)
        let location = recognizer.location(in: self)
        let tapDirection: CGFloat = (location.x < center.x) ? -1 : 1
        
        UIView.animate(withDuration: 0.1) { [weak self] in
            guard let self = self else { return }
            let angle = (CGFloat.pi / 32) * tapDirection
            var rotationTransform = CATransform3DIdentity
            rotationTransform.m34 = -1.0 / 500.0
            
            rotationTransform = CATransform3DRotate(rotationTransform, angle, 0, 1, 0)
            rotationTransform = CATransform3DScale(rotationTransform, 1, 1, max(cos(angle), 0.2))
            
            // self.transform = CATransform3DGetAffineTransform(rotationTransform)
            self.layer.transform  = rotationTransform
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.resetCardPosition()
        }
    }
    
}

// MARK: - Pan Gesture

extension SwipeableCardView {
    
    @objc private func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {        
        let translation = recognizer.translation(in: self)
        let location = recognizer.location(in: self)
        
        switch recognizer.state {
        case .began:
            self.panningDidStart(location: location)
        case .changed:
            self.handlePanning(translation: translation)
        case .ended:
            self.panningDidEnd(translation: translation)
        default:
            break
        }
    }
    
    private func panningDidStart(location: CGPoint) {
        originalCenter = center
        originalTransform = transform
        angleDirection = (self.bounds.height / 2) <= location.y ? -1 : 1
    }
    
    private func handlePanning(translation: CGPoint) {
        // Property to tell how far have we moved horizontally from the center
        let screenWidth: CGFloat = CGFloat(self.window?.screen.bounds.width ?? 0)
        let translationStrength = max(min(translation.x / screenWidth, 1), -1)
        
        let rotationAngle = (CGFloat.pi / 8) * translationStrength * angleDirection
        
        let scaleFactor = 1 - abs(translationStrength) / 4
        let scale = max(scaleFactor, 0.93)
        
        let transform = CGAffineTransform(rotationAngle: rotationAngle)
            .translatedBy(x: translation.x, y: translation.y)
            .scaledBy(x: scale, y: scale)
        self.transform = transform
    }
    
    private func panningDidEnd(translation: CGPoint) {
        if translation.x > 100 {
            animateSwipe(translation: CGPoint(x: bounds.width * 2, y: 0), direction: .right)
        } else if translation.x < -100 {
            animateSwipe(translation: CGPoint(x: -bounds.width * 2, y: 0), direction: .left)
        } else {
            resetCardPosition()
        }
    }
    
    private func animateSwipe(translation: CGPoint, direction: SwipeDirection) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
        }) { [weak self] _ in
            self?.removeFromSuperview()
            self?.delegate?.didSwipeCard(direction)
        }
    }
    
    private func resetCardPosition() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.center = self.originalCenter
            self.transform = self.originalTransform
        }
    }
    
}
