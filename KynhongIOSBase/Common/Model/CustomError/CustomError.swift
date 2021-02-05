//
//  CustomError.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 2/2/21.
//

import Foundation
import Alamofire

enum CustomError: LocalizedError {
    case error(with: Error)
    case backendError(error: BackendError)
    case commonError
    case noInternetError
    
    var errorDescription: String? {
        switch self {
        case .error(let error):
            if let afError = error as? AFError {
                switch afError {
                case .createUploadableFailed(error: let error):
                    return error.localizedDescription
                case .createURLRequestFailed(error: let error):
                    return error.localizedDescription
                case .downloadedFileMoveFailed(error: let error, source: _, destination: _):
                    return error.localizedDescription
                case .requestAdaptationFailed(error: let error):
                    return error.localizedDescription
                case .requestRetryFailed(retryError: let retryError, originalError: _):
                    return retryError.localizedDescription
                case .sessionInvalidated(error: let error):
                    return error?.localizedDescription
                case .sessionTaskFailed(error: let error):
                    if let error = error as? URLError {
                        switch error.code {
                        case .timedOut:
                            return "Quá thời gian kết nối máy chủ."
                        case .notConnectedToInternet, .networkConnectionLost, .cannotLoadFromNetwork:
                            return "Không thể kết nối đến máy chủ, vui lòng kiểm tra kết nối mạng."
                        default:
                            return "Rất tiếc, đã có sự cố xảy ra, xin vui lòng thử lại."
                        }
                    } else {
                        return error.localizedDescription
                    }
                    
                default:
                    return "Rất tiếc, đã có sự cố xảy ra, xin vui lòng thử lại."
                }
            } else {
                return error.localizedDescription
            }
            
        case .backendError(let error):
            return error.errorDescription
        case .commonError:
            return "Rất tiếc, đã có sự cố xảy ra, xin vui lòng thử lại."
        case .noInternetError:
            return "Không thể kết nối đến máy chủ, vui lòng kiểm tra kết nối mạng."
        }
    }
    
    var backendError: BackendError? {
        switch self {
        case .backendError(let error):
            return error
        default:
            return nil
        }
    }
    
}
