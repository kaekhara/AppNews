//  ViewController.swift
//  AppNews
//
//  Created by Beibarys Yermakhan on 15.12.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let tableView = UITableView()
    private var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.register(ArticleTableViewCall.self, forCellReuseIdentifier: ArticleTableViewCall.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchArticles { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Ошибка загрузки данных: \(error)")
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCall.identifier, for: indexPath) as? ArticleTableViewCall else {
            return UITableViewCell()
        }
        cell.configure(with: articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = articles[indexPath.row]
        let detailsVC = DetailsViewController(article: selectedArticle)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
