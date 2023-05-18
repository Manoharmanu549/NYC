//
//  ViewController.swift
//  NYC School
//
//  Created by Manohar on 5/14/23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    let listOfSchoolModel = ListOfSchoolModel(withService: SchoolService())
    
    private lazy var tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // set title
        self.title = String.HomeScreenTitle
        
        // setup TableView
        setupTableView()
        
        // setup TableView
        setupNavigation()
        
        // Data Binding
        setupSchoolsViewModelObserver()
        
        // fetch School data
        self.listOfSchoolModel.getSchoolList()
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    private func setupTableView() {
        // Add TableView to View
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        // Register table cell
        tableView.register(SchoolDetailCell.self, forCellReuseIdentifier: SchoolDetailCell.identifier)
        
        // delegate the TableView
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupSchoolsViewModelObserver() {
        listOfSchoolModel.schoolLists.bind {[weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        listOfSchoolModel.error.bind { [weak self] error in
            DispatchQueue.main.async {
                self?.displayErrorOnUI(message: error)
            }
        }
    }
    
    private func displayErrorOnUI(message: String?) {
        //show error
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfSchoolModel.schoolLists.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SchoolDetailCell.identifier) as? SchoolDetailCell else {
            return UITableViewCell()
        }
        if let school = listOfSchoolModel.schoolLists.value?[indexPath.row],
           let schoolName = school.schoolName {
            cell.setup(schoolName: schoolName)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let schoolDetailsModel = listOfSchoolModel.schoolLists.value?[indexPath.row] else {
            return
        }
        let viewModel = SchoolDetailViewModel(schoolDetails: schoolDetailsModel)
        let schoolDetailViewController = SchoolDetailViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(schoolDetailViewController,animated:true)
    }
}

extension String {
    static let HomeScreenTitle = "School List"
}



