//
//  HabitCell.swift
//  MyHabits
//
//  Created by Дина Шварова on 12.01.2023.
//

import UIKit

protocol HabitCellDelegate {
    func setHabitTracked (index: Int)
}

class HabitCell : UICollectionViewCell {
    
    var index = 0
    var delegate: HabitCellDelegate?
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 3
        image.layer.cornerRadius = 19
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer (target: self, action: #selector(setHabitTracked))
        image.addGestureRecognizer(tap)
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func setHabitTracked () {
        delegate?.setHabitTracked(index: index)
    }
    
    func setup (name: String, color: UIColor, time: String, counter: Int, habitDone: Bool) {
        nameLabel.text = name
        timeLabel.text = time
        counterLabel.text = "Счетчик: \(counter)"
        if habitDone {
            imageView.image = .checkmark
        } else {
            imageView.image = nil
        }
        nameLabel.textColor = color
        imageView.layer.borderColor = color.cgColor
        imageView.tintColor = color
    }
    
    private func setupView() {
        addSubviews([nameLabel, timeLabel, counterLabel, imageView])
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -40),
            
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            counterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            counterLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 38),
            imageView.widthAnchor.constraint(equalToConstant: 38)
        ])
    }
}


