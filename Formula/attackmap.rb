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
  url "https://github.com/mlaify/AttackMap/archive/refs/tags/v0.6.3.tar.gz"
  sha256 "d92a55a4092486dc52bbfe482e3a0c4c338e5b3859b560858f1d32014ebd8a97"
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
    url "https://github.com/mlaify/attackmap-analyzer-atproto/archive/71f4ab223f8c16118282268fdd7bf0f4d4d8f0b3.tar.gz"
    version "0.2.0"
    sha256 "14debcd3973fc0ba0a64e9ea4ae2578fa16dbb766a3fe46fe6342eba5d1741db"
  end

  resource "attackmap-analyzer-c" do
    url "https://github.com/mlaify/attackmap-analyzer-c/archive/a36b9ad3cfea5c17c1e556803923df3aac4e0fe8.tar.gz"
    version "0.2.0"
    sha256 "fb39f26e53f62a3782e7a99205051ff55957adfa00fadcee8b38e8070298c371"
  end

  resource "attackmap-analyzer-cpp" do
    url "https://github.com/mlaify/attackmap-analyzer-cpp/archive/2529dd8c81056301796a1033ff48b4059ab54d2e.tar.gz"
    version "0.2.0"
    sha256 "d9d716f1563950fe0ec6565ffb5a0a6eb008e5d4a241927699fe4c66a8e2ef7d"
  end

  resource "attackmap-analyzer-dotnet" do
    url "https://github.com/mlaify/attackmap-analyzer-dotnet/archive/c7e538609728fac3be5b9e9d396b1a4a8613ebd1.tar.gz"
    version "0.2.0"
    sha256 "39a8cb4afec6c3bc5e011d1a826f6f88dd1a6628304b877d49a56347ea8a1d25"
  end

  resource "attackmap-analyzer-go" do
    url "https://github.com/mlaify/attackmap-analyzer-go/archive/6c67c751f56be6a736cdcecdd290cbf0071750e0.tar.gz"
    version "0.2.0"
    sha256 "042719d54c8221dc3c4b3bb93aab355ba1bb51976dcc40a6e4aeac58738573e9"
  end

  resource "attackmap-analyzer-iac" do
    url "https://github.com/mlaify/attackmap-analyzer-iac/archive/2897b1d1c48f6f778759b876ad5f7a23fcc04cd1.tar.gz"
    version "0.2.0"
    sha256 "f8a2fc474b8e4eead13cfb0fb4b39e235bcee4adfa8e0a1a7b9d33106a83757c"
  end

  resource "attackmap-analyzer-java-spring" do
    url "https://github.com/mlaify/attackmap-analyzer-java-spring/archive/969de3ee93a1ce62844321fa92a1c94571154622.tar.gz"
    version "0.2.0"
    sha256 "3db7cbe13465f943757553fc2fd4efde1bf49fae142bcb51f53370d1c6af7ec8"
  end

  resource "attackmap-analyzer-node-service" do
    url "https://github.com/mlaify/attackmap-analyzer-node-service/archive/432f64aeb1e55cf0f5030af2be16220a6e991e50.tar.gz"
    version "0.3.0"
    sha256 "e26392438440610198fb8e0951a63afa1d260ea2519d55ed098ce610bc32c98d"
  end

  resource "attackmap-analyzer-omeka-s" do
    url "https://github.com/mlaify/attackmap-analyzer-omeka-s/archive/c8698bc463f4941fb9cc9c28a0288a03d1c1892d.tar.gz"
    version "0.2.0"
    sha256 "8a1453e07832fc4720a1f765aaea463dc4d9c462536d0b2f5093c604bd69ba31"
  end

  resource "attackmap-analyzer-php-laminas" do
    url "https://github.com/mlaify/attackmap-analyzer-php-laminas/archive/9780fe93f7341a8411ffa88a564e063290ecbf18.tar.gz"
    version "0.2.0"
    sha256 "71a021bf8a74b95ee25969138062cadc5cd95e9101ff895f25b08ebc6a957d79"
  end

  resource "attackmap-analyzer-php-web" do
    url "https://github.com/mlaify/attackmap-analyzer-php-web/archive/e4c095f0e9ebf986014762f124943dec908d0951.tar.gz"
    version "0.2.0"
    sha256 "260711206e4e821eb4f60af00d4442aa3b1a04593ceba3af3184cb23acc199c3"
  end

  resource "attackmap-analyzer-python" do
    url "https://github.com/mlaify/attackmap-analyzer-python/archive/149aaba697212b4866ad3660999a4e12ea75b9c9.tar.gz"
    version "0.2.0"
    sha256 "eebfe05b07c3bf4429ae1bbf8cb1f06bc05700183d55360625fa2c7be931af62"
  end

  resource "attackmap-analyzer-rust" do
    url "https://github.com/mlaify/attackmap-analyzer-rust/archive/8699781affb47f2a55461e2e02847dffb4c2c272.tar.gz"
    version "0.2.0"
    sha256 "5de39df9b4c321bb5a3c8fbbec3cc2337b328b22d54548f9351b80087ca23c0a"
  end

  resource "attackmap-analyzer-swift" do
    url "https://github.com/mlaify/attackmap-analyzer-swift/archive/9a80ec2c3a3f4d3c3a01048592a19e287b16584e.tar.gz"
    version "0.2.0"
    sha256 "770705afe0b304d966dceed621af9b83134a4ac36a717701dc0067a722181e33"
  end

  resource "attackmap-analyzer-terraform" do
    url "https://github.com/mlaify/attackmap-analyzer-terraform/archive/d6df7d0a5358ada5f7247c8441e06b3d6fff1466.tar.gz"
    version "0.2.0"
    sha256 "f8e97baa32ffcb4529dc0dcbe0f7819a0be332f95f9b084dece2118f1649992d"
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
