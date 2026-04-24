#if canImport(SwiftUI)
import PhotosUI
import SwiftUI

struct CreateStickerView: View {
    @StateObject var viewModel: CreateStickerViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section("Source") {
                    PhotosPicker(selection: $viewModel.selectedAsset, matching: .any(of: [.images, .videos])) {
                        Label("Pick image, GIF, or video", systemImage: "photo.on.rectangle")
                    }

                    if let fileName = viewModel.selectedFileName {
                        Label(fileName, systemImage: "doc")
                            .font(.subheadline)
                    }
                }

                Section("Sticker settings") {
                    TextField("Sticker title", text: $viewModel.stickerTitle)
                    Toggle("Animated sticker", isOn: $viewModel.isAnimated)
                    Stepper("Frame rate: \(viewModel.targetFrameRate) fps", value: $viewModel.targetFrameRate, in: 8...24)
                }

                Section("Actions") {
                    Button("Generate preview") {
                        viewModel.generatePreview()
                    }

                    Button("Add to pack") {
                        viewModel.addToPack()
                    }
                    .disabled(!viewModel.canAddToPack)
                }

                if let statusMessage = viewModel.statusMessage {
                    Section("Status") {
                        Text(statusMessage)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Sticker Maker")
        }
    }
}

#endif
