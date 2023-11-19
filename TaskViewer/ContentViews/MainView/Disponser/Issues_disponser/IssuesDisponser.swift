import SwiftUI

struct IssuesDisponser: View {
    
    @StateObject var viewModel = IssueDisponcerViewModel()
    
    var body: some View {
        VStack {
            IssueDisponserHeader()
                .padding(.bottom)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(viewModel.storedTasks, id: \.self) { task in
                        VStack() {
                            
                            HStack {
                                Text(task.title)
                                    .font(.title2)
                                Spacer()
                            }
                            .padding([.horizontal, .bottom])
                            
                            HStack {
                                Text(task.description)
                                    .font(.subheadline)
                                    .lineLimit(5, reservesSpace: false)
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            HStack {
                                Text(viewModel.getFormattedPerformers(task: task))
                                    .font(.subheadline)
                                .foregroundColor(.gray)
                                Spacer()
                                Text(viewModel.getFormattedDisponcers(task: task))
                                    .font(.subheadline)
                                .foregroundColor(.gray)
                            }
                            .padding([.horizontal, .top])
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: -10) {
                                    
                                    ForEach(task.steps.indices, id: \.self ) { i in
                                        if i != 0 {
                                            LineView()
                                        }
                                        CircleView(number: i+1)
                                    }
                                }
                            }

                            Divider()
                        }
                        .padding(.vertical)
                        
                        
                    }
                }
            }
            Spacer()
        }
    }
}

struct IssuesDisponser_Previews: PreviewProvider {
    static var previews: some View {
        IssuesDisponser()
    }
}

struct CircleView: View {
    var number: Int

    var body: some View {
        VStack {
            Circle()
                .fill(Color.black)
                .frame(width: 30, height: 30)
                .overlay(
                    Text("\(number)")
                        .foregroundColor(.white)
                        .font(.headline)
                )
        }
        .padding()
    }
}

struct LineView: View {
    var body: some View {
        Rectangle()
            .fill(Color.black)
            .frame(width: 50, height: 2)
    }
}

