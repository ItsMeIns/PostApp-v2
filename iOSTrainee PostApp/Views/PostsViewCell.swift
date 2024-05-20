//
//  PostsViewCell.swift
//  iOSTrainee PostApp
//
//  Created by macbook on 15.11.2023.
//

import UIKit



class PostsViewCell: UITableViewCell {
    
    
    static let identifier = "PostsViewCell"
    
    private var isExpanded = false {
        didSet {
            postBody.numberOfLines = isExpanded ? 0 : 2
            button.setTitle(isExpanded ? "Collapse" : "Expand", for: .normal)
        }
    }
    
    private let postTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()
    
    private let postBody: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private let likeImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        let heartImage = UIImage(systemName: "heart.fill")
        image.image = heartImage?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.red
        return image
    }()
    
    private let likeCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeShamp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeShampText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "day ago"
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.darkGray
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Expand", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [postTitle, postBody, likeImage, likeCount, timeShamp, timeShampText, button].forEach(contentView.addSubview)
        
        applyConstraints()
        hideButton()
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    private func buttonTapped() {
        isExpanded.toggle()
        
        if let tableView = superview as? UITableView {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    public func hideButton() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let maxSize = CGSize(width: self.postBody.bounds.width, height: CGFloat.greatestFiniteMagnitude)
            let textHeight = (self.postBody.text ?? "").boundingRect(with: maxSize,
                options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.postBody.font ?? UIFont.systemFont(ofSize: 17)],
                                                                     context: nil).height
            
            self.button.isHidden = textHeight <= self.postBody.font.lineHeight * 2
        }
    }
    
    private func applyConstraints() {
        
        let postTitleConstraints = [
            postTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            postTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            postTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ]
        
        let postBodyConstraints = [
            postBody.topAnchor.constraint(equalTo: postTitle.bottomAnchor, constant: 8),
            postBody.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            postBody.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ]
        
        let likeImageConstraints = [
            likeImage.topAnchor.constraint(equalTo: postBody.bottomAnchor, constant: 16),
            likeImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            likeImage.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let likeCountConstraints = [
            likeCount.topAnchor.constraint(equalTo: postBody.bottomAnchor, constant: 16),
            likeCount.leftAnchor.constraint(equalTo: likeImage.rightAnchor, constant: 4)
        ]
        
        let timeShampConstraints = [
            timeShamp.topAnchor.constraint(equalTo: postBody.bottomAnchor, constant: 16),
            timeShamp.rightAnchor.constraint(equalTo: timeShampText.leftAnchor, constant: -4)
        ]
        
        let timeShampTextConstraints = [
            timeShampText.topAnchor.constraint(equalTo: postBody.bottomAnchor, constant: 16),
            timeShampText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ]
        
        let buttonConstraints = [
            button.topAnchor.constraint(equalTo: likeImage.bottomAnchor, constant: 16),
            button.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            button.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(postTitleConstraints)
        NSLayoutConstraint.activate(postBodyConstraints)
        NSLayoutConstraint.activate(likeImageConstraints)
        NSLayoutConstraint.activate(likeCountConstraints)
        NSLayoutConstraint.activate(timeShampConstraints)
        NSLayoutConstraint.activate(timeShampTextConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    public func configure(with model: Post) {
        postTitle.text = model.title
        postBody.text = model.previewText
        likeCount.text = "\(model.likesCount)"
        timeShamp.text = "\(model.timeshamp)"
        
        hideButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
