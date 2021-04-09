//
//  LoginViewModel.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/01.
//

import Alamofire
import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func needToSignUp()
    func successLogin()
}

class LoginViewModel {
    weak var delegate: LoginViewModelDelegate?
    
    private var fireStoreId: String? {
        didSet { setFireStoreId() }
    }
    private var loginResponse: LoginResponse? {
        didSet { loginResponseChanged() }
    }
    
    func login(with fireStoreId: String) {
        self.fireStoreId = fireStoreId
        
        let loginURL: String = "http://13.125.168.51:3000/users/login"
        let params: Parameters = ["fireStoreId": fireStoreId]
        
        AF.request(loginURL, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { [weak self] response in
            switch response.result {
            case .success(let data):
                print("🐻 Login Response: \(data)")
                self?.loginResponse = try? self?.parse(response: data)
            case .failure(let error):
                print("🐻 Login API Error: \(error)")
            }
        }
    }
    
    private func parse(response value: Any) throws -> LoginResponse {
        do {
            let data: Data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
            let parsedResponse: LoginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
            print("🐻 Login Parsed Data: \(parsedResponse)")
            return parsedResponse
        } catch let error {
            print("🐻 Login Response Decode Error: \(error.localizedDescription)")
            throw error
        }
    }
    
    private func loginResponseChanged() {
        guard let loginResponse = loginResponse else {
            self.resetUserToken()
            return
        }
        
        switch loginResponse.code {
        case .success:
            guard let token = loginResponse.data?.token.token else { break }
            self.setUserToken(token)
            delegate?.successLogin()
        case .unknownAccount:
            guard let fireStoreId = fireStoreId else { break }
            delegate?.needToSignUp()
            fallthrough
        default:
            self.resetUserToken()
            print("🐻 \(loginResponse.message)")
        }
    }
    
    private func setFireStoreId() {
        guard let id = fireStoreId else {
            UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.fireStoreId)
            return
        }
        UserDefaults.standard.setValue(id, forKey: UserDefaultsKeys.fireStoreId)
    }
    
    private func setUserToken(_ token: String) {
        UserDefaults.standard.setValue(token, forKey: UserDefaultsKeys.userToken)
    }
    
    private func resetUserToken() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.userToken)
    }
}
