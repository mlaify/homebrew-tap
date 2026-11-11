cask "attackmap-app" do
  version "0.3.1"
  sha256 "96a546d8d44f0caf7a783fff779dd1b10c46c019f2e15c872626097afb741b8d"

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
