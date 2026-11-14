# AttackMap: defensive security analyzer for codebases.
#
# Installed from the GitHub release tarball (AttackMap is not on PyPI) into a
# Homebrew-managed virtualenv. Third-party Python deps come from PyPI sdists,
# pinned by sha256. The 15 official analyzer plugins are pinned to the same
# commits as src/attackmap/plugins_lock.py at this tag, fetched as GitHub
# archive tarballs (scripts/plugin_resources.py regenerates them).
class Attackmap < Formula
  include Language::Python::Virtualenv

  desc "Defensive security analyzer that maps a codebase's attack surface"
  homepage "https://github.com/mlaify/AttackMap"
  url "https://github.com/mlaify/AttackMap/archive/refs/tags/v0.6.4.tar.gz"
  sha256 "e550adfc45656d15df80e4c8c6abd116313526f81faab2fd79a492747d92e575"
  license "MIT"
  head "https://github.com/mlaify/AttackMap.git", branch: "main"

  # AttackMap tags releases without publishing GitHub Releases, so check tags.
  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "libyaml"
  # homebrew-core's bottled `pydantic` formula provides pydantic, pydantic-core,
  # annotated-types, typing-extensions and typing-inspection for python@3.14;
  # Homebrew's virtualenv picks it up through homebrew_deps.pth. Vendoring
  # pydantic-core as a resource instead means a Rust build on every install
  # (`depends_on "rust" => :build`), because Homebrew builds resources from
  # source (pip --no-binary=:all:) and this tap ships no bottles.
  depends_on "pydantic"
  depends_on "python@3.14"

  # BEGIN pypi resources: regenerate with
  #   brew update-python-resources --package-name attackmap --ignore-non-pypi-packages \
  #     --exclude-packages pydantic,pydantic-core,annotated-types,typing-extensions,typing-inspection \
  #     --print-only mlaify/tap/attackmap   (then paste between these markers)
  resource "annotated-doc" do
    url "https://files.pythonhosted.org/packages/5a/8e/38aa427ed5402449e226975b649c5dc73ccadfefeb95e6aecb8f8ea4b6b6/annotated_doc-0.0.5.tar.gz"
    sha256 "c7e58ce09192557605d8bbd92836d7e1d520ac9580096042c0bfd197efacf1bb"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/06/ff/7841249c247aa650a76b9ee4bbaeae59370dc8bfd2f6c01f3630c35eb134/markdown_it_py-4.2.0.tar.gz"
    sha256 "04a21681d6fbb623de53f6f364d352309d4094dd4194040a10fd51833e418d49"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "networkx" do
    url "https://files.pythonhosted.org/packages/dc/76/3af777226b63a5e64a6b36b1ec5855c14e2b94a37096d4760e595fc43511/networkx-3.7.tar.gz"
    sha256 "fd77a511bd90f39f3d016351345b52cf5319b813bdca01de3f755d3cca62e96a"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/49/2e/ced460408999b33da6b31b0021b0f37d329e202d4169aeb164493778f25b/pygments-2.21.0.tar.gz"
    sha256 "610ca751c9bc2492b38eb9a38a7fbc93edbbb2d7182edaf34e66ae493dee5c8c"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2/pyyaml-6.0.3.tar.gz"
    sha256 "d76623373421df22fb4cf8817020cbb7ef15c725b9d5e45f17e189bfc384190f"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/c0/8f/0722ca900cc807c13a6a0c696dacf35430f72e0ec571c4275d2371fca3e9/rich-15.0.0.tar.gz"
    sha256 "edd07a4824c6b40189fb7ac9bc4c52536e9780fbbfbddf6f1e2502c31b068c36"
  end

  resource "shellingham" do
    url "https://files.pythonhosted.org/packages/58/15/8b3609fd3830ef7b27b655beb4b4e9c62313a4e8da8c676e142cc210d58e/shellingham-1.5.4.tar.gz"
    sha256 "8dbca0739d487e5bd35ab3ca4b36e11c4078f3a234bfce294b0a0291363404de"
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/03/51/d33db42cc72ffd8c30777547b42d01f0cbf9d95a770457698d0174b3ed71/typer-0.27.3.tar.gz"
    sha256 "d0396f770a560ab1b0a8504e13b5f254b728cedb05c61cf0359e944e50ce8901"
  end
  # END pypi resources

  # BEGIN analyzer plugins: scripts/plugin_resources.py v<version>
  resource "attackmap-analyzer-atproto" do
    url "https://github.com/mlaify/attackmap-analyzer-atproto/archive/34b7616d5428549d39848dc4db1af7a71d6e0b56.tar.gz"
    version "0.2.0"
    sha256 "b51cb7eb5b6b93929d6905ec5d0004e1679bc9b62c4b5c231ad187a222b2a881"
  end

  resource "attackmap-analyzer-c" do
    url "https://github.com/mlaify/attackmap-analyzer-c/archive/00f7615a75df47e4ea1a084af562b4cf2e037ef1.tar.gz"
    version "0.2.0"
    sha256 "29b1cd7b69b37c3c551fb62763950c2a0fb12fbd7066c0d03d2bb8e12f893715"
  end

  resource "attackmap-analyzer-cpp" do
    url "https://github.com/mlaify/attackmap-analyzer-cpp/archive/cae9511e8db3ae192af9189a5d15d889e7fd18a8.tar.gz"
    version "0.2.0"
    sha256 "1efab6c91cffd620616daa2dfbe651b1eceb78b376d96a81eb4e7927fa264957"
  end

  resource "attackmap-analyzer-dotnet" do
    url "https://github.com/mlaify/attackmap-analyzer-dotnet/archive/fd08a2899f81c7173e257e892fb3914704244f3d.tar.gz"
    version "0.2.0"
    sha256 "af2a3a1baaeb034c739eee9ea112bb24ededb56d56655e191717ededf3e30e98"
  end

  resource "attackmap-analyzer-go" do
    url "https://github.com/mlaify/attackmap-analyzer-go/archive/8570338fc67198770b3185633bb0fc35d7db5deb.tar.gz"
    version "0.2.0"
    sha256 "cde64307a29a05ad08fedf17fa033e9c81b1fcc40a2cc7e0d2837b604f2d6f8c"
  end

  resource "attackmap-analyzer-iac" do
    url "https://github.com/mlaify/attackmap-analyzer-iac/archive/ef7811cb500b40535740fc104a3d2b29ef627141.tar.gz"
    version "0.2.0"
    sha256 "15d154751cbec39c028aef9a2f557ff2c91919fffdc646d2f564abec27b42267"
  end

  resource "attackmap-analyzer-java-spring" do
    url "https://github.com/mlaify/attackmap-analyzer-java-spring/archive/82e23461f6c075d17a709c29c9349a1076d1bafa.tar.gz"
    version "0.2.0"
    sha256 "76cdf359d39263c798109e63f31b5d994d13dcfa56c279b0e2cb3979bc5bba6d"
  end

  resource "attackmap-analyzer-node-service" do
    url "https://github.com/mlaify/attackmap-analyzer-node-service/archive/949269777c020e7a6265fb1436cf1be2fe5004be.tar.gz"
    version "0.3.0"
    sha256 "ffd16b8c4162dbefd5e4696895842ff4c4eb5a0386570c98e1f60afa8769eec1"
  end

  resource "attackmap-analyzer-omeka-s" do
    url "https://github.com/mlaify/attackmap-analyzer-omeka-s/archive/9759c163e30c35256558188cff30dc1cf1331cd5.tar.gz"
    version "0.2.0"
    sha256 "74c98a6a88f3d9d2da3a3ec8fb540695f91bfd4836d60da87f46202c1f97f6ba"
  end

  resource "attackmap-analyzer-php-laminas" do
    url "https://github.com/mlaify/attackmap-analyzer-php-laminas/archive/9046ff6256338850574ee781b69bd2e3f09d2ab2.tar.gz"
    version "0.2.0"
    sha256 "a24d8731b9258c7bc258ddc84d6f2484817749697fbc2721c29195da5b2fdc7f"
  end

  resource "attackmap-analyzer-php-web" do
    url "https://github.com/mlaify/attackmap-analyzer-php-web/archive/65a5f098c40ae64d3ec3b5d20777eac640fb743b.tar.gz"
    version "0.2.0"
    sha256 "2422799399187782c8d3c91e649853677c1f831bbc007c394fc93f9b2d00aedc"
  end

  resource "attackmap-analyzer-python" do
    url "https://github.com/mlaify/attackmap-analyzer-python/archive/9888be5c8f8e9127686e0ed98af9425a34bc7b8c.tar.gz"
    version "0.2.0"
    sha256 "515613471220fdf55ae70d976d3a058a965926a8fdf6f464e42054b0f89a0c37"
  end

  resource "attackmap-analyzer-rust" do
    url "https://github.com/mlaify/attackmap-analyzer-rust/archive/ba6cce7ec1b8055b27c3aa2ddd8884ae410b8ba0.tar.gz"
    version "0.2.0"
    sha256 "2ff6b4c778affd121a419ff3b3c898f8bfedca99e71ec3108b9efd10017a3e71"
  end

  resource "attackmap-analyzer-swift" do
    url "https://github.com/mlaify/attackmap-analyzer-swift/archive/eb56ca09c642e580c5cd73391d602f555d429a4b.tar.gz"
    version "0.2.0"
    sha256 "1903a07e0f2411f6768e43712cc984bf676f3cd34df2a0dd1813b02b783235f6"
  end

  resource "attackmap-analyzer-terraform" do
    url "https://github.com/mlaify/attackmap-analyzer-terraform/archive/1dfbce9a32c9a2fd6fc1b80f976ea86f69d82cd1.tar.gz"
    version "0.2.1"
    sha256 "e2b14d653eb568ea875c8166fae98831fa5a77284ae4514362f0cc730efd1a95"
  end
  # END analyzer plugins

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      All 15 official analyzer plugins are installed at their pinned commits, so
      `attackmap -m <name> --install-missing` is not needed. It would write into
      the Homebrew keg, and `brew upgrade` would discard it.

      LLM modes (--llm/--hunt/--remediate/--triage) use the `claude` or `codex`
      CLI if it is on PATH. The anthropic/openai Python SDKs are not bundled.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/attackmap --version")

    modules = shell_output("#{bin}/attackmap modules --json")
    assert_match "\"python\"", modules
    assert_match "\"go\"", modules

    (testpath/"app/app.py").write <<~PY
      from flask import Flask, request
      import subprocess
      app = Flask(__name__)

      @app.route("/run")
      def run():
          return subprocess.check_output(request.args["cmd"], shell=True)
    PY
    system bin/"attackmap", "analyze", testpath/"app", "--format", "json",
           "--output", testpath/"out", "--no-progress"
    assert_path_exists testpath/"out/attackmap-report.json"
    assert_match "\"findings\"", (testpath/"out/attackmap-report.json").read
  end
end
