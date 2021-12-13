//
//  RegistrationService.swift
//  Firebase IOS App
//
//  Created by Dax C Shah on 11/3/21.
//
import Combine
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth


enum RegistrationKeys: String{
    case firstName
    case lastName
    case city
}

protocol RegistrationService{
    func register(with details: RegistrationDetails) -> AnyPublisher<Void, Error>
}

final class RegistrationServiceImpl: RegistrationService{
    func register(with details: RegistrationDetails) -> AnyPublisher<Void, Error>{
        Deferred{
            Future{
                promise in
                Auth.auth().createUser(withEmail: details.email, password: details.password){ res, error in
                    if let err = error {
                        promise(.failure(err))
                    }else{
                        if let uid = res?.user.uid{
                            let values = [RegistrationKeys.firstName.rawValue: details.firstName, RegistrationKeys.lastName.rawValue: details.lastName, RegistrationKeys.city.rawValue: details.city] as [String:Any]
                            
                            Database.database().reference().child("users").child(uid).updateChildValues(values){error, ref in
                                    if let err = error {
                                        promise(.failure(err))
                                    }else{
                                        promise(.success(()))
                                    }
                                }
                        } else {
                            promise(.failure(NSError(domain: "Invalid User Id", code: 0, userInfo: nil)))
                        }
                    }
                    
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
