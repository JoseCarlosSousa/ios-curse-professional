//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Jose Sousa on 10/01/2023.
//

import UIKit

enum AccountType: String, Codable {
    case Banking
    case CreditCard
    case Investment
}

class AccountSummaryCell: UITableViewCell {


    struct ViewModel {
        let accountType: AccountType
        let accountName: String
        let balance: Decimal
        
        var balanceAsAttributedString: NSMutableAttributedString {
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }
    
    let viewModel: ViewModel? = nil
    
    let typeLabel = UILabel()
    let underlineView = UIView()
    let nameLabel = UILabel()
    
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    
    let chevronImageView = UIImageView()
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 112
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AccountSummaryCell {
    
    func setup() {
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        
        
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.adjustsFontSizeToFitWidth = true
        
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.axis = .vertical
        balanceStackView.spacing = 0
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.textAlignment = .right
        balanceLabel.adjustsFontSizeToFitWidth = true
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceAmountLabel.textAlignment = .right
        
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)

        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        let chevronImage = UIImage(systemName: "chevron.right")!.withTintColor(appColor, renderingMode: .alwaysOriginal)
        chevronImageView.image = chevronImage
        
        contentView.addSubview(typeLabel) // important! Add to contentView.
        contentView.addSubview(underlineView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(balanceStackView)
        contentView.addSubview(chevronImageView)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underlineView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            underlineView.widthAnchor.constraint(equalToConstant: 60),
            underlineView.heightAnchor.constraint(equalToConstant: 4),
            
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 0),
            balanceStackView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
            trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4),
            
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1)
            
        ])
    }
}

extension AccountSummaryCell {
    
    func configure(with vm: ViewModel) {
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        
        balanceAmountLabel.attributedText = vm.balanceAsAttributedString
        
        switch vm.accountType {
            
        case .Banking:
            setValues(color: .blue, balance: "Some balance")
            break
        case .CreditCard:
            setValues(color: .gray, balance: "Balance")
            break
        case .Investment:
            setValues(color: .yellow, balance: "Some")
            break
        }
    }
    
    private func setValues(color: UIColor, balance: String) {
        underlineView.backgroundColor = color
        balanceLabel.text = balance
    }
}
