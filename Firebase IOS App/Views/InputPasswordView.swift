import SwiftUI

struct InputPasswordView: View {
    @Binding var password: String
    let placeholder: String
    private let textFieldLeading: CGFloat = 30//handles symbol position
    let sfSymbol: String?
    
    var body: some View {
        SecureField(placeholder, text: $password)
        .frame(maxWidth: .infinity, minHeight: 44)
        .padding(.leading, sfSymbol == nil ? textFieldLeading / 2 : textFieldLeading).background(
            ZStack(alignment: .leading) {
                if let systemImage = sfSymbol {
                Image(systemName: systemImage) .font(.system(size: 16, weight: .semibold)) .padding(.leading, 5) .foregroundColor(Color.gray.opacity(0.5))
                }
                RoundedRectangle(cornerRadius:10, style: .continuous)
                .stroke(Color.gray.opacity(0.25))
            }
        ).autocapitalization(UITextAutocapitalizationType.none)
    }
}
struct InputPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
        InputPasswordView(password: .constant(""), placeholder: "Password", sfSymbol: "lock").preview(with: "Input Password View with sfSymbol")
        InputPasswordView(password: .constant(""), placeholder: "Password", sfSymbol: nil).preview(with: "Input Password View without sfSymbol")
        }
    }
}
