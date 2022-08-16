//
//  HttpRequest.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/16/22.
//

import Foundation

class HttpRequest {
    private let requestSession = URLSession.shared
    private var task: URLSessionDataTask?
    private var maxAttempts: Int = 1
    private var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    private var timeout: Double?
    
    init(maxAttempts: Int = 1,
         cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
         timeout: Double? = nil) {
        self.setConfiguration(maxAttempts: maxAttempts,
                              cachePolicy: cachePolicy,
                              timeout: timeout)
    }
    
    func setConfiguration(maxAttempts: Int,
                          cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
                          timeout: Double? = nil) {
        self.maxAttempts = maxAttempts
        self.cachePolicy = cachePolicy
        self.timeout = timeout
    }
    
    func cancelRequest() {
        self.task?.cancel()
    }
    
    func resumeTask() {
        self.task?.resume()
    }
    
    func SupendTask() {
        self.task?.suspend()
    }
    
    final func getRequest(_ method: HttpMethod,
                            url: String,
                            headers: [String: String]? = nil,
                            queryParams: [String: String]? = nil,
                            body: Data? = nil,
                            completion: @escaping HttpRequestHandler) {
        switch method {
        case .get:
            self.get(url: url,
                     headers: headers,
                     queryParams: queryParams,
                     completion: completion)
        case .post:
            self.post(url: url,
                      headers: headers,
                      queryParams: queryParams,
                      body: body,
                      completion: completion)
        case .put:
           self.put(url: url,
                    headers: headers,
                    queryParams: queryParams,
                    body: body,
                    completion: completion)
        case .patch:
            self.patch(url: url,
                       headers: headers,
                       queryParams: queryParams,
                       body: body,
                       completion: completion)
        case .delete:
            self.delete(url: url,
                        headers: headers,
                        queryParams: queryParams,
                        body: body,
                        completion: completion)
        }
    }
    
    // MARK: - get
    /**
        Sends GET request. Used for read-only operations.
        - Parameter url: URL String
        - Parameter headers: Header is optional and `nil` by default
        - Parameter queryParams: queryParams will be added in the url and  is optional and `nil` by default
        - (Result<HttpRequestResponse, Error>)
     */
    private func get(url: String,
                     headers: [String: String]? = nil,
                     queryParams: [String: String]? = nil,
                     completion: @escaping HttpRequestHandler) {
        processRequest(url: url,
                       method: .get,
                       headers: headers,
                       queryParams: queryParams,
                       completion: completion)
    }
    
    // MARK: - post
    /**
        Sends POST request. Send data in the URL and as an attachment body.
        - Parameter url: URL String
        - Parameter headers: Header is optional and `nil` by default
        - Parameter queryParams: queryParams will be added in the url and  is optional and `nil` by default
        - Parameter body: body is optional and `nil` by default
        - (Result<HttpRequestResponse, Error>)
     */
    private func post(url: String,
                      headers: [String: String]? = nil,
                      queryParams: [String: String]? = nil,
                      body: Data? = nil,
                      completion: @escaping HttpRequestHandler) {
        processRequest(url: url,
                       method: .post,
                       headers: headers,
                       queryParams: queryParams,
                       body: body,
                       completion: completion)
    }
    
    // MARK: - put
    /**
        Sends PUT request.
        - Parameter url: URL String
        - Parameter headers: Header is optional and `nil` by default
        - Parameter queryParams: queryParams will be added in the url and  is optional and `nil` by default
        - Parameter body: body is optional and `nil` by default
        - (Result<HttpRequestResponse, Error>)
     */
    private func put(url: String,
                     headers: [String: String]? = nil,
                     queryParams: [String: String]? = nil,
                     body: Data? = nil,
                     completion: @escaping HttpRequestHandler) {
        processRequest(url: url,
                       method: .put,
                       headers: headers,
                       queryParams: queryParams,
                       body: body,
                       completion: completion)
    }
    
    // MARK: - patch
    /**
        Sends PUT request.
        - Parameter url: URL String
        - Parameter headers: Header is optional and `nil` by default
        - Parameter queryParams: queryParams will be added in the url and  is optional and `nil` by default
        - Parameter body: body is optional and `nil` by default
        - (Result<HttpRequestResponse, Error>)
     */
    private func patch(url: String,
                       headers: [String: String]? = nil,
                       queryParams: [String: String]? = nil,
                       body: Data? = nil,
                       completion: @escaping HttpRequestHandler) {
        processRequest(url: url,
                       method: .patch,
                       headers: headers,
                       queryParams: queryParams,
                       body: body,
                       completion: completion)
    }
    
    // MARK: - delete
    /**
        Sends PUT request.
        - Parameter url: URL String
        - Parameter headers: Header is optional and `nil` by default
        - Parameter queryParams: queryParams will be added in the url and  is optional and `nil` by default
        - Parameter body: body is optional and `nil` by default
        - (Result<HttpRequestResponse, Error>)
     */
    private func delete(url: String,
                        headers: [String: String]? = nil,
                        queryParams: [String: String]? = nil,
                        body: Data? = nil,
                        completion: @escaping HttpRequestHandler) {
        processRequest(url: url,
                       method: .delete,
                       headers: headers,
                       queryParams: queryParams,
                       body: body,
                       completion: completion)
    }
    
    // MARK: - CreateURLRequest
    /**
        Creates a request for specific URL, method, headers, query params and body
        - Parameter url: URL String
        - Parameter method: Http Method. (get, post, put, patch, delete)
        - Parameter headers: Header is optional and `nil` by default
        - Parameter queryParams: queryParams will be added in the url and  is optional and `nil` by default
        - Parameter body: body is optional and `nil` by default
     
        - returns: The created URLRequest
     */
    private func createURLRequest(url: String,
                                  method: HttpMethod,
                                  headers: [String: String]? = nil,
                                  queryParams: [String: String]? = nil,
                                  body: Data? = nil) -> URLRequest? {
        
        guard var baseURL = URL(string: url),
              var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        else {
            let error = NSError(domain: "Failed to create URL and URL Components with url string = \(url)", code: -1, userInfo: nil)
            Logger.log("\(type(of: self)): Request error creating URLRequest", logLevel: .error(error))
            return nil
        }
        
        // Adding query items into url is query items are not nil
        components.queryItems = getQueryItems(queryParams)
        baseURL = components.url ?? baseURL // IF components.url IS NILL. ASSIGN TO SELF
        
        //Make request for given method
        var urlRequest = URLRequest(url: baseURL, cachePolicy: cachePolicy)
        urlRequest.httpMethod = method.rawValue
        
        //Adding Headers to request
        let requestHeaders = getHeaders(headers, method: method)
        requestHeaders?.forEach({ (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        })
        
        //Adding Body data to request
        urlRequest.httpBody = body
        
        return urlRequest
    }
    
    private func getHeaders(_ headers: [String: String]?, method: HttpMethod) -> [String: String]? {
        guard var baseHeaders = method.baseHeaders else { return nil }
        headers?.forEach({ (key, value) in
            baseHeaders[key] = value
        })
        return baseHeaders
    }

    private func getQueryItems(_ queryParams: [String: String]?) -> [URLQueryItem]? {
        guard let query = queryParams else { return nil }
        let queryItems = query.compactMap({ (key , value) -> URLQueryItem in
            URLQueryItem(name: key, value: value)
        })
        return queryItems
    }
    
    // MARK: - processRequest
    /**
        Processes request for the specific method, URL String, parameters and headers.
        - Parameter url: URL String
        - Parameter method: Http Method. (get, post, put, patch, delete)
        - Parameter headers: Header is optional and `nil` by default
        - Parameter queryParams: queryParams will be added in the url and  is optional and `nil` by default
        - Parameter body: body is optional and `nil` by default
     
        - returns: The data task.
     */
    private func processRequest(url: String,
                                method: HttpMethod,
                                headers: [String: String]? = nil,
                                queryParams: [String: String]? = nil,
                                body: Data? = nil,
                                completion: @escaping HttpRequestHandler) {
        guard let urlRequest = createURLRequest(url: url,
                                                method: method,
                                                headers: headers,
                                                queryParams: queryParams,
                                                body: body)
        else {
            completion(.failure(RequestError.urlRequestCouldNotBeCreated))
            return
        }

        startDataTask(urlRequest) { [weak self] (response) in
            switch response {
            case .success(let requestResponse):
                completion(.success(requestResponse))
            case .failure(let error):
                if let maxAttempt = self?.maxAttempts, let shouldRetryHostRequest = self?.shouldRetryRequest(error: error, attemptLeft: maxAttempt - 1),
                   shouldRetryHostRequest {
                    self?.processRequest(url: url,
                                         method: method,
                                         headers: headers,
                                         queryParams: queryParams,
                                         body: body,
                                         completion: completion)
                } else {
                    Logger.log("\(type(of: self)): Error retying Host Request", logLevel: .error(error))
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func shouldRetryRequest(error: Error?, attemptLeft: Int) -> Bool {
        let somethingWentWrong = (error != nil)
        return somethingWentWrong && (attemptLeft > 0)
    }
    
    //Letting Start Data task open only for Unit and UI testing
    private func startDataTask(_ urlRequest: URLRequest,
                        completion: @escaping HttpRequestHandler) {
    
        self.task = requestSession.dataTask(with: urlRequest) { [weak self] (data, urlResponse, error) in
            
            guard let taskData = data, let code = HttpRequest.getHttpStatusCode(urlResponse: urlResponse) else {
                if let taskError = error as? RequestError {
                    Logger.log("\(type(of: self)): requestSession.dataTask Error.", logLevel: .error(error))
                    completion(.failure(taskError))
                } else {
                    Logger.log("\(type(of: self)): requestSession.dataTask Error. isDataNil = \(data == nil). urlResponse: [\(String(describing: urlResponse))]", logLevel: .error(nil))
                    completion(.failure(RequestError.responseDataIsNil))
                }
                return
            }
            
            if !code.isSuccess {
                Logger.log("\(type(of: self)): requestSession.dataTask Error with code not successful.", logLevel: .error(nil))
                completion(.failure(RequestError.httpCodeNotSuccessful))
                return
            }
            
            completion(.success((taskData, code)))
            
        }
        resumeTask()
    }
    
    class func getHttpStatusCode(urlResponse: URLResponse?) -> HttpCode? {
        guard let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode else { return nil}

        if let httpCode = HttpCode(rawValue: statusCode) {
            return httpCode
        } else if 200 ... 299 ~= statusCode {
            return HttpCode.ok
        } else {
            let httpCode = HttpCode.serverError
            Logger.log("\(type(of: self)): Server Error. Code: \(httpCode.rawValue)", logLevel: .error(nil))
            return httpCode
        }
    }
}
