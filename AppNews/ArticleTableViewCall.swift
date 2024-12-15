//
//  ArticleTableViewCall.swift
//  AppNews
//
//  Created by Beibarys Yermakhan on 15.12.2024.
//

import UIKit
import SnapKit
import AlamofireImage

class ArticleTableViewCall: UITableViewCell {
    
    static let identifier = "ArticleTableViewCall"
    
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 3
        return label
    }()
    
    private let publishedDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(articleImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(publishedDateLabel)
        
        articleImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
            $0.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(articleImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(articleImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        publishedDateLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.leading.equalTo(articleImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        
        if let publishedAt = article.publishedAt {
            let dateFormatter = ISO8601DateFormatter()
            if let date = dateFormatter.date(from: publishedAt) {
                let displayFormatter = DateFormatter()
                displayFormatter.dateStyle = .medium
                displayFormatter.timeStyle = .short
                publishedDateLabel.text = "Published: \(displayFormatter.string(from: date))"
            }
        }
        
        if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
            articleImageView.af.setImage(
                withURL: url,
                placeholderImage: UIImage(systemName: "photo"),
                imageTransition: .crossDissolve(0.3),
                runImageTransitionIfCached: true
            )
        } else {
            articleImageView.image = UIImage(systemName: "photo")
        }
    }
}
