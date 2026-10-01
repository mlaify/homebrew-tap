cask "attackmap-app" do
  # Bump to the release that requests `--format all` (AttackMap-mac 42bc8e2,
  # first shipped in v0.2.2) before announcing this cask. v0.2.1 still runs
  # against attackmap >= 0.4.30, but its Diagrams view comes up empty because
  # it asks for `--format json` only.
  version "0.2.1"
  sha256 "dbb36ec99d99880fea2f2105e3eba40fc6be70bf2be838bf593b804e8c05dc2f"

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
