#if canImport(SwiftUI)
import SwiftUI

public struct StickerMakerAppView: View {
    @State private var selectedTab: Tab = .create

    public init() {}

    public var body: some View {
        TabView(selection: $selectedTab) {
            CreateStickerView(viewModel: .init())
                .tabItem {
                    Label("Create", systemImage: "wand.and.stars")
                }
                .tag(Tab.create)

            StickerPackLibraryView(viewModel: .init())
                .tabItem {
                    Label("My Packs", systemImage: "square.grid.2x2")
                }
                .tag(Tab.packs)
        }
    }
}

private enum Tab {
    case create
    case packs
}

#endif
