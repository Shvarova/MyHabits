//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Дина Шварова on 09.01.2023.
//

import Foundation
import UIKit

class HabitsViewController : UIViewController {
    
    private let store = HabitsStore.shared
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        view.register(HabitCell.self, forCellWithReuseIdentifier: "HabitCell")
        view.register(ProgressCell.self, forCellWithReuseIdentifier: "ProgressCell")
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        view.backgroundColor = .Global.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 22, left: 16, bottom: 22, right: 16)
        return layout
    }()
    
    private lazy var header: HeaderView = {
        let header = HeaderView ()
        header.backgroundColor = .white
        header.delegate = self
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Сегодня"
        view.backgroundColor = .white
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
        collectionView.reloadData()
    }
    
    private func setupView () {
        view.addSubviews([header, collectionView])
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 7.5),
            
            collectionView.topAnchor.constraint(equalTo: header.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HabitsViewController: HabitsViewProtocol {
    func addHabit() {
        let vc = CreateHabitViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HabitsViewController: HabitCellDelegate {
    func setHabitTracked(index: Int) {
        guard !store.habits[index].isAlreadyTakenToday else { return }
        store.track(store.habits[index])
        collectionView.reloadData()
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        store.habits.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            return getProgressCell (collectionView, indexPath)
        }
        return getHabitCell (collectionView, indexPath)
    }
    
    private func getProgressCell (_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressCell", for: indexPath) as? ProgressCell else { return UICollectionViewCell() }
        cell.setup()
        return cell
    }
    
    private func getHabitCell (_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitCell", for: indexPath) as? HabitCell else { return UICollectionViewCell() }
        let habit = store.habits [indexPath.row - 1]
        cell.setup(name: habit.name, color: habit.color, time: habit.dateString, counter: habit.trackDates.count, habitDone: habit.isAlreadyTakenToday)
        cell.index = indexPath.row - 1
        cell.delegate = self
        return cell
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize (width: UIScreen.main.bounds.width - 32, height: 60)
        }
        return CGSize (width: UIScreen.main.bounds.width - 32, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row != 0 else { return }
        let vc = DetailsHabitViewController (index: indexPath.row - 1)
        navigationController?.pushViewController(vc, animated: true)
    }
}
