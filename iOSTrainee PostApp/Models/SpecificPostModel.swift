//
//  SpecificPost.swift
//  iOSTrainee PostApp
//
//  Created by macbook on 26.11.2023.
//

import Foundation

 struct SpecificPostModel: Codable {
    let post: SpecificPost
}


struct SpecificPost: Codable {
    let postID, timeshamp: Int
    let title, text: String
    let postImage: String?
    let likesCount: Int

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title, text, postImage
        case likesCount = "likes_count"
    }
}
