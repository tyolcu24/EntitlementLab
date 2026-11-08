// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "EntitlementLab",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "EntitlementLab", targets: ["EntitlementLab"]),
        .executable(name: "EntitlementLabDemo", targets: ["EntitlementLabDemo"])
    ],
    targets: [
        .target(name: "EntitlementLab"),
        .executableTarget(name: "EntitlementLabDemo", dependencies: ["EntitlementLab"]),
        .testTarget(name: "EntitlementLabTests", dependencies: ["EntitlementLab"])
    ]
)
