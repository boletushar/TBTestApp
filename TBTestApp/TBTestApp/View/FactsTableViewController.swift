//
//  FactsTableViewController.swift
//  TBTestApp
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

import UIKit

final class FactsTableViewController: UITableViewController {
    
    // MARK: - Private variables
    
    private var facts: [Fact] = []
    
    private let cellIdentifier = "factsCell"

    // MARK: - View life cycle
    
    override func loadView() {
        super.loadView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        return cell
    }
}

// MARK: - FactsDisplaying

extension FactsTableViewController: FactsDisplaying {
    
    func setDisplayData(_ data: FactsData) {
        
        facts = data.rows
        
        DispatchQueue.main.async {
            // Stop animation of Refresh control if started
            self.refreshControl?.endRefreshing()
            
            // Set the title of the screen
            self.title = data.title
            // Refresh table view
            self.tableView.reloadData()
        }
    }
    
    func showErrorMessage(_ message: String) {
        // TODO: - Add Alert box code
    }
}
