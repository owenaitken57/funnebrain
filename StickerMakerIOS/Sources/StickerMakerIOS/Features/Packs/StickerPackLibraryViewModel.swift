#if canImport(SwiftUI)
import Foundation

@MainActor
final class StickerPackLibraryViewModel: ObservableObject {
    @Published private(set) var packs: [StickerPack] = []
    @Published var showingExportMessage = false
    @Published var exportMessage = ""

    private let repository: StickerPackRepository
    private let exporter: WhatsAppStickerExporter

    init(repository: StickerPackRepository = InMemoryStickerPackRepository(), exporter: WhatsAppStickerExporter = .init()) {
        self.repository = repository
        self.exporter = exporter
        self.packs = repository.fetchAllPacks()
    }

    func export(pack: StickerPack) {
        do {
            try exporter.validate(pack: pack)
            exportMessage = "Pack '\(pack.name)' is valid. Hook up WhatsApp export API next."
        } catch {
            exportMessage = "Export blocked: \(error.localizedDescription)"
        }

        showingExportMessage = true
    }
}

#endif
