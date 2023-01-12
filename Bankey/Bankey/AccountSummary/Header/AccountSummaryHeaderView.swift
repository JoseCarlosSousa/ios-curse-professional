//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by Jose Sousa on 09/01/2023.
//

import UIKit

class AccountSummaryHeaderView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private let shakeyBellView = ShakeyBellView()
    
    struct ViewModel {
        let welcomeMessage: String?
        let name: String?
        let date: Date?
        
        var dateFormatted: String {
            guard let date = date else { return "" }
            return date.monthDayYearString()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    private func commonInit() {
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.backgroundColor = appColor
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        setupShakeyBell()
    }
    
    private func setupShakeyBell() {
        shakeyBellView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shakeyBellView)
        
        NSLayoutConstraint.activate([
            shakeyBellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shakeyBellView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(viewModel: ViewModel) {
        guard let welcomeMessage = viewModel.welcomeMessage,
              let name = viewModel.name,
              let date = viewModel.date else { return }
        
        titleLabel.text = "Banked"
        subtitleLabel.text = welcomeMessage
        nameLabel.text = name
        dateLabel.text = viewModel.dateFormatted
    }
}
