import SwiftUI
struct HomeView: View {
    @EnvironmentObject var sessionService: SessionServiceImpl
    @State private var showUpdateView = false

    
    var body: some View{
        VStack(alignment: .leading, spacing: 16){
            VStack(alignment: .leading, spacing: 16){
                Text("First Name: \(sessionService.userDetails?.firstName ?? "N/A")")
                Text("Last Name: \(sessionService.userDetails?.lastName ?? "N/A")")
                Text("City: \(sessionService.userDetails?.city ?? "N/A")")
            }
            ButtonVIew(title: "Update Infomation"){
                showUpdateView.toggle()
            }.sheet(isPresented: $showUpdateView, content: {
                UpdateButtonView();
            })
            ButtonVIew(title: "Logout"){
                sessionService.logout()
            }
        }
        .padding(.horizontal, 16).navigationTitle("Main Content View")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(SessionServiceImpl())
        }
    }
}
