//
//  DataManager.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 1/31/21.
//

import Foundation
import RxSwift
import UIKit
import Alamofire

class DataManager {
    public static let shared = DataManager()
    
    var hasOpened: Bool {
        didSet {
            UserDefaults.standard.set(hasOpened, forKey: "kynhongHasOpened")
        }
    }
    // Environment
    var environment: Environment = .development
    // Style
    var styleConfigured: Style = .light
    var isAutoStyle: Bool = true
    
    // Token
    var token: String? = nil
    
    private var sessionManager: Alamofire.Session!
    private init() {
        self.hasOpened = UserDefaults.standard.bool(forKey: "kynhongHasOpened")
    }
    
    func getSession() -> Alamofire.Session {
        if self.sessionManager == nil {
            self.sessionManager = Alamofire.Session(serverTrustManager: ServerTrustManager(evaluators: self.serverTrusts()))
        }
        return self.sessionManager
    }
    
    func save(token: TokenResponse) {
        self.token = token.accessToken
    }
    
    func openAppstore() {
        if let url = URL(string: appstoreLink) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    // MARK: - Private functions
    private func serverTrusts() -> [String: ServerTrustEvaluating] {
        return [
            self.environment.apiDomain : PinnedCertificatesTrustEvaluator(certificates: [Certificates.cert]),
            self.environment.mediaDomain: PinnedCertificatesTrustEvaluator(certificates: [Certificates.cert])
        ]
    }
    
    private struct Certificates {
        static let cert = Certificates.certificate(filename: "")
      
        private static func certificate(filename: String) -> SecCertificate {
            let filePath = Bundle.main.path(forResource: filename, ofType: "der")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
            let certificate = SecCertificateCreateWithData(nil, data as CFData)!
            
            return certificate
        }
    }
}
