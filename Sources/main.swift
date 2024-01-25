import ArgumentParser
import Foundation

@main
struct ResolveAlias: ParsableCommand {
  @Argument(
    help: "Path(s) to the alias file(s) to resolve.",
    completion: .file())
  var aliasFilePaths: [String]

  mutating func run() throws {
    for aliasFilePath in aliasFilePaths {
      let aliasFileURL = URL(fileURLWithPath: aliasFilePath)

      let bookmarkData = try URL.bookmarkData(withContentsOf: aliasFileURL)

      var stale = false
      let resolvedURL = try URL(resolvingBookmarkData: bookmarkData, bookmarkDataIsStale: &stale)

      switch resolvedURL.scheme {
      case "file":
        print(resolvedURL.path)
      default:
        print(resolvedURL)
      }
    }
  }
}
