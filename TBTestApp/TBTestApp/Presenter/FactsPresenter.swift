//
//  FactsPresenter.swift
//  TBTestApp
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

class FactsPresenter: FactsPresenting {

    // MARK: - Private variables

    private let factsProvider: FactsProviding!

    private weak var display: FactsDisplaying!

    // MARK: - Init

    init(display: FactsDisplaying, factsProvider: FactsProviding) {
        self.display = display
        self.factsProvider = factsProvider
    }

    // MARK: - FactsPresenting

    func viewDidBecomeVisible() {

        factsProvider.fetchFactsData { [weak display] (data, error) in

            if let error = error {
                display?.showErrorMessage(error.localizedDescription)
                return
            }

            guard let data = data else {
                display?.showErrorMessage(FactsError.genericError.localizedDescription)
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
