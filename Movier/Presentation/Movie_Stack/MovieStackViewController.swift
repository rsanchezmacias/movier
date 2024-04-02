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
    
    private let colors: [UIColor] = [.blue, .black, .green, .orange, .yellow]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        
        swipeableCardStack = SwipeableCardStackView()
        self.view.addSubview(swipeableCardStack)
        swipeableCardStack.translatesAutoresizingMaskIntoConstraints = false
        swipeableCardStack.heightAnchor.constraint(equalToConstant: 600).isActive = true
        swipeableCardStack.widthAnchor.constraint(equalToConstant: 300).isActive = true
        swipeableCardStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        swipeableCardStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        
        for color in colors {
            let swipeView = SwipeableCardView()
            swipeView.backgroundColor = color
            swipeableCardStack.addCard(swipeView)
        }
    }
    
}
