//
//  CreateHabitViewController.swift
//  MyHabits
//
//  Created by Дина Шварова on 18.01.2023.
//

import UIKit

class CreateHabitViewController: UIViewController {
    
    private  var color = UIColor.Global.orange
    private var date = Date()
    private lazy var dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter
        }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var colorButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.backgroundColor = .Global.orange
        button.addTarget(self, action: #selector(presentColorPicker), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var colorPicker: UIColorPickerViewController = {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        return picker
    }()
    
    private lazy var timeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var chooseTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.backgroundColor = .black
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(self, action: #selector(changeTimeLabel), for: .valueChanged)
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Создать"
        setupNavigationBar()
        setupViews()
        view.backgroundColor = .white
    }
    
    @objc func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func save() {
        guard let text = textField.text, text.count > 0 else {
            titleLabel.textColor = .red
            return
        }
        HabitsStore.shared.habits.insert(Habit (name: text, date: date, color: color), at: 0)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func presentColorPicker () {
        present(colorPicker, animated: true)
    }
    
    @objc func changeTimeLabel () {
        date = timePicker.date
        setTimeLabel()
    }
    
    private func setTimeLabel() {
        let text = "Каждый день в "
        let date = dateFormatter.string(from: date)
        let attributedString = NSMutableAttributedString (string: text + date)
        attributedString.setColorForText(textForAttribute: text, withColor: .black)
        attributedString.setColorForText(textForAttribute: date, withColor: .Global.purple)
        chooseTimeLabel.attributedText = attributedString
    }
    
    private func setupNavigationBar() {
        let cancelButton = UIBarButtonItem (title: "Отменить", style: .done, target: self, action: #selector (cancel))
        let saveButton = UIBarButtonItem (title: "Сохранить", style: .done, target: self, action: #selector (save))
        cancelButton.tintColor = .Global.purple
        saveButton.tintColor = .Global.purple
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func setupViews() {
        view.addSubviews([titleLabel, textField, colorLabel, colorLabel, colorButton, timeTitleLabel, chooseTimeLabel, timePicker])
        setupConstraints()
        setTimeLabel()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            colorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalToConstant: 30),
            
            timeTitleLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 15),
            timeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            chooseTimeLabel.topAnchor.constraint(equalTo: timeTitleLabel.bottomAnchor, constant: 7),
            chooseTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            timePicker.topAnchor.constraint(equalTo: chooseTimeLabel.bottomAnchor, constant: 15),
            timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension CreateHabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = viewController.selectedColor
        color = viewController.selectedColor
    }
}

extension CreateHabitViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        titleLabel.textColor = .black
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
