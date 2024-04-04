//
//  MovieStackViewController.swift
//  Movier
//
//  Created by Ricardo Sanchez-Macias on 4/1/24.
//

import UIKit

class MovieStackViewController: UIViewController {
    
    static let name: String = "MovieStackViewController"
    
    private var swipeableCardStack: SwipeableCardStackView!
    
    private var cards: [SwipeableCardView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeableCardStack = SwipeableCardStackView()
        self.view.addSubview(swipeableCardStack)
        swipeableCardStack.translatesAutoresizingMaskIntoConstraints = false
        swipeableCardStack.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.85).isActive = true
        swipeableCardStack.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95).isActive = true
        swipeableCardStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        swipeableCardStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        
        for _ in 0...6 {
            let swipeView = MovieSwipeableCardView()
            cards.append(swipeView)
        }
        
        swipeableCardStack.dataSource = self
        swipeableCardStack.delegate = self
    }
    
}

extension MovieStackViewController: SwipeableCardStackViewDataSource, SwipeableCardStackViewDelegate {
    
    func didSwipeCard(_ card: SwipeableCardView, direction: SwipeDirection) {
        return
    }
    
    func didTapOnCard(_ card: SwipeableCardView, direction: TapDirection) {
        return
    }
    
    
    func swipeableCards() -> [SwipeableCardView] {
        return self.cards
    }
    
}
