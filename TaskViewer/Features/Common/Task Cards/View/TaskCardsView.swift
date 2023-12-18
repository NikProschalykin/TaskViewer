import SwiftUI

struct TaskCardsView: View {
    
    @Binding var tasks: [Task]
    var status: TaskStatus = TaskStatus.inProgress
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(tasks, id: \.self) { task in
                NavigationLink(destination: IssueEdit(task: task)) {
                    VStack {
                        HStack {
                            Text(task.title)
                                .font(.custom(AvenirFont  .demibold.rawValue, size: 24))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding([.horizontal])
                        .padding(.bottom,2)
                        
                        HStack {
                            Text(task.description)
                                .font(.custom(AvenirFont.demibold.rawValue, size: 20))
                                .lineLimit(5, reservesSpace: false)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text(getFormattedPerformers(task: task))
                                .font(.custom(AvenirFont.medium.rawValue, size: 20))
                                .foregroundColor(.gray)
                            Spacer()
                            Text(getFormattedDisponcers(task: task))
                                .font(.custom(AvenirFont.medium.rawValue, size: 20))
                                .foregroundColor(.gray)
                        }
                        .padding([.horizontal, .top])
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                
                                ForEach(task.steps.indices, id: \.self ) { index in
                                    if index != 0 {
                                        LineView()
                                    }
                                    CircleView(number: index+1,currentStep: task.currentStep, frame: 28)
                                }
                            }
                            .padding(.leading, -10)
                        }
                        
                        HStack {
                            if let date = task.lastEditDate {
                                Text("Последнее изменение:")
                                    .font(.custom(AvenirFont.demibold.rawValue, size: 20))
                                    .foregroundColor(.black)
                                Spacer()
                                Text(dateFormatted.string(from: date))
                                    .font(.custom(AvenirFont.medium.rawValue, size: 20))
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding([.leading,.trailing], 10)
                    }
                }
            }
            .padding(.all, 10)
            .background(status == .completed ? Color.green.opacity(0.2) : (status == .canceled ? Color.red.opacity(0.2) : Color.white))
            .cornerRadius(10.0)
            .shadow(radius: 5)
        }
    }
}

struct TaskCards_Previews: PreviewProvider {
    static var previews: some View {
        IssuesDisponser()
    }
}

extension TaskCardsView {
    private func getFormattedPerformers(task: Task) -> String {
        var str = ""
        
        task.performers.forEach({ performer in
            str += "\(performer.name),"
        })
        str.removeLast()
        
        return str
    }
    
    private func getFormattedDisponcers(task: Task) -> String {
        task.disponser.name
    }
}
