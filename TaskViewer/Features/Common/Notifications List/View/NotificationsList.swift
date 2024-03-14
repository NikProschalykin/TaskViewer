import SwiftUI

struct NotificationsList: View {
    
   @ObservedObject private var viewModel = NotificationsViewModel()
    
    var body: some View {
        ZStack {
            Color("BackGround")
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Уведомления")
                        .font(.custom(AvenirFont.medium.rawValue, size: 30))
                    if !viewModel.sortedNotifications.isEmpty {
                        ForEach($viewModel.sortedNotifications.indices, id: \.self.hashValue) { index in
                            VStack {
                                NotificationCard(notification: viewModel.sortedNotifications[index])
                            }
                            .padding(.all, 5)
                        }
                    } else {
                        HStack {
                            Text("Пока уведомлений нет")
                                .font(.custom(AvenirFont.regular.rawValue, size: 20))
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding(.all,5)
                    }
                }
                .padding(.all,10)
            }
        }
        .onAppear {
            viewModel.loadNotifications()
        }
        .onDisappear {
            viewModel.seenNotifications()
        }
    }
}

struct NotificationsList_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsList()
    }
}

struct NotificationCard: View {
    
    var notification: AppNotification
    
    var titleColor: Color {
        switch notification.title {
        case "Шаг завершен": return .green.opacity(0.8)
        case "Задача завершена": return .green.opacity(0.8)
        case "Задача отменена": return .red.opacity(0.8)
        default: return .black
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(notification.title)
                    .font(.custom(AvenirFont.medium.rawValue, size: 20))
                    .foregroundColor(titleColor)
                Spacer()
                if notification.status == .unseen {
                    Text("New!")
                        .font(.custom(AvenirFont.demibold.rawValue, size: 15))
                        .foregroundColor(.pink)
                }
            }
            Divider()
            Text(notification.decription)
                .font(.custom(AvenirFont.regular.rawValue, size: 20))
                .foregroundColor(.gray)
                .padding(.bottom,5)

            HStack {
                Spacer()
                Text(dateFormatted.string(from: notification.date))
                    .font(.custom(AvenirFont.regular.rawValue, size: 15))
            }
        }
        .padding(.all,20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(radius: 5)
        )
        .onDisappear() {
            // TODO: убрать новые уведомления
        }
    }
}
