//
//  ImageCache.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import UIKit

/// A class responsible for caching images using `NSCache`.
class ImageCache {
    // An instance of `NSCache` to store images with NSString keys.
    private let cache = NSCache<NSString, UIImage>()

    /// Sets an image in the cache for a given key.
    /// - Parameters:
    ///   - image: The `UIImage` to be cached.
    ///   - key: The `String` key associated with the image.
    func set(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    /// Retrieves an image from the cache for a given key.
    /// - Parameter key: The `String` key associated with the image.
    /// - Returns: The `UIImage` if it exists in the cache, otherwise `nil`.
    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
