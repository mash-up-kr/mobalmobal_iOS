//
//  NetworkProvider.swift
//  MobalMobal
//
//  Created by 이재성 on 2021/04/09.
//

import Foundation
import Moya

struct ParseResponse<Response: Decodable>: Decodable {
    var code: Int
    var data: Response?
    var message: String?
}

enum DoneError: Error {
    case noData
    case client
    case server
    case unknown
}

enum NetworkProvider {
    // MARK: Properties
    private static let provider: MoyaProvider<DoneService> = MoyaProvider<DoneService>()
    
    // MARK: Method
    static func request<Response: Decodable>(_ target: DoneService, to type: Response.Type, success: @escaping (ParseResponse<Response>) -> Void, failure: @escaping (Error) -> Void) {
        request(target) { data in
            do {
                let parseData: ParseResponse<Response> = try parse(data)
                success(parseData)
            } catch {
                print("🛑 Parse Fail: \(error)")
                failure(error)
            }
        } failure: { failure($0) }
    }
    
    private static func request(_ target: DoneService, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        provider.session.sessionConfiguration.timeoutIntervalForRequest = 5
        provider.request(target) { result in
            switch result {
            case .success(let response):
                if 400..<500 ~= response.statusCode {
                    print("🛑 400..<500 Client Error \(response)")
                    failure(DoneError.client)
                } else if 500..<600 ~= response.statusCode {
                    print("🛑 500..<600 Server Error \(response)")
                    failure(DoneError.server)
                }
                success(response.data)
            case .failure(let error):
                print("🛑 ServerError \(error)")
                failure(error)
            }
        }
    }
    
    private static func parse<Response: Decodable>(_ data: Data) throws -> ParseResponse<Response> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = try .iso8610WithZ()
        return try decoder.decode(ParseResponse<Response>.self, from: data)
    }
}
