cask "attackmap-app" do
  version "1.0.0"
  sha256 "1bcda01fcb96b9e36e8c5996904bdb3212ce465f292567b3a03bf4e4b26b4130"

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
