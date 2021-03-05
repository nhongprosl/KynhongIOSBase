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
    var styleConfigured: Style = .light {
        didSet {
            UserDefaults.standard.set(styleConfigured.rawValue, forKey: "kynhongStyleConfigured")
            SceneManager.shared.style = styleConfigured
            SceneManager.shared.styleObservable.onNext(styleConfigured)
        }
    }
    var isAutoStyle: Bool = true {
        didSet {
            UserDefaults.standard.set(self.isAutoStyle, forKey: "kynhongAutoStyle")
            UserDefaults.standard.synchronize()
        }
    }
    
    // Token
    var token: String? = nil
    
    private var sessionManager: Alamofire.Session!
    private init() {
        // set init style and configuration for app
        if UserDefaults.standard.object(forKey: "kynhongHasOpened") == nil {
            UserDefaults.standard.set(false, forKey: "kynhongHasOpened")
        }
        if UserDefaults.standard.object(forKey: "kynhongAutoStyle") == nil {
            UserDefaults.standard.set(true, forKey: "kynhongAutoStyle")
        }
        if UserDefaults.standard.object(forKey: "kynhongStyleConfigured") == nil {
            UserDefaults.standard.set(Style.light.rawValue, forKey: "kynhongStyleConfigured")
        }
        UserDefaults.standard.synchronize()
        
        self.hasOpened = UserDefaults.standard.bool(forKey: "kynhongHasOpened")
        self.isAutoStyle = UserDefaults.standard.bool(forKey: "kynhongAutoStyle")
        let styleConfigInt = UserDefaults.standard.integer(forKey: "kynhongStyleConfigured")
        if let style = Style(rawValue: styleConfigInt) {
            self.styleConfigured = style
        }
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
