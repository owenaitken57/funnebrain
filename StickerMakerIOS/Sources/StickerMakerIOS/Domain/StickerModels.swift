import Foundation

enum StickerMediaType: String, Codable {
    case staticImage
    case animated
    case video
}

struct StickerAsset: Identifiable, Codable {
    let id: UUID
    var title: String
    var mediaType: StickerMediaType
    var createdAt: Date
}

struct StickerPack: Identifiable, Codable {
    let id: UUID
    var name: String
    var author: String
    var trayImageFileName: String
    var stickers: [StickerAsset]

    init(id: UUID = UUID(), name: String, author: String, trayImageFileName: String, stickers: [StickerAsset]) {
        self.id = id
        self.name = name
        self.author = author
        self.trayImageFileName = trayImageFileName
        self.stickers = stickers
    }
}
