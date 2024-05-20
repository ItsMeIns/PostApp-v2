//
//  MainViewModel.swift
//  iOSTrainee PostApp
//
//  Created by macbook on 15.11.2023.
//

import Foundation

final class MainViewModel {
    
    //MARK: - Content -
    
    var selectedPostId: Post?
    
    private(set) var posts: [Post] = []
    private(set) var specificPosts: [SpecificPost] = []
    
    enum State {
        case loading
        case loaded
        case error(String)
    }
    
    var state: State = .loading {
        didSet {
            onState?(state)
        }
    }
    
    var onState: ((State) -> Void)?
    
    
    //MARK: - Intents -
    
    func fetchFeedOfPosts() {
        NetworkManager.shared.getFeedOfPosts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let postsModel):
                DispatchQueue.main.async {
                    self.posts = postsModel.posts
                    self.state = .loaded
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.state = .error(error.localizedDescription)
                }
            }
        }
  }
    
    func loadData(for post: Post) {
        NetworkManager.shared.getSpecificPost(postId: post.postID) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let specificPost):
                    DispatchQueue.main.async {
                        self.specificPosts = [specificPost.post]
                        self.state = .loaded
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.state = .error(error.localizedDescription)
                    }
                }
            }
        }
    
    func sortByDate() {
        posts.sort { $0.timeshamp < $1.timeshamp }
        state = .loaded
    }
    
    func sortByRating() {
        posts.sort { $0.likesCount > $1.likesCount }
        state = .loaded
    }
    
    
    
   private func error(_ error: Error) {
        state = .error(error.localizedDescription)
    }
}
