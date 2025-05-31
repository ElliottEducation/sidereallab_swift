import SwiftUI

struct TimeInputView: View {
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var second: Int

    var body: some View {
        HStack(spacing: 8) {
            TextField("HH", value: $hour, format: .number)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 50)
            Text(":")
            TextField("MM", value: $minute, format: .number)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 50)
            Text(":")
            TextField("SS", value: $second, format: .number)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 50)
        }
    }
}

