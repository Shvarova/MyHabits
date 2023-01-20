//
//  DetailsHabitViewController.swift
//  MyHabits
//
//  Created by Дина Шварова on 19.01.2023.
//

import UIKit

class DetailsHabitViewController : UIViewController {
    
    let index: Int
    private lazy var dates: [Date] = {
        let dates = HabitsStore.shared.habits[index].trackDates.sorted {
            $0 > $1
        }
        return dates
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .Global.lightGray
        table.rowHeight = 44
        table.allowsSelection = false
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    init (index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = HabitsStore.shared.habits[index].name
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    @objc func edit() {
        let vc = EditHabitViewController(index: index)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupView() {
        view.addSubview(tableView)
        setupConstraints()
        setupNavigationBar()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate ([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        let editButton = UIBarButtonItem (title: "Править", style: .done, target: self, action: #selector (edit))
        editButton.tintColor = .Global.purple
        navigationController?.navigationBar.tintColor = .Global.purple
        navigationItem.rightBarButtonItem = editButton
    }
}

extension DetailsHabitViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "АКТИВНОСТЬ"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let date = dates[indexPath.row]
        cell.textLabel?.text = getDateString(from: date)
        return cell
    }
    
    private func getDateString (from date: Date) -> String {
        let dateString = getDateFormatter().string(from: date)
        let today = getDateFormatter().string(from: Date())
        let yesterday = getDateFormatter().string(from: .yesterday)
        let beforeYesterday = getDateFormatter().string(from: .beforeYesterday)
        
        switch dateString {
        case today: return "Сегодня"
        case yesterday: return "Вчера"
        case beforeYesterday: return "Позавчера"
        default: return dateString
        }
    }
    
    private func getDateFormatter () -> DateFormatter {
        let formatter = DateFormatter ()
        formatter.dateFormat = "d MMMM yyyy"
        return formatter
    }
}
