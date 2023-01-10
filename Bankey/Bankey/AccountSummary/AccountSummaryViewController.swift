//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Jose Sousa on 09/01/2023.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    var accounts: [AccountSummayTableViewCell.ViewModel] = []
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension AccountSummaryViewController {
    
    private func setup() {
        setupTableView()
        setupTableHeaderView()
        fetchData()
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummayTableViewCell.self, forCellReuseIdentifier: AccountSummayTableViewCell.reuseID)
        tableView.rowHeight = AccountSummayTableViewCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableHeaderView() {
        let header = AccountSummaryHeaderView(frame: .zero)
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        tableView.tableHeaderView = header
    }
}

extension AccountSummaryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accounts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        guard !accounts.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummayTableViewCell.reuseID, for: indexPath) as! AccountSummayTableViewCell
        let account = accounts[indexPath.row]
        cell.configure(with: account)
        return cell
    }
}

extension AccountSummaryViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt: \(indexPath.row)")
    }
}

extension AccountSummaryViewController {
    
    private func fetchData() {
        
        let savings = AccountSummayTableViewCell.ViewModel(accountType: .Banking, accountName: "Basic Savings")
        let visa = AccountSummayTableViewCell.ViewModel(accountType: .CreditCard, accountName: "Visa Avion Card")
        let investment = AccountSummayTableViewCell.ViewModel(accountType: .Investment, accountName: "Tax-Free Saver")
        
        accounts.append(savings)
        accounts.append(visa)
        accounts.append(investment)
    }
}
