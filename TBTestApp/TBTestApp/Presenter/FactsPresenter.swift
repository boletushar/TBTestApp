//
//  FactsPresenter.swift
//  TBTestApp
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

class FactsPresenter: FactsPresenting {
    
    // MARK: - Private variables
    
    private let factsProviderService = FactsProviderService()
    
    private weak var display: FactsDisplaying!
    
    // MARK: - Init
    
    init(display: FactsDisplaying) {
        self.display = display
    }
    
    // MARK: - FactsPresenting
    
    func viewDidBecomeVisible() {
        
        factsProviderService.fetchFactsData { [weak display] (data, error) in
            
            guard error == nil else {
                display?.showErrorMessage("Something went wrong. Please try after sometime.")
                return
            }
            
            guard let data = data else {
                display?.showErrorMessage("Server error. Please try after sometime.")
                return
            }
            
            // Filter out the fact which neither have title nor
            // description and imageURL
            let facts = data.rows.filter({ (fact) -> Bool in
                
                if fact.title == nil &&
                    fact.description == nil &&
                    fact.imageHref == nil {
                    return false
                }
                return true
            })
            
            let factData = FactsData(title: data.title, rows: facts)
            display?.setDisplayData(factData)
        }
    }
}
