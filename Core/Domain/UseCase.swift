//
//  UseCase.swift
//  Core
//
//  Created by rifat khadafy on 03/09/21.
//

import Foundation
import Combine

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
