//
//  DetailsViewController.swift
//  AppNews
//
//  Created by Beibarys Yermakhan on 15.12.2024.
//

import UIKit
import SnapKit

class DetailsViewController: UIViewController {
    
    private let article: Article
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let imageView = UIImageView()
    private let contentTextView = UITextView()
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        contentTextView.isEditable = false
        contentTextView.font = .systemFont(ofSize: 16)
        contentTextView.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(contentTextView)
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalTo(view).inset(16)
            $0.height.equalTo(250)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(view).inset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(view).inset(16)
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalTo(view).inset(16)
        }
    }
    
    private func configureUI() {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        
        if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
            imageView.af.setImage(withURL: url)
        }
    }
}
