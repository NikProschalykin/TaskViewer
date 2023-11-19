import SwiftUI

/*
 
"Название"
"Опишите задачу"
"Сколько будет шагов"
"Название шагов"
"Описание шагов"
"Кто исполнитель"
"Назначил"
"Сколько времени на исполнение (По шагам, необязательно): "
"Последовательность выполнения?"
 
 */



struct CreateIssue: View {

    @StateObject private var viewModel = CreateIssueViewModel()
    
    @Environment(\.dismiss) var dismiss
    @State private var TitleTextField = ""
    @State private var DescriptionTextField = ""
    @State private var searchText = ""
    @State private var isConsistenly = false
    
    @State private var stepsInfo: [Step] = [Step(title: "", description: "")]
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Название")
                            .font(.title2)
                        TextField("Улучшить мир...",
                                  text: $TitleTextField,
                                  axis: .vertical)
                            .lineLimit(1...2)
                            .font(.headline)
                            .textFieldStyle(.roundedBorder)
                    }.padding()
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Описание задачи")
                            .font(.title2)
                        TextField("С помощью...",
                                  text: $DescriptionTextField,
                                  axis: .vertical)
                            .lineLimit(5...40)
                            .font(.headline)
                            .textFieldStyle(.roundedBorder)
                    }.padding()
                     
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Формирование шагов")
                            .font(.title2)
                            .padding(.bottom)
                        ForEach(stepsInfo.indices, id: \.self) { index in
                            
                            HStack {
                                Text("Шаг \(index + 1)")
                                    .font(.title3)
                                Spacer()
                                if index != 0 {
                                    Button(action: {
                                        stepsInfo.remove(at: index)
                                    }, label: {
                                        Image("Trash")
                                            .foregroundColor(.red)
                                            .scaleEffect(0.8)
                                        
                                    })
                                }
                            }.padding(.bottom)
                            
                            Text("Название")
                                .font(.title3)
                            TextField("Название шага",
                                      text: $stepsInfo[index].title,
                                      axis: .vertical)
                                .lineLimit(1...2)
                                .font(.headline)
                                .textFieldStyle(.roundedBorder)
                                .padding(.bottom)
                            
                            Text("Описание")
                                .font(.title3)
                            TextField("Описание шага",
                                      text: $stepsInfo[index].description,
                                      axis: .vertical)
                                .lineLimit(3...20)
                                .font(.subheadline)
                                .textFieldStyle(.roundedBorder)
                                .padding(.bottom)
                    
                            Divider()
                        }
                        
                        HStack(alignment: .center) {
                            Spacer()
                            Button(action: {
                                stepsInfo.append(Step(title: "", description: ""))
                            }, label: {
                                Text("Добавить шаг")
                            })
                            .padding()
                            .buttonStyle(.borderedProminent)
                            Spacer()
                        }
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Исполнители")
                                        .font(.title2)
                                        .padding(.bottom)
                                    
                                    Spacer()
                                    
                                    Menu(content: {
                                        ForEach(viewModel.performersToPick, id: \.self, content: {performer in
                                            Button(action: {
                                                viewModel.addPickedPerformer(performer: performer)
                                            }, label: {
                                                Text("\(performer.name) \(performer.surname) (\(performer.position))")
                                            })
                                        })
                                    }, label: {
                                        Image(systemName: "plus")
                                    })
                                }
                                
                                VStack {
                                    ForEach(viewModel.performers, id: \.self) { performer in
                                        HStack {
                                            Text("\(performer.name) \(performer.surname) (\(performer.position))")
                                                .font(.subheadline)
                                            Spacer()
                                            Button(action: {
                                                viewModel.deletePickedPerformer(performer: performer)
                                            }, label: {
                                                Image(systemName: "trash")
                                                    .foregroundColor(.red)
                                                    .scaleEffect(0.8)
                                            })
                                        }.padding(.bottom)
                                    }
                                }
                                
                            }.padding()
                            
                            Divider()
                            
                            VStack(alignment: .leading) {
                                Text("Назначил")
                                    .font(.title2)
                                Text("Profile_name")
                                
                            }.padding()
                            
                            Divider()
                            
                            HStack {
                                Text("Задача должны выполняться последовательно по шагам?")
                                    .font(.subheadline)
                                Spacer()
                                Toggle("", isOn: $isConsistenly)
                            }.padding(.horizontal)
                            
                            Divider()
                        }
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                viewModel.createTask(title: TitleTextField, description: DescriptionTextField, steps: stepsInfo, performers: viewModel.performers, disponcers: [viewModel.storedDisponser.first!], isConsistenly: isConsistenly)
                                dismiss()
                            }, label: { Text("Создать задачу!")})
                            .padding(.horizontal)
                            Spacer()
                        }
                        
                        Divider()
                        
                    }.padding()
                        .navigationBarTitle("Создание задачи")
                    Spacer()
                }
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct CreateIssue_Previews: PreviewProvider {
    static var previews: some View {
        CreateIssue()
    }
}


extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
