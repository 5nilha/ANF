//
//  ImageCache.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/16/22.
//

import UIKit

class ImageCache {

    // 1st level cache, that contains encoded images
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.memoryLimit
        return cache
    }()
    private let lock = NSLock()
    private let config: Config

    struct Config {
        let countLimit: Int
        let memoryLimit: Int

        static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100 MB
    }

    init(config: Config = Config.defaultConfig) {
        self.config = config
    }
    
    func image(for url: URL) -> UIImage? {
        lock.lock(); defer { lock.unlock() }
        // the best case scenario -> there is a decoded image
        guard let decodedImage = imageCache.object(forKey: url as AnyObject) as? UIImage else { return nil }
        return decodedImage
    }
    
    subscript(_ key: URL) -> UIImage? {
        get {
            return image(for: key)
        }
        set {
            return insertImage(newValue, for: key)
        }
    }
}

extension ImageCache: ImageCacheType {
    func removeAllImages() {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeAllObjects()
    }
    
    func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return removeImage(for: url) }
        lock.lock(); defer { lock.unlock() }
        imageCache.setObject(image, forKey: url as AnyObject)
    }

    func removeImage(for url: URL) {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeObject(forKey: url as AnyObject)
    }
}
