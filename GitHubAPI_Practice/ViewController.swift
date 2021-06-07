//
//  ViewController.swift
//  GitHubAPI_Practice
//
//  Created by daiki umehara on 2021/06/07.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var keywordTextField: UITextField!
    private var repositorys = [Repository]()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepositoryCell.nib, forCellReuseIdentifier: RepositoryCell.identifier)
        keywordTextField.rx.text
            .filterNil()
            .subscribe(onNext: { text in
                GitHubClient.fetchData(keyword: text) {[weak self] result in
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
                
            })
            .disposed(by: disposeBag)
        
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = WebViewController.instantiate(url: repositorys[indexPath.row].htmlUrl)
        self.navigationController?.pushViewController(webVC, animated: true)
    }
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

