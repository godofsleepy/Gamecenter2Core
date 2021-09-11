//
//  Presenter.swift
//  Core
//
//  Created by rifat khadafy on 05/09/21.
//

import SwiftUI
import Combine

public enum PresenterStatus {
    case initial
    case loading
    case success
    case error
}

public class Presenter<Request, Response, Interactor: UseCase>: ObservableObject where Interactor.Request == Request, Interactor.Response == Response {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let _useCase: Interactor
    
    @Published public var item: Response?
    @Published public var errorMessage: String = ""
    @Published var status: PresenterStatus = PresenterStatus.initial
    
    public init(useCase: Interactor) {
        _useCase = useCase
    }
    
    public func execute(request: Request?) {
        status = PresenterStatus.loading
        _useCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.status = PresenterStatus.error
                case .finished:
                    self.status = PresenterStatus.success
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
    
    
}

