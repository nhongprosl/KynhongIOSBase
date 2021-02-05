//
//  BackendConnector.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 2/2/21.
//

import Foundation
import Alamofire
import RxSwift


class BackendConnector {
    
    func request<T: BackendRouter, R: Codable>(target: T, responseType: R.Type) -> Observable<R> {
        return Observable<R>.create { (subcription) -> Disposable in
            return self.request(target: target).subscribe { data in
                do {
                    let responseObject = try jsonDecoder.decode(responseType, from: data)
                    subcription.onNext(responseObject)
                }catch {
                    LoggerManager.addConsoleLog(error.localizedDescription)
                    do {
                        let backendError = try jsonDecoder.decode(BackendError.self, from: data)
                        if let errorKeyHandling = target.errorKeyHandling {
                            if errorKeyHandling.contains(ErrorKey.all) {
                                subcription.onError(CustomError.backendError(error: backendError))
                            } else if let errorKey = ErrorKey(rawValue: backendError.error), errorKeyHandling.contains(errorKey) {
                                subcription.onError(CustomError.backendError(error: backendError))
                            } else {
                                ErrorHandlingManager.shared.handle(CustomError.backendError(error: backendError))
                                subcription.onCompleted()
                            }
                            
                        } else {
                            ErrorHandlingManager.shared.handle(CustomError.backendError(error: backendError))
                            subcription.onCompleted()
                        }
                    } catch {
                        LoggerManager.addConsoleLog(error.localizedDescription)
                        if let errorKeyHandling = target.errorKeyHandling {
                            if errorKeyHandling.contains(ErrorKey.all) {
                                subcription.onError(CustomError.error(with: error))
                            } else {
                                LoggerManager.addConsoleLog(error.localizedDescription)
                                ErrorHandlingManager.shared.handle(CustomError.commonError)
                                subcription.onCompleted()
                            }
                        } else {
                            LoggerManager.addConsoleLog(error.localizedDescription)
                            ErrorHandlingManager.shared.handle(CustomError.commonError)
                            subcription.onCompleted()
                        }
                        
                    }
                }
            } onError: { error in
                if let errorKeyHandling = target.errorKeyHandling {
                    if errorKeyHandling.contains(ErrorKey.all) {
                        subcription.onError(error)
                    } else if let error_ = error as? CustomError {
                        ErrorHandlingManager.shared.handle(error_)
                        subcription.onCompleted()
                    } else {
                        ErrorHandlingManager.shared.handle(CustomError.error(with: error))
                        subcription.onCompleted()
                    }
                } else {
                    subcription.onError(error)
                }
                
            } onCompleted: {
                subcription.onCompleted()
            }

        }
    }
    
    func request<T: BackendRouter>(target: T) -> Observable<Data> {
        return Observable<Data>.create { (subcription) -> Disposable in
            let baseURL = target.baseURL
            let path = target.path
            
            var url: String = ""
            if path.hasPrefix("/") || baseURL.hasSuffix("/") {
                url = "\(baseURL)\(path)"
            } else {
                url = "\(baseURL)/\(path)"
            }
            if let query = target.queryParams {
                var params: [String] = []
                for key in query.keys {
                    let value = query[key]!
                    let param = "\(key)=\(value)"
                    params.append(param)
                }
                let paramsString = params.joined(separator: "&")
                url.append("?")
                url.append(paramsString)
            }
            url = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? url
            
            var method: Alamofire.HTTPMethod = .get
            switch target.method {
            case .get:
                method = .get
            case .post:
                method = .post
            case .delete:
                method = .delete
            case .put:
                method = .put
            }
            
            var headers = self.headers(isBasic: target.isBasicAuth)
            if let commonHeaders = target.commonHeaders {
                for key in commonHeaders.keys {
                    let value = commonHeaders[key]!
                    let header = HTTPHeader(name: key, value: value)
                    headers.add(header)
                }
            }
            
            LoggerManager.shared.addHeaderLog(url: url, headers: headers.dictionary)
            if target.body != nil {
                LoggerManager.shared.addBodyLog(url: url, body: target.body!)
            }
            
            let session = DataManager.shared.getSession()
            if let formData = target.mutipathFormDatas {
                session.upload(multipartFormData: formData, to: url, method: method, headers: headers).validate(statusCode: [200]).responseData { response in
                    let requestURLString = response.request?.url?.absoluteString ?? ""
                    switch response.result {
                    case .failure(let error):
                        LoggerManager.shared.addErrorLog(url: requestURLString, message: error.localizedDescription)
                        subcription.onError(CustomError.error(with: error))
                    case .success(let data):
                        LoggerManager.shared.addDataLog(url: requestURLString, data: data)
                        subcription.onNext(data)
                        subcription.onCompleted()
                    }
                }
            } else {
                session.request(url, method: method, parameters: target.body, encoding: JSONEncoding.prettyPrinted, headers: headers).validate(statusCode: [200]).responseData { response in
                    let requestURLString = response.request?.url?.absoluteString ?? ""
                    switch response.result {
                    case .failure(let error):
                        LoggerManager.shared.addErrorLog(url: requestURLString, message: error.localizedDescription)
                        subcription.onError(CustomError.error(with: error))
                    case .success(let data):
                        LoggerManager.shared.addDataLog(url: requestURLString, data: data)
                        subcription.onNext(data)
                        subcription.onCompleted()
                    }
                }
            }
            
            return Disposables.create()
        }
    }
}

extension BackendConnector {
    fileprivate enum AuthBasic: String {
        case username = "kynhong"
        case password = "kynhong1"
    }
    
    fileprivate func headers(isBasic: Bool) -> Alamofire.HTTPHeaders {
        var headers = HTTPHeaders()
        
        if isBasic {
            let header = HTTPHeader.authorization(username: AuthBasic.username.rawValue, password: AuthBasic.password.rawValue)
            headers.add(header)
        } else if let token = DataManager.shared.token {
            let header = HTTPHeader.authorization(bearerToken: token)
            headers.add(header)
        } else {
            let header = HTTPHeader.authorization(username: AuthBasic.username.rawValue, password: AuthBasic.password.rawValue)
            headers.add(header)
        }
        
        return headers
    }
}

