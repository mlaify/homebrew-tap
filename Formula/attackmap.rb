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
  url "https://github.com/mlaify/AttackMap/archive/refs/tags/v0.4.31.tar.gz"
  sha256 "265e93017ded841282ce9e3cff756291605d8b65470589439f77c12e9a6cbb58"
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
    url "https://files.pythonhosted.org/packages/16/f7/57713ba479fd405eb76de31404b2c744c289e336b2d999511ebf51e496f7/typer-0.27.2.tar.gz"
    sha256 "269b7eb9d3c202ca84b4bc9618cb04ebb43d3d4d1e567e4c768607232c05f945"
  end
  # END pypi resources

  # BEGIN analyzer plugins: scripts/plugin_resources.py v<version>
  resource "attackmap-analyzer-atproto" do
    url "https://github.com/mlaify/attackmap-analyzer-atproto/archive/5aeee5bb231cc2720bba384214da62e70af670cb.tar.gz"
    version "0.1.0"
    sha256 "4a8263c36850a285cca93a2f470a024511c46292adc4e30456332873cbfe1d10"
  end

  resource "attackmap-analyzer-c" do
    url "https://github.com/mlaify/attackmap-analyzer-c/archive/bd1a1806b80f0f824befdd00bca992407e76a34b.tar.gz"
    version "0.1.0"
    sha256 "15c537371e51da820d52649dfb818e55c9404cf079ae4a0d44b6cb4bd9d71b55"
  end

  resource "attackmap-analyzer-cpp" do
    url "https://github.com/mlaify/attackmap-analyzer-cpp/archive/24388da39c95b562bb9bccbf483e20a162d7055f.tar.gz"
    version "0.1.0"
    sha256 "23e82e63e908edb92f2cd3b472443674aa34d4073f0f8024ac5bb9ed7d6fc390"
  end

  resource "attackmap-analyzer-dotnet" do
    url "https://github.com/mlaify/attackmap-analyzer-dotnet/archive/1196bbfe2cccde448f9da639c2ce5595c3dd5aba.tar.gz"
    version "0.1.0"
    sha256 "4ce79724bc63a71a26514370c71cc39ffd8617d69f20d7196096d3c41bc7d090"
  end

  resource "attackmap-analyzer-go" do
    url "https://github.com/mlaify/attackmap-analyzer-go/archive/19e4d5981fb286ff8a6029a8f7f3b31e41ee3a34.tar.gz"
    version "0.1.0"
    sha256 "86fba7693dd36e7556a68394f2090ece462685f5b97ec44e37c7b487e91f4d5d"
  end

  resource "attackmap-analyzer-iac" do
    url "https://github.com/mlaify/attackmap-analyzer-iac/archive/4b3d60aa349f37b67b83418ec0841675cf492fb9.tar.gz"
    version "0.1.0"
    sha256 "f558d9787463c91718338e1e56464412f400139a0f3a259f237bda5ee2ebe047"
  end

  resource "attackmap-analyzer-java-spring" do
    url "https://github.com/mlaify/attackmap-analyzer-java-spring/archive/958010d1245988de530131b5596b5f9809420597.tar.gz"
    version "0.1.0"
    sha256 "0c67d37a9a2be0ca91a1091b45e16b8b5a7551a3d5589b41031bee46837d3b66"
  end

  resource "attackmap-analyzer-node-service" do
    url "https://github.com/mlaify/attackmap-analyzer-node-service/archive/05638b5ac192bfd8249bd5199e2256171aafa32d.tar.gz"
    version "0.2.0"
    sha256 "9cc7092c3e5e80e9351993344ff0c0b691928f1fef09599f0105ff6e52e662f1"
  end

  resource "attackmap-analyzer-omeka-s" do
    url "https://github.com/mlaify/attack-map-analyzer-omeka-s/archive/9a7a820eea0ec1b6bd7680291f53aefa76256e13.tar.gz"
    version "0.1.0"
    sha256 "74ba1b6d5b2f496904394f7719e10f653886ca379b00c6f769518adf4f85c631"
  end

  resource "attackmap-analyzer-php-laminas" do
    url "https://github.com/mlaify/attackmap-analyzer-php-laminas/archive/0c53f2542d7878a09b5291949b3a3be404c3f6db.tar.gz"
    version "0.1.0"
    sha256 "c1c8426ab26b3d53dba7bb775a6d2b4f774665ac97a8e06eb90c72bd7834036e"
  end

  resource "attackmap-analyzer-php-web" do
    url "https://github.com/mlaify/attackmap-analyzer-php-web/archive/732a7cb276b8e6503a0bfd064b1f9610924217e8.tar.gz"
    version "0.1.0"
    sha256 "f91d626d2c9bcb8a341658199c6883e2e02d9e79f83362cc5b0ebd5f86522fde"
  end

  resource "attackmap-analyzer-python" do
    url "https://github.com/mlaify/attackmap-analyzer-python/archive/44ff509870de88512f37f080930dd2f2d4df3858.tar.gz"
    version "0.1.0"
    sha256 "767391790c82a9d8d642a51bc45a9ed317f34abd70d83572a38a08220ae4730e"
  end

  resource "attackmap-analyzer-rust" do
    url "https://github.com/mlaify/attackmap-analyzer-rust/archive/884335b044d50677ee7ebc0b5d7bf1e6f79ca8d8.tar.gz"
    version "0.1.0"
    sha256 "14008fec2c1c269561f713260488ad5f8450b077da0d690eafb31e912173c6d3"
  end

  resource "attackmap-analyzer-swift" do
    url "https://github.com/mlaify/attackmap-analyzer-swift/archive/07344c54be7042a24145803729e6ae2548476f96.tar.gz"
    version "0.1.0"
    sha256 "4b315132c17b4b3ad275aef0672892c9792bcb9dfa8073124ef3f52313d542be"
  end

  resource "attackmap-analyzer-terraform" do
    url "https://github.com/mlaify/attackmap-analyzer-terraform/archive/6ea7d52e9fabb85ad0ef4b4dea31d5702c8cc677.tar.gz"
    version "0.1.0"
    sha256 "5c990fe439889adc6607aec46b9ae6099a31ae4cdf2ff76dbb80f55966d09d5e"
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
