import SwiftUI

struct OverviewDisponser: View {
    
    @StateObject var viewModel = OverviewDisponcerViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackGround")
                    .ignoresSafeArea()
                
                    VStack {
                        HStack {
                            Text("Главное")
                                .font(.largeTitle)
                            Spacer()
                            NavigationLink {
                                CreateIssue()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .scaleEffect(1.5)
                            }
                        }
                        .padding(.all, 20)
                        .background(Color.white)
                        
                        ScrollView(showsIndicators: false) {
                        VStack {
                            dropDownButton(isOpen: $viewModel.isLastEditPresented, title: "Недавно изменено", image: "highlighter")
                                .padding([.leading,.trailing], 10)
                            if viewModel.isLastEditPresented {
                                ScrollView(showsIndicators: false) {
                                    TaskCardsView(tasks: $viewModel.lastUpdatedTasks)
                                }
                            }
                        }
                        
                        VStack {
                            dropDownButton(isOpen: $viewModel.isTrackedPerformersPresented,title: "Отслеживаемы работники",image: "star.fill")
                                .padding([.leading,.trailing], 10)
                            if viewModel.isTrackedPerformersPresented {
                                VStack {
                                    ScrollView(.horizontal) {
                                        PerformersCardsView(performers: $viewModel.trackedPerformers)
                                    }
                                }
                            }
                        }
                        .padding(.vertical)
                        
                        VStack {
                            dropDownButton(isOpen: $viewModel.isTrackedTasksPresented,title: "Отслеживаемы задачи",image: "star.fill")
                                .padding([.leading,.trailing], 10)
                            if viewModel.isTrackedTasksPresented {
                                ScrollView(showsIndicators: false) {
                                    TaskCardsView(tasks: $viewModel.trackedTasks)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct OverviewDisponser_Previews: PreviewProvider {
    static var previews: some View {
        OverviewDisponser()
    }
}


struct dropDownButton: View {
    
    @Binding var isOpen: Bool
    var title: String
    var image: String
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    self.isOpen.toggle()
                }
            }, label: {
                HStack {
                    Text(title)
                        .font(.custom(AvenirFont.medium.rawValue,size: 20))
                    Image(systemName: image)
                        .foregroundColor(.yellow)
                        .offset(y: -2)
                    Spacer()
                    Image(systemName: self.isOpen ? "chevron.up" : "chevron.down")
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                }
                
            })
        }
    }
}

struct PerformersCardsView: View {
    
    @Binding var performers: [Performer]
    
    //TODO: calculate active tasks
    var curTasksCount: Int {
        5
    }
    
    var body: some View {
        HStack {
            ForEach(performers, id: \.self) { performer in
                NavigationLink {
                    PerformerPreView(performer: performer)
                } label: {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(performer.imageName)
                                .resizable()
                                .frame(width: 80,height: 80)
                                .padding(.trailing,20)
                            Text("\(performer.name) \(performer.surname) \n(\(performer.position))")
                                .font(.custom(AvenirFont.medium.rawValue, size: 30))
                                .lineLimit(2...3)
                            Spacer()
                        }
                        .padding([.bottom,.top],10)
                        Text("Активных задач - \(curTasksCount)")
                            .font(.custom(AvenirFont.regular.rawValue, size: 20))
                            .offset(x: 3)
                            .padding(.bottom,10)
                    }
                    .padding(.all, 10)
                    .background(Color.white)
                    .cornerRadius(10.0)
                    .shadow(radius: 2)
                }

                
               
            }
            .frame(width: UIScreen.main.bounds.width - 20)
        }
        
    }
}
