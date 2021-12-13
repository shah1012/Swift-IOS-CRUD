//
//  SessionService.swift
//  Firebase IOS App
//
//  Created by Dax C Shah on 11/10/21.
//

import Combine
import Foundation
import FirebaseAuth
import FirebaseDatabase
//create an enum to hold the current session state
enum SessionState {
    case loggedIn
    case loggedOut
}

protocol SessionService {
    var state: SessionState {
        get
    }
    var userDetails: SessionUserDetails? {
        get
    }
    func logout()
}

final class SessionServiceImpl: ObservableObject, SessionService{
    //these will listen for changes and redraw our view
    @Published var state: SessionState = .loggedOut
    @Published var userDetails: SessionUserDetails?
    
     private var handler: AuthStateDidChangeListenerHandle?
     init(){
         setupFirebaseAuthHandler()
     }
    func logout() {
        try? Auth.auth().signOut()
    }
}


private extension SessionServiceImpl{

 func setupFirebaseAuthHandler() {
     handler = Auth.auth()
         .addStateDidChangeListener{ [weak self] res, user in
             guard let self = self else { return }
             self.state = user == nil ? .loggedOut : .loggedIn
             if let uid = user?.uid {
             self.handleRefresh(with: uid)
         }
     }
 }
//now create a function to pull data from firebase when logged in
    func handleRefresh(with uid: String){
         Database
             .database()
             .reference()
             .child("users")
             .child(uid)
             .observe(.value) { [weak self] snapshot in
                 guard let self = self,
                 let value = snapshot.value as? NSDictionary,
                 let firstName = value[RegistrationKeys.firstName.rawValue] as? String,
                 let lastName = value[RegistrationKeys.lastName.rawValue] as? String,
                 let city = value[RegistrationKeys.city.rawValue] as? String
                 else {
                    return
                 }
                 DispatchQueue.main.async{
                   self.userDetails = SessionUserDetails(firstName: firstName, lastName: lastName, city: city)
                 }
             }
    }
}
