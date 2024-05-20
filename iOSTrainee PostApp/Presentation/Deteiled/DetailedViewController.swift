//
//  DeteiledViewController.swift
//  iOSTrainee PostApp
//
//  Created by macbook on 15.11.2023.
//

import UIKit
import Kingfisher

class DetailedViewController: UIViewController {
    
    
    private let specificPost: SpecificPost
    
    
    init(specificPost: SpecificPost) {
        
        self.specificPost = specificPost
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Properties -
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        let heartImage = UIImage(systemName: "heart.fill")
        image.image = heartImage?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.red
        return image
    }()
    
    private let postName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.text = "Test name label"
        return label
    }()
    
    private let postBodyText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test body text"
        label.numberOfLines = 0
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
    
    //MARK: - Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        [postImage, postName, postBodyText, likeImage, likeCount, timeShamp, timeShampText].forEach(scrollView.addSubview)
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        postData()
        applyConstraints()
    }
    
    private func postData() {
        postName.text = specificPost.title
        postBodyText.text = specificPost.text
        likeCount.text = "\(specificPost.likesCount)"
        timeShamp.text = "\(specificPost.timeshamp)"
        
        if let postImageUrl = specificPost.postImage, let url = URL(string: postImageUrl) {
            postImage.kf.setImage(with: url)
        }
    }
    
    private func applyConstraints() {
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        let screenWidth = UIScreen.main.bounds.width
        let postImageConstraints = [
            postImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            postImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: 300),
            postImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
        
        let postNameConstraints = [
            postName.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 20),
            postName.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
            postName.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20),
        ]
        
        let postBodyTextConstraints = [
            postBodyText.topAnchor.constraint(equalTo: postName.bottomAnchor, constant: 20),
            postBodyText.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
            postBodyText.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20)
        ]
        
        let likeImageConstraints = [
            likeImage.topAnchor.constraint(equalTo: postBodyText.bottomAnchor, constant: 20),
            likeImage.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
            likeImage.heightAnchor.constraint(equalToConstant: 20),
            likeImage.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ]
        
        let likeCountConstraints = [
            likeCount.topAnchor.constraint(equalTo: postBodyText.bottomAnchor, constant: 20),
            likeCount.leftAnchor.constraint(equalTo: likeImage.rightAnchor, constant: 4)
        ]
        
        let timeShampConstraints = [
            timeShamp.topAnchor.constraint(equalTo: postBodyText.bottomAnchor, constant: 20),
            timeShamp.rightAnchor.constraint(equalTo: timeShampText.leftAnchor, constant: -4)
        ]
        
        let timeShampTextConstraints = [
            timeShampText.topAnchor.constraint(equalTo: postBodyText.bottomAnchor, constant: 20),
            timeShampText.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20),
            timeShampText.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(postImageConstraints)
        NSLayoutConstraint.activate(postNameConstraints)
        NSLayoutConstraint.activate(postBodyTextConstraints)
        NSLayoutConstraint.activate(likeImageConstraints)
        NSLayoutConstraint.activate(likeCountConstraints)
        NSLayoutConstraint.activate(timeShampConstraints)
        NSLayoutConstraint.activate(timeShampTextConstraints)
    }
    
    
}
