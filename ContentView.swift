// ✅ 分类选择器嵌入 ContentView（包含 Picker + 自动填充公式）

import SwiftUI

struct ContentView: View {
    @State private var mainCategory = "Mathematics"
    @State private var subCategory = "Functions"
    @State private var formulaInput = ""
    @State private var tikzCode = ""
    @State private var naturalLanguageInput = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    Text("Math2TikZ v1.7")
                        .font(.largeTitle).bold()

                    Picker("Main Category", selection: $mainCategory) {
                        ForEach(Array(MathCategoryModel.categories.keys), id: \.self) { key in
                            Text(key)
                        }
                    }
                    .pickerStyle(.menu)

                    Picker("Sub Category", selection: $subCategory) {
                        ForEach(MathCategoryModel.categories[mainCategory] ?? [], id: \.self) { sub in
                            Text(sub)
                        }
                    }
                    .pickerStyle(.menu)
                    .onChange(of: subCategory) { _ in
                        if let template = TemplateLibrary.template(for: mainCategory, sub: subCategory) {
                            formulaInput = template.defaultFormula
                        }
                    }

                    TextField("Natural language input", text: $naturalLanguageInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button("Generate from Natural Language") {
                        tikzCode = NaturalLanguageTikzService.generate(from: naturalLanguageInput)
                    }

                    TextEditor(text: $formulaInput)
                        .frame(height: 120)
                        .border(Color.gray)

                    Button("Convert to TikZ") {
                        tikzCode = FormulaToTikzConverter.convert(input: formulaInput, category: subCategory)
                    }

                    GroupBox(label: Text("Generated TikZ Code")) {
                        ScrollView(.horizontal) {
                            Text(tikzCode)
                                .font(.system(.body, design: .monospaced))
                                .padding(6)
                        }
                        Button("Copy TikZ Code") {
                            UIPasteboard.general.string = tikzCode
                        }
                    }
                }
                .padding()
            }
        }
    }
}

