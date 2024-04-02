//
//  SwipeableCardStackView.swift
//  Movier
//
//  Created by Ricardo Sanchez-Macias on 4/1/24.
//

import UIKit

class SwipeableCardStackView: UIView {
    
    private var cards: [SwipeableCardView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardStack()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCardStack()
    }
    
    private func setupCardStack() { }
    
    func addCard(_ card: SwipeableCardView) {
        self.cards.append(card)
        card.delegate = self
        
        self.addSubview(card)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        card.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        card.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        card.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}

extension SwipeableCardStackView: SwipeableCardViewDelegate {
    
    func didSwipeCard(_ direction: SwipeDirection) {
        cards.remove(at: 0)
    }
    
}
