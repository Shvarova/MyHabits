//
//  ProgressCell.swift
//  MyHabits
//
//  Created by Дина Шварова on 17.01.2023.
//

import UIKit

final class ProgressCell: UICollectionViewCell {
    
    private lazy var progressBarLabel: UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "\(Int(HabitsStore.shared.todayProgress*100))%"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.progress = HabitsStore.shared.todayProgress
        progressBar.tintColor = .Global.purple
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        percentLabel.text = "\(Int(HabitsStore.shared.todayProgress*100))%"
        progressBar.progress = HabitsStore.shared.todayProgress
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true
        contentView.addSubviews([progressBarLabel, percentLabel, progressBar])
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            progressBarLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressBarLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            
            percentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            percentLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            
            progressBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 38),
            progressBar.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            progressBar.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            progressBar.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 45),
        ])
    }
}

