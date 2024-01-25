// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "resolve-alias",
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-argument-parser",
      from: "1.3.0")
  ],
  targets: [
    .executableTarget(
      name: "resolve-alias",
      dependencies: [
        .product(
          name: "ArgumentParser",
          package: "swift-argument-parser"
        )
      ],
      path: "Sources")
  ]
)
