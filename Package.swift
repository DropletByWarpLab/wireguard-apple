// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
// DropletByWarpLab fork patch: upstream declares 5.3 but the manifest uses
// .macOS(.v12)/.iOS(.v15), which require PackageDescription 5.5 — strict
// SwiftPM in Xcode 26.3 rejects the mismatch ("'v12'/'v15' is unavailable").
// Bumped to 5.5 (the version those platform APIs were introduced in) so the
// package resolves. No other manifest change; revert to upstream once it
// ships a corrected tools-version. (WARP-1211)

import PackageDescription

let package = Package(
    name: "WireGuardKit",
    platforms: [
        .macOS(.v12),
        .iOS(.v15)
    ],
    products: [
        .library(name: "WireGuardKit", targets: ["WireGuardKit"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WireGuardKit",
            dependencies: ["WireGuardKitGo", "WireGuardKitC"]
        ),
        .target(
            name: "WireGuardKitC",
            dependencies: [],
            publicHeadersPath: "."
        ),
        .target(
            name: "WireGuardKitGo",
            dependencies: [],
            exclude: [
                "goruntime-boottime-over-monotonic.diff",
                "go.mod",
                "go.sum",
                "api-apple.go",
                "Makefile"
            ],
            publicHeadersPath: ".",
            linkerSettings: [.linkedLibrary("wg-go")]
        )
    ]
)
