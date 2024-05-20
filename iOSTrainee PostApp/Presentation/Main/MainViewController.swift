//
//  ViewController.swift
//  iOSTrainee PostApp
//
//  Created by macbook on 15.11.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Properties -
    
    var mainViewModel: MainViewModel = .init()
    
    private let postTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        
        table.register(PostsViewCell.self, forCellReuseIdentifier: PostsViewCell.identifier)
        return table
    }()
    
    //MARK: - Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Intents -
    
    private func configure() {
        view.backgroundColor = .systemBackground
        view.addSubview(postTable)
        postTable.delegate = self
        postTable.dataSource = self
        
        
        applyConstraints()
        configureNavBar()
        
        mainViewModel.fetchFeedOfPosts()
        bind()
    }
    
    private func bind() {
        mainViewModel.onState = { [weak self] state in
            switch state {
            case .loading: break
            case .loaded:
                self?.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
    
    private func reloadData() {
        title = "Posts"
        postTable.reloadData()
    }
    
    private func configureNavBar() {
        let filterImage = UIImage(named: "filter")?
            .scaleTo(CGSize(width: 40, height: 40)).withRenderingMode(.alwaysOriginal)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: filterImage,
            style: .plain,
            target: self,
            action: #selector(openFilter)
        )
    }
    
    @objc
    func openFilter() {
        let alertController = UIAlertController(title: nil, message: "Select the sorting", preferredStyle: .actionSheet)
        
        let sortByDateAction = UIAlertAction(title: "Date", style: .default) { [weak self] _ in
            self?.mainViewModel.sortByDate()
        }
        
        let sortByRatingAction = UIAlertAction(title: "Rating", style: .default) { [weak self] _ in
            self?.mainViewModel.sortByRating()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(sortByDateAction)
        alertController.addAction(sortByRatingAction)
        alertController.addAction(cancelAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = navigationItem.rightBarButtonItem
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func applyConstraints() {
        let postsTableConstraints = [
            postTable.topAnchor.constraint(equalTo: view.topAnchor),
            postTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            postTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            postTable.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(postsTableConstraints)
    }
    
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainViewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsViewCell.identifier, for: indexPath) as? PostsViewCell else {
            return UITableViewCell()
        }
        let post = mainViewModel.posts[indexPath.row]
        cell.configure(with: post)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = mainViewModel.posts[indexPath.row]
        self.mainViewModel.selectedPostId = selectedPost
        showDetailedScreen(for: selectedPost)
    }
    
    private func showDetailedScreen(for post: Post) {
        mainViewModel.loadData(for: post)
        
        guard let specificPost = self.mainViewModel.specificPosts.first else { return }
        let viewController = DetailedViewController(specificPost: specificPost)
        viewController.title = "Post \(specificPost.postID)"
        self.navigationController?.pushViewController(viewController, animated: true)

    }
    
    
}

extension UIImage {
    func scaleTo(_ newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
}
