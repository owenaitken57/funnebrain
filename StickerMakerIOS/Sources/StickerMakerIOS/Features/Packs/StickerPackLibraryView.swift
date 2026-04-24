#if canImport(SwiftUI)
import SwiftUI

struct StickerPackLibraryView: View {
    @StateObject var viewModel: StickerPackLibraryViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.packs) { pack in
                    Section(pack.name) {
                        Text("\(pack.stickers.count) stickers")
                        Button("Export to WhatsApp") {
                            viewModel.export(pack: pack)
                        }
                    }
                }
            }
            .navigationTitle("My Sticker Packs")
            .overlay {
                if viewModel.packs.isEmpty {
                    ContentUnavailableView("No sticker packs yet", systemImage: "square.stack")
                }
            }
            .alert("Export", isPresented: $viewModel.showingExportMessage) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.exportMessage)
            }
        }
    }
}

#endif
