//
//  UpdateButtonView.swift
//  Firebase IOS App
//
//  Created by Dax C Shah on 11/19/21.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase
import Combine

enum updateValueKeys{
    case firstName
    case lastName
    case city
}

struct UpdateButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showUpdateView = false
    @State private var email = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var city = ""

    func updateValues(){
        print(RegistrationKeys.firstName)
    }
    
    
    var body: some View {
        NavigationView{
            VStack{
                InputTextFieldView(text: $firstName, placeholder: "First Name", keyboardType: .default, sfSymbol: nil)
                InputTextFieldView(text: $lastName, placeholder: "Last Name", keyboardType: .default, sfSymbol: nil)
                InputTextFieldView(text: $city, placeholder: "City", keyboardType: .default, sfSymbol: nil)
                ButtonVIew(title: "Update"){
                    let uid = Auth.auth().currentUser?.uid ?? "test"
                    Database.database().reference().child("users").child(uid).updateChildValues(["firstName": firstName, "lastName": lastName, "city": city])
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }.applyClose()
    }
}

struct UpdateButtonView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateButtonView()
    }
}

