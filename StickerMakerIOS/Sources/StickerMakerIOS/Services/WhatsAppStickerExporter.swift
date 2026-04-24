import Foundation

struct WhatsAppStickerExporter {
    enum ExportError: LocalizedError {
        case notEnoughStickers
        case tooManyStickers

        var errorDescription: String? {
            switch self {
            case .notEnoughStickers:
                return "WhatsApp packs should contain at least 3 stickers for a good user experience."
            case .tooManyStickers:
                return "WhatsApp sticker packs support a maximum of 30 stickers."
            }
        }
    }

    func validate(pack: StickerPack) throws {
        if pack.stickers.count < 3 {
            throw ExportError.notEnoughStickers
        }

        if pack.stickers.count > 30 {
            throw ExportError.tooManyStickers
        }
    }
}
