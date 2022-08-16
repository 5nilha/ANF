//
//  ExploreDataService.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/13/22.
//

import Foundation

protocol ExploreDataSource {
    func didLoad(categories: [CategoryExplorer])
}

class ExporeDataService {
    
    private let url = "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.json"
    private let method: HttpMethod = .get
    weak var delegate: CategoryExplorerDelegate?
    
    func requestData() {
        RequestManager.request(method, url: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let httpResponse):
                    let response = (data: httpResponse.data, httpCode: httpResponse.httpCode)
                    guard let data = response.data else {
                        self?.delegate?.didFail(error: RequestError.responseDataIsNil)
                        return
                    }
                    
                    do {
                        let categories = try ParserManager.decode([CategoryExplorer].self, data: data)
                        let categoriesVM = categories.map { CategoryExplorerViewModel($0) }
                        self?.delegate?.didLoad(categories: categoriesVM)
                    } catch {
                        let requestError = error as? RequestError ?? RequestError.unknown(error)
                        self?.delegate?.didFail(error: requestError)
                    }
                    
                case .failure(let error):
                    self?.delegate?.didFail(error: error)
                }
            }
        }
    }
    
    func requestFromFile() {
        RequestManager.fileRequest([CategoryExplorer].self, fileName: "exploreData", ofType: "json") { [weak self] result in
            switch result {
            case .success(let categories):
                let categoriesVM = categories.map { CategoryExplorerViewModel($0) }
                self?.delegate?.didLoad(categories: categoriesVM)
            case .failure(let error):
                self?.delegate?.didFail(error: error)
            }
        }
    }
}
