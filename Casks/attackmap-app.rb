cask "attackmap-app" do
  version "0.1.1"
  sha256 "9f8c3006cacf762f182c344aaf2fee23f18798ac64d455393136ff4e011e3c14"

  url "https://github.com/mlaify/AttackMap-mac/releases/download/v#{version}/AttackMap-#{version}.dmg"
  name "AttackMap"
  desc "GUI for the AttackMap defensive security analyzer"
  homepage "https://github.com/mlaify/AttackMap-mac"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on formula: "mlaify/tap/attackmap"
  depends_on macos: :sequoia

  app "AttackMap.app"

  zap trash: [
    "~/Library/Application Support/io.mlaify.AttackMap",
    "~/Library/Caches/io.mlaify.AttackMap",
    "~/Library/Preferences/io.mlaify.AttackMap.plist",
  ]
end
