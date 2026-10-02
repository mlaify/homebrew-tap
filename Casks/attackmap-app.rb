cask "attackmap-app" do
  version "0.2.3"
  sha256 "4c1d95ea2310429dce695a10db3199914c7324d362513c879634980537faffd8"

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
