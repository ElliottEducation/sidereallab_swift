import SwiftUI

struct CalculatorView: View {
    @StateObject private var viewModel = RotationViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                // 纬度输入
                Section(header: Text("Input Latitude")) {
                    HStack {
                        Text("Latitude (°)")
                        Spacer()
                        TextField("Latitude", value: $viewModel.latitude, format: .number)
                            .keyboardType(.decimalPad)
                            .frame(width: 100)
                    }
                }
                
                // 时间输入 Start
                Section(header: Text("Start Time")) {
                    DatePicker("Date", selection: $viewModel.startTime, displayedComponents: .date)
                    DatePicker("Time", selection: $viewModel.startTime, displayedComponents: .hourAndMinute)
                    
                    Stepper("Seconds: \(Calendar.current.component(.second, from: viewModel.startTime))", value: Binding(
                        get: { Calendar.current.component(.second, from: viewModel.startTime) },
                        set: { newVal in
                            viewModel.startTime = Calendar.current.date(bySetting: .second, value: newVal, of: viewModel.startTime) ?? viewModel.startTime
                        }
                    ), in: 0...59)
                }
                
                // 时间输入 End
                Section(header: Text("End Time")) {
                    DatePicker("Date", selection: $viewModel.endTime, displayedComponents: .date)
                    DatePicker("Time", selection: $viewModel.endTime, displayedComponents: .hourAndMinute)
                    
                    Stepper("Seconds: \(Calendar.current.component(.second, from: viewModel.endTime))", value: Binding(
                        get: { Calendar.current.component(.second, from: viewModel.endTime) },
                        set: { newVal in
                            viewModel.endTime = Calendar.current.date(bySetting: .second, value: newVal, of: viewModel.endTime) ?? viewModel.endTime
                        }
                    ), in: 0...59)
                }
                
                // 亮星 / 天体选择
                Section(header: Text("Select Target (Optional)")) {
                    Picker("Celestial Object", selection: $viewModel.selectedTarget) {
                        Text("None").tag(nil as CelestialTarget?)
                        ForEach(celestialTargets, id: \.self) { target in
                            Text(target.name).tag(target as CelestialTarget?)
                        }
                    }
                    .onChange(of: viewModel.selectedTarget) { _ in
                        viewModel.applySelectedTarget()
                    }
                }
                
                // RA / Dec 输入区
                Section(header: Text("RA/Dec Correction (Optional)")) {
                    Toggle("Use RA/Dec instead of time", isOn: $viewModel.useRAInput)
                    
                    if viewModel.useRAInput {
                        HStack {
                            Text("RA at Time 1 (hr)")
                            Spacer()
                            TextField("RA1", value: $viewModel.ra1, format: .number)
                                .keyboardType(.decimalPad)
                                .frame(width: 100)
                        }
                        HStack {
                            Text("RA at Time 2 (hr)")
                            Spacer()
                            TextField("RA2", value: $viewModel.ra2, format: .number)
                                .keyboardType(.decimalPad)
                                .frame(width: 100)
                        }
                        HStack {
                            Text("Dec at Time 1 (°)")
                            Spacer()
                            TextField("Dec1", value: $viewModel.dec1, format: .number)
                                .keyboardType(.decimalPad)
                                .frame(width: 100)
                        }
                        HStack {
                            Text("Dec at Time 2 (°)")
                            Spacer()
                            TextField("Dec2", value: $viewModel.dec2, format: .number)
                                .keyboardType(.decimalPad)
                                .frame(width: 100)
                        }
                    }
                }
                
                // 结果显示
                Section(header: Text("Results")) {
                    HStack {
                        Text("ΔT")
                        Spacer()
                        Text(viewModel.deltaTString)
                    }
                    HStack {
                        Text("ω (rad/s)")
                        Spacer()
                        Text(viewModel.omegaString)
                    }
                    HStack {
                        Text("Speed (m/s)")
                        Spacer()
                        Text(viewModel.speedString)
                    }
                }
            }
            .navigationTitle("Sidereal Calculator")
        }
    }
}

