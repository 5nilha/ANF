//
//  Extensions.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/16/22.
//

import UIKit

// MARK: - Dictionary Extension
/**
    Extends Dictionary data type
 */
extension Dictionary {
    mutating func merge(with dictionary: Dictionary) {
        dictionary.forEach{ updateValue($1, forKey: $0) }
    }
}


// MARK: - UIEdgeInsets Extension
/**
    Extends UIEdgeInsets
 */
extension UIEdgeInsets {
    var height: CGFloat {
        top + bottom
    }
    var width: CGFloat {
        right + left
    }
}

// MARK: - UITableView Extension
/**
    Extends UITableView
 */
extension UITableView {

    func registerNibCell(withClass cellClass: AnyClass) {
        let string = String(describing: cellClass.self)
        registerCell(withNibName: string)
    }

    func register(_ cellClass: Identifiable.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }

    func register(headerFooterClass: Identifiable.Type) {
        register(headerFooterClass, forHeaderFooterViewReuseIdentifier: headerFooterClass.identifier)
    }

    func registerCell(withNibName nibName: String) {
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }

    func reloadRowsInSection(_ section: Int, oldCount: Int, newCount: Int) {

        let maxCount = max(oldCount, newCount)
        let minCount = min(oldCount, newCount)

        var changed = [IndexPath]()

        for i in minCount..<maxCount {
            let indexPath = IndexPath(row: i, section: section)
            changed.append(indexPath)
        }

        var reload = [IndexPath]()
        for i in 0..<minCount {
            let indexPath = IndexPath(row: i, section: section)
            reload.append(indexPath)
        }

        beginUpdates()
        if newCount > oldCount {
            insertRows(at: changed, with: .fade)
        } else if oldCount > newCount {
            deleteRows(at: changed, with: .fade)
        }
        reloadRows(at: reload, with: .none)
        endUpdates()
    }
    
    
    //It reloads only the required sections
    func reloadDataSavingSelections(sections: [Int]? = nil) {
        let selectedRows = self.indexPathsForSelectedRows
        
        if let sectionsToReload = sections {
            self.reloadSections(IndexSet(sectionsToReload), with: .automatic)
        } else {
            self.reloadData()
        }
        
        if let selectedRow = selectedRows {
            for indexPath in selectedRow {
                self.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
        }
    }
}

// MARK: - UICollectionView Extension
/**
    Extends UICollectionView
 */
extension UICollectionView {

    func registerNibCell(withClass cellClass: AnyClass) {
        let string = String(describing: cellClass.self)
        registerCell(withNibName: string)
    }

    func registerCell(withNibName nibName: String) {
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }

    func registerNib(withClass suplementaryViewClass: Identifiable.Type, forSupplementaryViewOfKind elementKind: String){
        let nibName = String(describing: suplementaryViewClass.self)

        self.register(
            UINib(nibName: nibName, bundle: nil),
            forSupplementaryViewOfKind: elementKind,
            withReuseIdentifier: suplementaryViewClass.identifier
        )
    }

    func register(withClass suplementaryViewClass: Identifiable.Type, forSupplementaryViewOfKind elementKind: String) {
        self.register(suplementaryViewClass, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: suplementaryViewClass.identifier)
    }
    
    func reloadDataSavingSelections() {
        let selectedRows = self.indexPathsForSelectedItems
        self.reloadData()

        if let selectedRow = selectedRows {
            for indexPath in selectedRow {
                self.selectItem(at: indexPath, animated: false, scrollPosition: .top)
            }
        }
    }
}


extension UIImageView {
    
    
    func loadFrom(URLAddress: String) {
        if let image = UIImage.loadFromCache(string: URLAddress) {
            self.image = image
            return
        }

        if let url = URL(string: URLAddress),
           let imageData = try? Data(contentsOf: url) {
            if let loadedImage = UIImage(data: imageData) {
                DispatchQueue.main.async { [weak self] in
                    self?.image = loadedImage
                    self?.image?.saveOnCache(url: url)
                }
            }
                
        }
    }
}

extension UIImage {
    static let cache = ImageCache()
    
    static func loadFromCache(string url: String) -> UIImage? {
        guard let imageUrl = URL(string: url) else { return nil}
        return UIImage.cache.image(for: imageUrl)
    }
    
    func saveOnCache(url: URL) {
        return UIImage.cache.insertImage(self, for: url)
    }
}
