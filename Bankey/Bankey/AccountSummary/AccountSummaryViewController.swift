//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Jose Sousa on 09/01/2023.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    // Request Models
    var profile: Profile?
    var accounts: [Account] = []
    
    // View Models
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "ola", name: "", date: Date())
    var accountCellViewModels: [AccountSummaryCell.ViewModel] = []
    
    let tableView = UITableView()
    var headerView = AccountSummaryHeaderView(frame: .zero)
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavigationBar()
        fetchDataAndLoadViews()
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
}

extension AccountSummaryViewController {
    
    private func setup() {
        setupTableView()
        setupTableHeaderView()
        fetchDataAndLoadViews()
    }
    
    private func setupTableView(){
        tableView.backgroundColor = appColor
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
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
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        tableView.tableHeaderView = headerView
    }
}

extension AccountSummaryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accountCellViewModels.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        guard !accountCellViewModels.isEmpty else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell

        let account = accountCellViewModels[indexPath.row]
        cell.configure(with: account)
        return cell
    }
}

extension AccountSummaryViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt: \(indexPath.row)")
    }
}

// MARK: - Networking
extension AccountSummaryViewController {
    
    private func fetchDataAndLoadViews() {
        
        fetchProfile(forUserId: "1") { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let profile):
                strongSelf.profile = profile
                strongSelf.configureTableHeaderView(with: profile)
                strongSelf.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        fetchAccounts(forUserId: "1") { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let accounts):
                strongSelf.accounts = accounts
                strongSelf.configureTableCells(with: accounts)
                strongSelf.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
    
    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "good morning", name: profile.firstName, date: Date())
        
        headerView.configure(viewModel: vm)
    }
    
    private func configureTableCells(with accounts: [Account]) {
        accountCellViewModels = accounts.map {
            AccountSummaryCell.ViewModel(accountType: $0.type,
                                         accountName: $0.name,
                                         balance: $0.amount)
        }
    }
}

// MARK: - Actions
extension AccountSummaryViewController {
    
    @objc func logoutTapped(sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: .LOGOUT, object: nil)
    }
}
