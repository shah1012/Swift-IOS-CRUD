//
//  LoginService.swift
//  Firebase IOS App
//
//  Created by Dax C Shah on 11/10/21.
//

import Combine
import Foundation
import FirebaseAuth

protocol LoginService {
    func login(with credentials: LoginCredentials) -> AnyPublisher<Void, Error>
}


final class LoginServiceImpl: LoginService{
//implement the login protocol and link it with Firebase
    func login(with credentials: LoginCredentials) -> AnyPublisher<Void, Error> {
        Deferred {
            Future{ promise in
                Auth.auth().signIn(withEmail: credentials.email, password: credentials.password) { res, error in
                    if let err = error {
                        promise(.failure(err))
                    } else {
                        promise(.success(()))
                    }
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
