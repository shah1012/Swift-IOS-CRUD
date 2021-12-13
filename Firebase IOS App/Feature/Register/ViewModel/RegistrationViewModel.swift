//
//  RegistrationViewModel.swift
//  Firebase IOS App
//
//  Created by Dax C Shah on 11/8/21.
//

import Foundation
import Combine

enum RegistrationState{
    case successful
    case failed(error: Error)
    case na
}

protocol RegistrationViewModel {
    func register()//handles registration
    var hasError: Bool {
        get
    }
    var service: RegistrationService {
        get
    }
    var state: RegistrationState {
        get
    }//handles state changes
    var userDetails: RegistrationDetails {
        get
    }//bind to the view model
    init(service: RegistrationService)
}


final class RegistrationViewModelImpl: ObservableObject, RegistrationViewModel {
    @Published var hasError: Bool = false
    let service: RegistrationService
    @Published var state: RegistrationState = .na
    var userDetails: RegistrationDetails = RegistrationDetails.new
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: RegistrationService) {
        self.service = service
        setupErrorSubscriptions()
    }
    func register(){
        service
            .register(with: userDetails)
            .sink{[weak self] res in
                switch res {
                    case .failure(let error):
                        self?.state = .failed(error: error)
                    default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .successful
            }.store(in: &subscriptions)
    }
}


private extension RegistrationViewModelImpl{
    func setupErrorSubscriptions() {
        $state
            .map { state -> Bool in
                switch state {
                    case .successful, .na:
                      return false
                    case .failed:
                      return true
                }
            }
            .assign(to: &$hasError)
    }
}
