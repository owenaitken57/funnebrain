import Foundation

@MainActor
protocol StickerPackRepository {
    func fetchAllPacks() -> [StickerPack]
    func add(sticker: StickerAsset, toPackNamed name: String) throws
}

enum StickerPackRepositoryError: LocalizedError {
    case cannotCreatePack

    var errorDescription: String? {
        switch self {
        case .cannotCreatePack:
            return "Could not create sticker pack."
        }
    }
}

@MainActor
final class InMemoryStickerPackRepository: StickerPackRepository {
    private static var sharedPacks: [StickerPack] = [
        StickerPack(
            name: "Funny Pack",
            author: "You",
            trayImageFileName: "tray.png",
            stickers: []
        )
    ]

    func fetchAllPacks() -> [StickerPack] {
        Self.sharedPacks
    }

    func add(sticker: StickerAsset, toPackNamed name: String) throws {
        guard let packIndex = Self.sharedPacks.firstIndex(where: { $0.name == name }) else {
            throw StickerPackRepositoryError.cannotCreatePack
        }

        Self.sharedPacks[packIndex].stickers.append(sticker)
    }
}
