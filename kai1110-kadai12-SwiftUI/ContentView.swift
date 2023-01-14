
import SwiftUI

struct ContentView: View {
    @AppStorage("taxRate") private var taxRate = ""
    @State var withoutTax = ""
    @State var includingTax = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("税抜き金額")
                TextFieldView(value: $withoutTax)
                Text("円")
            }
            HStack {
                Text("消費税率")
                TextFieldView(value: $taxRate)
                Text("%")
            }
            Button(action: {
                includingTax = calclateTax(price: withoutTax, taxRate: taxRate)
            }) {
                Text("計算")
            }
            HStack {
                Text("税込金額")
                Text(String(includingTax))
                    .padding()
                Text("円")
            }
        }
    }
    private func parseNumber(number: String) -> Int {
        Int(number) ?? 0
    }
    private func calclateTax(price: String, taxRate: String) -> Int {
        let tax = parseNumber(number: price) * parseNumber(number: taxRate) / 100
        return parseNumber(number: price) + tax
    }
}

struct TextFieldView: View {
    @Binding var value: String
    
    var body: some View {
        TextField("", text: $value)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 150)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
