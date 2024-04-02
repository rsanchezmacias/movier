//
//  SwipeableCardStackView.swift
//  Movier
//
//  Created by Ricardo Sanchez-Macias on 4/1/24.
//

import UIKit

class SwipeableCardStackView: UIView {
    
    private var cards: [SwipeableCardView] = []
    private var visibleIndex: Int = 0
    
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
        let cardIndex = cards.count
        
        card.delegate = self
        self.cards.append(card)
        
        if cardIndex == 0 {
            self.addSubview(card)
            card.layer.zPosition = 100
        } else {
            self.insertSubview(card, belowSubview: cards[cardIndex - 1])
            card.layer.zPosition = 0
        }
        
        card.constraint(to: self)
        
        if cardIndex != visibleIndex {
            card.hideShadow()
        }
    }
    
}

extension SwipeableCardStackView: SwipeableCardViewDelegate {
    
    func didSwipeCard(_ direction: SwipeDirection) {
        cards[visibleIndex].layer.zPosition = .zero
        cards[visibleIndex].hideShadow()
        visibleIndex += 1
        
        if visibleIndex < cards.count {
            cards[visibleIndex].layer.zPosition = 100
            cards[visibleIndex].showShadow()
        }
    }
    
}
