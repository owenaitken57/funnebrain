import Foundation
import Testing
@testable import StickerMakerIOS

struct StickerMakerIOSTests {
    @Test
    func exportValidationRequiresMinimumStickers() {
        let exporter = WhatsAppStickerExporter()
        let pack = StickerPack(name: "Funny Pack", author: "Test", trayImageFileName: "tray.png", stickers: [])

        #expect(throws: WhatsAppStickerExporter.ExportError.notEnoughStickers) {
            try exporter.validate(pack: pack)
        }
    }

    @Test
    func exportValidationPassesWithinRange() throws {
        let exporter = WhatsAppStickerExporter()
        let stickers = (1...3).map { index in
            StickerAsset(id: UUID(), title: "Sticker \(index)", mediaType: .staticImage, createdAt: .now)
        }
        let pack = StickerPack(name: "Funny Pack", author: "Test", trayImageFileName: "tray.png", stickers: stickers)

        try exporter.validate(pack: pack)
    }
}
