//
//  ViewController.swift
//  GitHubAPI_Practice
//
//  Created by daiki umehara on 2021/06/07.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    private var repositorys = [Repository]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepositoryCell.nib, forCellReuseIdentifier: RepositoryCell.identifier)
        searchRepositorys()
    }
    
    private func searchRepositorys() {
        GitHubClient.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let datas):
                DispatchQueue.main.async {
                    self.repositorys = datas
                    self.tableView.reloadData()
                }
            case .failure(.error(let message)):
                print(message)
            }
        }
    }
    
    @IBAction func didTapSearchButton(_ sender: Any) {
        searchRepositorys()
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositorys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.identifier, for: indexPath) as! RepositoryCell
        cell.setup(repositorys[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
}

