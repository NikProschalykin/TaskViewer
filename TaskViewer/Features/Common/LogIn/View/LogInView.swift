import SwiftUI

struct LogInView: View {
    
    @EnvironmentObject var userStateViewModel: UserStateViewModel

    var body: some View {
        NavigationStack {
            VStack {
                
                Button {
                    userStateViewModel.signIn()
                    UserSettings.shared.user = constantAdmin
                    
                } label: {
                    Text("Admin")
                        .font(.custom(AvenirFont.medium.rawValue, size: 30))
                }
                .padding(.all,20)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                )
                
                Button {
                    userStateViewModel.signIn()
                    UserSettings.shared.user = constantDisponcer
                } label: {
                    Text("Disponcer")
                        .font(.custom(AvenirFont.medium.rawValue, size: 30))
                }
                .padding(.all,20)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                )
                
                Button {
                    userStateViewModel.signIn()
                    UserSettings.shared.user = constatntPerformers.first!
                } label: {
                    Text("Performer")
                        .font(.custom(AvenirFont.medium.rawValue, size: 30))
                }
                .padding(.all,20)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                )
            }
            .padding(.all, 20)
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static 	var previews: some View {
        LogInView()
    }
}
