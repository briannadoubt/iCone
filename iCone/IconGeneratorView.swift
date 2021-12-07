//
//  ContentView.swift
//  Shared
//
//  Created by Bri on 12/5/21.
//

import SwiftUI
import FilesUI

final class IconGeneratorState: ObservableObject {
    
    @Published var selectedImage: URL?
    @Published var selectedDestination: URL?
    @Published var icon: iCone = .unspecified
    @Published var error: String?
    
}

struct IconGeneratorView: View {
    
    @StateObject var state = IconGeneratorState()
    @State var showingSuccessAlert = false
    @Environment(\.openURL) var openURL
    
    #if os(iOS)
    var image: UIImage? {
        if let url = selectedImage {
            return UIImage(contentsOf: url)
        }
        return nil
    }
    #else
    var image: NSImage? {
        if let url = state.selectedImage {
            return NSImage(contentsOf: url)
        }
        return nil
    }
    #endif
    
    private func generateIcons(_ icon: iCone, selectedImage: URL, selectedDestination: URL) {
        do {
            try icon.generate(from: selectedImage, to: selectedDestination)
            self.showingSuccessAlert = true
        } catch let error as iConeError {
            state.error = error.localizedDescription
        } catch {
            state.error = error.localizedDescription
        }
    }
    
    var body: some View {
        NavigationView {
            if let image = image {
                VStack {
                    Group {
                        #if os(macOS)
                        Image(nsImage: image)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                        #else
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                        #endif
                    }
                    .cornerRadius(44)
                    .listRowInsets(EdgeInsets())
                    .frame(
                        minWidth: 300,
                        idealWidth: 414,
                        maxWidth: 512,
                        minHeight: 300,
                        idealHeight: 414,
                        maxHeight: 512
                    )
                    .padding(.horizontal)
                    
                    Button { state.selectedImage = nil } label: {
                        Text("Clear")
                            .bold()
                            .foregroundColor(.accentColor)
                    }
                    .buttonStyle(.borderless)
                    .padding(.bottom, 4)
                }
            } else {
                FilePicker([.image], file: $state.selectedImage, cornerRadius: 44)
                    .frame(
                        minWidth: 300,
                        idealWidth: 414,
                        maxWidth: 512,
                        minHeight: 300,
                        idealHeight: 414,
                        maxHeight: 512
                    )
                    .aspectRatio(1, contentMode: .fit)
            }
            
            VStack {
                List {
                    if let error = state.error {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    if state.selectedImage != nil {
                        Section {
                            DirectoryPicker(directory: $state.selectedDestination)
                                .onAppear(perform: {
                                    withAnimation {
                                        do {
                                            state.selectedDestination = try FileManager.default.url(for: .downloadsDirectory, in: .localDomainMask, appropriateFor: nil, create: false)
                                        } catch {
                                            do {
                                                state.selectedDestination = try FileManager.default.url(for: .desktopDirectory, in: .localDomainMask, appropriateFor: nil, create: false)
                                            } catch {
                                                print("No access to user's shtuffs")
                                            }
                                        }
                                    }
                                })
                        } header: {
                            Text("Destination")
                        }
                    }
                    
                    if state.selectedDestination != nil, let selectedImage = state.selectedImage {
                        Section {
                            Picker(selection: $state.icon) {
                                Text("iOS")
                                    .tag(iCone.ios(selectedImage.deletingPathExtension().lastPathComponent))
                                Text("macOS")
                                    .tag(iCone.macos(selectedImage.deletingPathExtension().lastPathComponent))
                                Text("watchOS")
                                    .tag(iCone.watchos(selectedImage.deletingPathExtension().lastPathComponent))
                            } label: {
                                Text("Platform")
                            }
                            .fixedSize()
                        } header: {
                            Text("Platform")
                        }
                    }
                }
                .frame(minWidth: 128)
                
                if let selectedImage = state.selectedImage, let selectedDestination = state.selectedDestination, let icon = state.icon, state.icon != .unspecified {
                    Button {
                        generateIcons(icon, selectedImage: selectedImage, selectedDestination: selectedDestination)
                    } label: {
                        HStack {
                            Spacer()
                            Text("Make It So")
                            Spacer()
                        }
                    }
                    .padding()
                }
            }
        }
        .alert("Success!", isPresented: $showingSuccessAlert) {
            Button("View in Finder") {
                guard let destination = state.selectedDestination else {
                    assertionFailure()
                    return
                }
                NSWorkspace.shared.open(destination)
            }
            Button("Close", role: ButtonRole.cancel) {}

        } message: {
            Text("Your new icon files have been exported successfully.")
        }

    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(selectedDestination: URL(), icon: <#iCone#>)
//    }
//}
