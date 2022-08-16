//
//  ImageCacheType.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/16/22.
//

import UIKit

protocol ImageCacheType: AnyObject {
    func image(for url: URL) -> UIImage?
    func insertImage(_ image: UIImage?, for url: URL)
    func removeImage(for url: URL)
    func removeAllImages()
    subscript(_ url: URL) -> UIImage? { get set }
}
