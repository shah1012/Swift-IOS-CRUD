import SwiftUI

struct LogInView: View {
    @State private var showRegistration = false
    @State private var showForgotPassword = false
    
    @StateObject private var vm = LoginViewModelImpl( service: LoginServiceImpl() )
    
    var body: some View {
        VStack(spacing: 16){//add spacing on the sides
            VStack(spacing: 16){
                InputTextFieldView(text: $vm.credentials.email, placeholder: "Email", keyboardType: .emailAddress, sfSymbol: "envelope")
                InputPasswordView(password: $vm.credentials.password, placeholder: "Password", sfSymbol: "lock")
            }
            HStack{
                Spacer()//pushes the button to the right
                Button(action: {
                    showForgotPassword.toggle()
                }, label: {
                    Text("Forgot Password")
                })
                .font(.system(size: 16, weight: .bold))
                .sheet(isPresented: $showForgotPassword,
                    content: {
                        ForgotPasswordView()
                    })
            }
            
            
            VStack(spacing: 16){
                ButtonVIew(title: "Login"){
                //login action will be added later
                    vm.login()
                }
                ButtonVIew(title: "Register", background: .clear, foreground: .blue, border: .blue){
                 showRegistration.toggle()
                }.sheet(isPresented: $showRegistration,
                    content: {
                        RegisterView()
                    }
                )
            }
        }
        .padding(.horizontal, 15)
        .navigationTitle("Login")//title up top
        .alert(isPresented: $vm.hasError,
            content: {
                if case .failed(let error) = vm.state {
                    return Alert(title: Text("Error"), message: Text(error.localizedDescription))
                } else {
                    return Alert(
                        title: Text("Error"),
                        message: Text("Something went wrong")
                    )
                }
        })
    }
}
struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {//need to have this to see it in the preview
            LogInView()
        }
    }
}
