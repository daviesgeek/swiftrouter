import PackageDescription

let package = Package(
  name: "swiftrouter-example",
  dependencies: [
    .Package(url: "https://github.com/daviesgeek/swiftrouter.git", Version(0, 0, 3))
  ]
)