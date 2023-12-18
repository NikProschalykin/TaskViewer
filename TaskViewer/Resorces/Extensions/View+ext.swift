import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

struct CircleView: View {
    var number: Int
    var currentStep: Int
    var frame: CGFloat
    var body: some View {
        VStack {
            switch number {
            case ..<currentStep:
                Circle()
                    .fill(Color.green)
                    .frame(width: frame, height: frame)
                    .overlay(
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                    )
            case currentStep... :
                Circle()
                    .fill(number == currentStep ? Color.blue : Color.black)
                    .frame(width: frame, height: frame)
                    .overlay(
                        Text("\(number)")
                            .foregroundColor(.white)
                            .font(.title2)
                    )
            default:
                Circle().overlay(Color.red)
            }
            
        }
        .padding()
    }
}

struct BlockView<Content: View>: View {
    var content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
            self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: geometry.size.width, height: 200)
                .overlay(content)
        }
    }
}

struct LineView: View {
    
    var width: CGFloat = 50
    var height: CGFloat = 2
    
    init(width: CGFloat = 50, height: CGFloat = 2) {
        self.width = width
        self.height = height
    }
    
    var body: some View {
        Rectangle()
            .fill(Color.black)
            .frame(width: width, height: height)
    }
}

struct CustomBlueButton: View {
    var buttonText: String
    var font: Font = Font.headline
    var color: Color = Color.blue
    var action: () -> Void

    var body: some View {
        Button(action: {
            self.action()
        }) {
            Text(buttonText)
                .font(font)
                .foregroundColor(.white)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(color)
                .cornerRadius(10)
                .padding(.horizontal, 5)
        }
    }
}

struct issueTextField: View {
    @Binding var text: String
    var placeholder: String
    var linelimit: ClosedRange<Int>
    
    var body: some View {
        HStack {
            Image(systemName: "chevron.compact.left")
                .padding(.leading, 0)
                .foregroundColor(.black)
            
            TextField(placeholder, text: $text,axis: .vertical)
                .padding(10)
                .lineLimit(linelimit)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 2, x: 1, y: 1)
                )
            
            Image(systemName: "chevron.compact.right")
                .padding(.trailing, 0)
                .foregroundColor(.black)
        }
        .padding([.leading, .trailing], 0)
    }
}
