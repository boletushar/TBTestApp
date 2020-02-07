//
//  FactsPresenter.swift
//  TBTestApp
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

class FactsPresenter: FactsPresenting {
    
    // MARK: - Private variables
    
    private weak var display: FactsDisplaying!
    
    // MARK: - Init
    
    init(display: FactsDisplaying) {
        self.display = display
    }
    
    // MARK: - FactsPresenting
    
    func viewDidBecomeVisible() {
        
    }
}
