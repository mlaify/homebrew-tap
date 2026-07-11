cask "attackmap-app" do
  version "0.1.0"
  sha256 "c35434bd602aa7873c66178ae6ee19f4d92ad4365deb69d793179c134615b16d"

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
