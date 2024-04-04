//
//  MovieSwipeableCardView.swift
//  Movier
//
//  Created by Ricardo Sanchez-Macias on 4/4/24.
//

import UIKit
import Lottie

// TODO: - Refactor and clean up class

class MovieSwipeableCardView: SwipeableCardView {
    
    struct Constants {
        static let animationShake: String = "shake"
        static let animationNod: String = "nod"
    }
    
    private var nodAnimationView: LottieAnimationView!
    private var shakeAnimationView: LottieAnimationView!
    private weak var activeAnimation: LottieAnimationView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        setupAnimationViews()
        hideAnimationViews()
    }
    
    override func swipeDidStart(location: CGPoint) {
        startActiveAnimationIfNeeded()
    }
    
    override func swipeDidEnd(location: CGPoint) {
        activeAnimation?.stop()
        hideAnimationViews()
    }
    
    override func swipingCard(location: CGPoint) {
        showAppropriateAnimation()
    }
    
    private func showAppropriateAnimation() {
        switch swipeDirection {
        case .none:
            hideAnimationViews()
            activeAnimation = nil
        case .left:
            hideAnimationViews(shakeHidden: false)
            activeAnimation = shakeAnimationView
        case .right:
            hideAnimationViews(nodHidden: false)
            activeAnimation = nodAnimationView
        }
        
        startActiveAnimationIfNeeded()
    }
    
    private func startActiveAnimationIfNeeded() {
        guard let activeAnimation, !activeAnimation.isAnimationPlaying else {
            return
        }
        activeAnimation.play()
    }
    
    private func hideAnimationViews(shakeHidden: Bool = true, nodHidden: Bool = true) {
        UIView.animate(withDuration: 0.1) { [weak self] in
            guard let self else { return }
            self.nodAnimationView.isHidden = nodHidden
            self.shakeAnimationView.isHidden = shakeHidden
        }
    }
    
}

// MARK: - Setup animation views

extension MovieSwipeableCardView {
    
    private func setupAnimationViews() {
        let nodAnimationView = initAnimationView(filename: Self.Constants.animationNod)
        let shakeAnimationView = initAnimationView(filename: Self.Constants.animationShake)
        
        constraint(child: nodAnimationView, to: self)
        constraint(child: shakeAnimationView, to: self)
        
        // Active horizontal constraints
        nodAnimationView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32).isActive = true
        shakeAnimationView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32).isActive = true
        
        self.shakeAnimationView = shakeAnimationView
        self.nodAnimationView = nodAnimationView
    }
    
    private func constraint(child: UIView, to parent: UIView) {
        parent.addSubview(child)
        child.translatesAutoresizingMaskIntoConstraints = false
        
        child.topAnchor.constraint(equalTo: self.topAnchor, constant: 32).isActive = true
        child.widthAnchor.constraint(equalToConstant: 100).isActive = true
        child.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func initAnimationView(filename: String) -> LottieAnimationView {
        let animationView = LottieAnimationView(name: filename)
        animationView.animationSpeed = 0.8
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        return animationView
    }
    
}
