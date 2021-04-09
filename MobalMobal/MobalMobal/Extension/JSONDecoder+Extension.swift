//
//  JSONDecoder+Extension.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/07.
//

import Foundation

extension JSONDecoder.DateDecodingStrategy {
    static func iso8610WithZ() throws -> JSONDecoder.DateDecodingStrategy {
        return .custom { (decoder) -> Date in
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)

            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            guard let date = formatter.date(from: dateStr) else {
                let debug: String = "Expected \(dateStr) to be ISO8601-formatted (with Z)"
                throw DecodingError.dataCorruptedError(in: container, debugDescription: debug)
            }
            return date
        }
    }
}
