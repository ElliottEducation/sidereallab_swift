import SwiftUI

struct CalculatorView: View {
    @ObservedObject var viewModel: RotationViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // ✅ heading moving down spacer
                VStack(spacing: 8) {
                    Spacer().frame(height: 24)

                    Text("🌏 Sidereal Calculator")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity)

                // latitude input
                HStack {
                    Text("Latitude (+ in N, − in S)")
                        .font(.headline)
                    Spacer()
                    TextField("Latitude", value: $viewModel.latitude, format: .number)
                        .keyboardType(.decimalPad)
                        .frame(width: 100)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)

                // Celestial Picker
                HStack {
                    Text("Celestial Target")
                        .font(.headline)
                    Spacer()
                    Picker("", selection: $viewModel.selectedTarget) {
                        Text("None").tag(nil as CelestialTarget?)
                        ForEach(celestialTargets, id: \.self) { target in
                            Text(target.name).tag(target as CelestialTarget?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 180)
                }
                .padding(.horizontal)

                // Start & End Time sections
                GroupBox(label: Text("Start Time")) {
                    HStack(spacing: 12) {
                        TextField("yyyy-mm-dd", text: $viewModel.startDateString)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 120)

                        TimeInputView(hour: $viewModel.startHour, minute: $viewModel.startMinute, second: $viewModel.startSecond)
                    }
                    .padding(.vertical, 6)
                }

                GroupBox(label: Text("End Time")) {
                    HStack(spacing: 12) {
                        TextField("yyyy-mm-dd", text: $viewModel.endDateString)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 120)

                        TimeInputView(hour: $viewModel.endHour, minute: $viewModel.endMinute, second: $viewModel.endSecond)
                    }
                    .padding(.vertical, 6)
                }

                // Calculated parameters
                GroupBox(label: Text("Calculated Parameters")) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("📍 Local Radius: \(String(format: "%.2f", viewModel.effectiveRadius / 1000)) km")

                        HStack {
                            Text("💨 Local Speed: \(viewModel.speedConverted) \(viewModel.selectedSpeedUnit.rawValue)")
                            Spacer()
                            Picker("", selection: $viewModel.selectedSpeedUnit) {
                                ForEach(RotationViewModel.SpeedUnit.allCases) { unit in
                                    Text(unit.rawValue).tag(unit)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .frame(width: 80)
                        }

                        Text("⏱ Angular Speed: \(viewModel.omegaScientificString) rad/s")
                    }
                    .font(.system(size: 16, weight: .medium))
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                }
            }
            .padding()
        }
    }
}

