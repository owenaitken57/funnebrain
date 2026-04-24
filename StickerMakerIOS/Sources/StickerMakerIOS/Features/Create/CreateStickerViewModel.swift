#if canImport(PhotosUI)
import Foundation
import PhotosUI

@MainActor
final class CreateStickerViewModel: ObservableObject {
    @Published var selectedAsset: PhotosPickerItem?
    @Published var stickerTitle = ""
    @Published var isAnimated = true
    @Published var targetFrameRate = 12
    @Published var statusMessage: String?

    private let processor: StickerProcessing
    private let repository: StickerPackRepository

    init(processor: StickerProcessing = StickerProcessor(), repository: StickerPackRepository = InMemoryStickerPackRepository()) {
        self.processor = processor
        self.repository = repository
    }

    var selectedFileName: String? {
        selectedAsset?.itemIdentifier
    }

    var canAddToPack: Bool {
        selectedAsset != nil && !stickerTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func generatePreview() {
        guard let selectedAsset else {
            statusMessage = "Choose a file first."
            return
        }

        statusMessage = "Generating preview from \(selectedAsset.itemIdentifier ?? "selected media")..."
    }

    func addToPack() {
        guard canAddToPack else {
            statusMessage = "Provide a sticker title and source media first."
            return
        }

        let newSticker = StickerAsset(
            id: UUID(),
            title: stickerTitle,
            mediaType: isAnimated ? .animated : .staticImage,
            createdAt: Date()
        )

        do {
            try repository.add(sticker: newSticker, toPackNamed: "Funny Pack")
            statusMessage = "Sticker added to Funny Pack ✅"
        } catch {
            statusMessage = "Could not add sticker: \(error.localizedDescription)"
        }
    }
}

#endif
