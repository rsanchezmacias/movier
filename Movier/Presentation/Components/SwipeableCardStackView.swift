//
//  SwipeableCardStackView.swift
//  Movier
//
//  Created by Ricardo Sanchez-Macias on 4/1/24.
//

import UIKit

protocol SwipeableCardStackViewDelegate: AnyObject {
    func didSwipeCard(_ card: SwipeableCardView, direction: SwipeDirection)
    func didTapOnCard(_ card: SwipeableCardView, direction: TapDirection)
}

protocol SwipeableCardStackViewDataSource: AnyObject {
    func swipeableCards() -> [SwipeableCardView]
}

class SwipeableCardStackView: UIView, UITableViewDelegate {
    
    private var cards: [SwipeableCardView] = []
    private var visibleIndex: Int = 0
    
    weak var delegate: SwipeableCardStackViewDelegate?
    weak var dataSource: SwipeableCardStackViewDataSource? {
        didSet {
            reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func reloadData() {
        guard let cards = dataSource?.swipeableCards() else {
            return
        }
        
        for card in cards {
            addCard(card)
        }
    }
    
    private func addCard(_ card: SwipeableCardView) {
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
        self.delegate?.didSwipeCard(cards[visibleIndex], direction: direction)
        
        cards[visibleIndex].layer.zPosition = .zero
        cards[visibleIndex].hideShadow()
        visibleIndex += 1
        
        if visibleIndex < cards.count {
            cards[visibleIndex].layer.zPosition = 100
            cards[visibleIndex].showShadow()
        }
    }
    
    func didTabCard(_ direction: TapDirection) {
        self.delegate?.didTapOnCard(cards[visibleIndex], direction: direction)
    }
    
}
