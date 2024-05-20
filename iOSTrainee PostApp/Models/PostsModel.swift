//
//  FeedOfPostsModel.swift
//  iOSTrainee PostApp
//
//  Created by macbook on 15.11.2023.
//

import Foundation



struct PostsModel: Codable {
    let posts: [Post]
}


struct Post: Codable {
    let postID, timeshamp: Int
    let title, previewText: String
    let likesCount: Int

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
}
