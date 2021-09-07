//
//  DataSource.swift
//  Core
//
//  Created by rifat khadafy on 04/09/21.
//

import Foundation
import Combine

public protocol DataSource {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
