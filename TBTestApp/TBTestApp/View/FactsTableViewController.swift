//
//  FactsTableViewController.swift
//  TBTestApp
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

import UIKit

final class FactsTableViewController: UITableViewController {
    
    // Injectables
    var presenter: FactsPresenting?
    
    // MARK: - Private variables
    
    private var facts: [Fact] = []
    
    private let cellIdentifier = "factsCell"

    // MARK: - View life cycle
    
    override func loadView() {
        super.loadView()
        configureUI()
        
        // Fetch the data
        presenter?.viewDidBecomeVisible()
    }
    
    private func configureUI() {
        // Register custom TableView cell for use
        tableView.register(
            FactTableViewCell.self,
            forCellReuseIdentifier: cellIdentifier)
        tableView.separatorInset = .zero
        
        // Initialise the Refresh control
        refreshControl = UIRefreshControl()
        // Set action for refresh control when user pull down the list
        refreshControl?.addTarget(
            self,
            action: #selector(refresh),
            for: UIControl.Event.valueChanged)
    }
    
    private func stopRefreshAnimation() {
        
        DispatchQueue.main.async {
            // Stop animation of Refresh control if started
            self.refreshControl?.endRefreshing()
        }
    }
    
    /// Objective C Function
    ///
    /// Fucntion to perform refresh action
    @objc func refresh() {
        presenter?.viewDidBecomeVisible()
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
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath) as! FactTableViewCell
        let fact = facts[indexPath.row]
        cell.configure(fact)
        return cell
    }
}

// MARK: - FactsDisplaying

extension FactsTableViewController: FactsDisplaying {
    
    func setDisplayData(_ data: FactsData) {
        
        stopRefreshAnimation()
        facts = data.rows
        
        DispatchQueue.main.async {
            
            // Set the title of the screen
            self.title = data.title
            // Refresh table view
            self.tableView.reloadData()
        }
    }
    
    func showErrorMessage(_ message: String) {
        
        stopRefreshAnimation()
        DispatchQueue.main.async {
            AlertError.showMessage(
                title: NSLocalizedString("dialog.title", comment: ""),
                msg: message)
        }
    }
}
