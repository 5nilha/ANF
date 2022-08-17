//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

class ANFExploreCardTableViewController: UITableViewController {

    var exploreData: [CategoryExplorerViewModel]?
    let categoryExplorerHelper = CategoryExplorerHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set automatic dimensions for row height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryExplorerHelper.fetchCategoriesFromNetwork(delegate: self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exploreData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let category = exploreData?[indexPath.row],
              let cell = self.tableView.dequeueReusableCell(withIdentifier: ExploreCardCell.identifier, for: indexPath) as? ExploreCardCell else {
            return UITableViewCell()
        }
        cell.setupView(categoryExplorerVM: category)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ANFExploreCardTableViewController: CategoryExplorerDelegate {
    func didLoad(categories: [CategoryExplorerViewModel]) {
        self.exploreData = categories
        self.tableView.reloadData()
    }
    
    func didFail(error: RequestError) {
        
    }
}
