//
//  HeaderView.swift
//  MyHabits
//
//  Created by Дина Шварова on 10.01.2023.
//

import UIKit

protocol HabitsViewProtocol {
    func addHabit()
}

class HeaderView: UIView {
    
    var delegate: HabitsViewProtocol?
    
    private lazy var addButton: UIButton = {
        let button = UIButton ()
        button.setImage(UIImage (named: "plus"), for: .normal)
        button.tintColor = .Global.purple
        button.addTarget(self, action: #selector(addHabit), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel ()
        title.text = "Сегодня"
        title.font = .boldSystemFont(ofSize: 34)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addHabit() {
        delegate?.addHabit()
    }
    
    private func setupView() {
        addSubviews([addButton, titleLabel])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            addButton.widthAnchor.constraint(equalToConstant: 44),
            addButton.heightAnchor.constraint(equalToConstant: 44),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
