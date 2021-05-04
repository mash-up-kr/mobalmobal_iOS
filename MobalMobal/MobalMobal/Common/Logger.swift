//
//  Logger.swift
//  MobalMobal
//
//  Created by 이재성 on 2021/04/10.
//

import Foundation

struct Log {
    enum LogType {
        case debug
        case warning
        case `deinit`
        case error
        case networkError
        case networkRequest
        case networkResponse
        case custom(String)
    }
    
    private let emoji: String
    
    func logger<T>(_ object: @autoclosure () -> T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        #if DEBUG
        let value: T = object()
        let fileURL: String = NSURL(string: file)?.lastPathComponent ?? "Unknown file"
        let queue: String = Thread.isMainThread ? "UI" : "BG"
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        print("\(emoji)<\(formatter.string(from: Date()))> <\(queue)> \(fileURL) \(function)[\(line)]: " + String(reflecting: value))
        #endif
    }
    
    init(_ type: LogType) {
        switch type {
        case .debug:
            emoji = "❤️"
        case .warning:
            emoji = "🚧"
        case .deinit:
            emoji = "✋"
        case .error:
            emoji = "💥"
        case .networkError:
            emoji = "🛑"
        case .networkRequest:
            emoji = "🚀"
        case .networkResponse:
            emoji = "📦️"
        case .custom(let emoji):
            self.emoji = emoji
        }
    }
}
