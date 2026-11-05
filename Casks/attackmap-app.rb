cask "attackmap-app" do
  version "0.3.0"
  sha256 "b069314e24eee081de6fe2a6d86e6c50017c4814622f3aba0f138149d5377a2d"

  url "https://github.com/mlaify/AttackMap-mac/releases/download/v#{version}/AttackMap-#{version}.dmg"
  name "AttackMap"
  desc "GUI for the AttackMap defensive security analyzer"
  homepage "https://github.com/mlaify/AttackMap-mac"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app drives the `attackmap` CLI and does not bundle it. CLILocator finds
  # it in $(brew --prefix)/bin.
  depends_on formula: "mlaify/tap/attackmap"
  depends_on macos: :sequoia

  app "AttackMap.app"

  uninstall quit: "io.mlaify.AttackMap"

  zap trash: [
    "~/Library/Application Support/io.mlaify.AttackMap",
    "~/Library/Caches/io.mlaify.AttackMap",
    "~/Library/Preferences/io.mlaify.AttackMap.plist",
    "~/Library/Saved Application State/io.mlaify.AttackMap.savedState",
  ]
end
