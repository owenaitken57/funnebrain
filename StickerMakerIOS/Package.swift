// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "StickerMakerIOS",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "StickerMakerIOS", targets: ["StickerMakerIOS"])
    ],
    targets: [
        .target(name: "StickerMakerIOS"),
        .testTarget(name: "StickerMakerIOSTests", dependencies: ["StickerMakerIOS"])
    ]
)
