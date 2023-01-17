//
//  SearchViewController.swift
//  Lesson_4.1
//
//  Created by Anara on 17/1/23.
//

import UIKit


class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var SearchProductTableView: UITableView!
    
    
    private var serivceDataCellIndex: IndexPath? = nil
    private var controller: ProductController?
    private var searchphones: [ProductArray] = []
    
    @IBAction func refreshDataButtonTapped(_ sender: Any) {
        controller?.getPhonesData()
        searchphones = (controller?.returnToViewPhones())!
        print(searchphones.count as Any)
        SearchProductTableView.reloadData()
    }
    
    let dataJSService = GetServiceData()
    let dataJSOrder = GetOrderData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        configureServiceCV()
        //        dataJSService.getData()
        //        dataJSOrder.getData()
        configureProductTableView()
        fetchPhones()
        //        controller = PhoneController(view: self)
        controller?.getPhonesData()
        SearchProductTableView.reloadData()
    }
    
    private func configureProductTableView() {
        SearchProductTableView.dataSource = self
        SearchProductTableView.delegate = self
        SearchProductTableView.register(
            UINib(nibName: String(describing: SearchProductTableViewCell.self), bundle: nil),
            forCellReuseIdentifier: SearchProductTableViewCell.reusedID
        )
    }
    
    private func fetchPhones() {
        NetworkManager.shared.fetchPhones { [weak self] result in
            guard let `self` = self else { return }
            if case .success(let phones) = result {
                DispatchQueue.main.async {
                    self.searchphones = phones
                    self.SearchProductTableView.reloadData()
                }
            }
        }
    }
    
    private func deletePhone(by id: Int) {
        NetworkManager.shared.deletePhone(by: id)
    }
    
    private func handlerDeletePhone(indexPath: IndexPath) {
        let id = searchphones[indexPath.row].id
        deletePhone(by: id)
        searchphones.remove(at: indexPath.row)
        SearchProductTableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchProductTableViewCell.reusedID,
            for: indexPath
        ) as? SearchProductTableViewCell else {
            fatalError()
        }
        //        let searchphones = searchphones[indexPath.row]
        //        cell.display(phone: searchphones)
        return cell
    }
}

//extension UIViewController: UITableViewDataSource {
//
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 30
//    }
//
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(
//            withIdentifier: SearchProductTableViewCell.reusedID,
//            for: indexPath
//        ) as? SearchProductTableViewCell else {
//            fatalError()
//        }
//    //        let searchphones = searchphones[indexPath.row]
//    //        cell.display(phone: searchphones)
//        return cell
//    }
//}
//
//extension UIViewController: UITableViewDelegate {
//
//}


