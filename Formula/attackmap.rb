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
  url "https://github.com/mlaify/AttackMap/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "359b2668dd03248e421bb8b91a6fb117d706ec99be6c1476d4b1eb8a9d410611"
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
    url "https://files.pythonhosted.org/packages/0b/7d/bdbf3062e5dae31da8b3de1e3269110beb93d268df4a7f6d22b167c6cee0/annotated_doc-0.0.7.tar.gz"
    sha256 "0a30ef8f5322a4173720ae6712dc9a5e58f5a19868f3f167b4b5778db066c2b5"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/16/fc/cee2c45553c9a9bf77d8b0c391560c556d7ed756b1f0bb35eb5d48db09ea/markdown_it_py-4.3.0.tar.gz"
    sha256 "91a58fa5b72c71a40cf7177250fd767480d7a2bb3ac426ccfb76fb90305fdaaa"
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
    url "https://files.pythonhosted.org/packages/76/b8/c0b780928e2fb1c87e9e375818c6f121da2398b071012d1747be300b83f4/pyyaml-6.0.4.tar.gz"
    sha256 "e24bf71af8a432d7808fabff134d38dfe16d3cbb41f2873bb4b1e42422de0a1a"
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
    url "https://files.pythonhosted.org/packages/bf/21/37383ece7d0a4995fb8ea97729207c4292b3ff94085002f37b2387063cfb/typer-0.29.2.tar.gz"
    sha256 "b1998dc5f2c3dedafa1517a9521fa944cc4dc1fadcea085d81a3b10ebcaeb075"
  end
  # END pypi resources

  # BEGIN analyzer plugins: scripts/plugin_resources.py v<version>
  resource "attackmap-analyzer-atproto" do
    url "https://github.com/mlaify/attackmap-analyzer-atproto/archive/721ec552b59eed837a482436d9cbcbd9d33d906f.tar.gz"
    version "0.3.0"
    sha256 "1728da5b1151cc52e46ddaa44125863124cadbee7d3aedab086193a5b48aac9b"
  end

  resource "attackmap-analyzer-c" do
    url "https://github.com/mlaify/attackmap-analyzer-c/archive/0d85ce1b3512749839c19573495b76a51c3de4de.tar.gz"
    version "0.3.0"
    sha256 "0d9db568dbb10e355daa65c053de2619e63fd4a2ae383e45bb0e56997388dda4"
  end

  resource "attackmap-analyzer-cpp" do
    url "https://github.com/mlaify/attackmap-analyzer-cpp/archive/06b0aeca702935df2b09038a6161c93fc11595d7.tar.gz"
    version "0.3.0"
    sha256 "6c83b4b7b22b6112ee11b97d9a0b8c1d58987bdf047f8e610b26047ef250c0b7"
  end

  resource "attackmap-analyzer-dotnet" do
    url "https://github.com/mlaify/attackmap-analyzer-dotnet/archive/f55fc4f7a450f0eeb935daf71c53539934d20232.tar.gz"
    version "0.3.0"
    sha256 "666fe445f6e7ddd38639b93a9827a7f576f45080d5810d5e8dccab028a168610"
  end

  resource "attackmap-analyzer-go" do
    url "https://github.com/mlaify/attackmap-analyzer-go/archive/57892a533255a49ee95e45cfdd0e1f79ad63df07.tar.gz"
    version "0.3.0"
    sha256 "deadc37d53651a068c04c4b89c74c4544c986afcac6309995ad9df79d0a01c01"
  end

  resource "attackmap-analyzer-iac" do
    url "https://github.com/mlaify/attackmap-analyzer-iac/archive/8d006399e78b30208bc697f671191fda1321e7ff.tar.gz"
    version "0.3.0"
    sha256 "a38b91bd2ea62030842f74fc9dfcb5ce5b0e98e5651d94ea8cfabd2331c2f277"
  end

  resource "attackmap-analyzer-java-spring" do
    url "https://github.com/mlaify/attackmap-analyzer-java-spring/archive/a44d349f8e4eb3547c84df7b08c6dd8cd2fddaeb.tar.gz"
    version "0.3.0"
    sha256 "32ea9dcd63cb3d15290815efa905a2a992ad4d7905b10ad79bc13e5c39d33487"
  end

  resource "attackmap-analyzer-node-service" do
    url "https://github.com/mlaify/attackmap-analyzer-node-service/archive/fcbfb6c18895e7543cfbc9f60940d0e0b33124e5.tar.gz"
    version "0.4.0"
    sha256 "38b0684977e1f0be86b2c0fb09b5076e6bf25cfad0301ef14298fa55f1e7373a"
  end

  resource "attackmap-analyzer-omeka-s" do
    url "https://github.com/mlaify/attackmap-analyzer-omeka-s/archive/112dccf4af112d297454695d16b1fbd126a58d85.tar.gz"
    version "0.3.0"
    sha256 "f844b0ebcb3cc65a220b98bb8b833a77d8a5b464f7f05c9be5a7d0826a86007f"
  end

  resource "attackmap-analyzer-php-laminas" do
    url "https://github.com/mlaify/attackmap-analyzer-php-laminas/archive/9bf16704e905bcd637bbf6addae7325fbf43acc7.tar.gz"
    version "0.3.0"
    sha256 "d7a02cba52a09231e1eb08dd90fadfc8ec5cf4800092b3ee6ee8860efadebaf7"
  end

  resource "attackmap-analyzer-php-web" do
    url "https://github.com/mlaify/attackmap-analyzer-php-web/archive/905e10b57d4222cb47ad8dec0bde7e40f3f1d2a3.tar.gz"
    version "0.3.0"
    sha256 "c46a6f9b1d194ca15c4947ececb64b37d1f17764eac2022249e669a10a75d6cc"
  end

  resource "attackmap-analyzer-python" do
    url "https://github.com/mlaify/attackmap-analyzer-python/archive/e2362c7184f2990a4947ed92f63f7d30bfe5b854.tar.gz"
    version "0.3.0"
    sha256 "050a8f486038971f763c338fd3db779d9bbf9869343e74b7f8447d07c0a8a6c8"
  end

  resource "attackmap-analyzer-rust" do
    url "https://github.com/mlaify/attackmap-analyzer-rust/archive/09650602e1a01f5f87320962320d70d18c522df2.tar.gz"
    version "0.3.0"
    sha256 "72ffc4dae5d931cf3d43bd7d15c13b2cc509aa72c88d7ba6161d1aa0aa9d0979"
  end

  resource "attackmap-analyzer-swift" do
    url "https://github.com/mlaify/attackmap-analyzer-swift/archive/f6fd441db03398e6d9a63a390f7a1003e10d23aa.tar.gz"
    version "0.3.0"
    sha256 "29388bcd8d2bed5f15f0cd3f7da74ef540bb67fa47f54ead8b26cc5c5b16f76d"
  end

  resource "attackmap-analyzer-terraform" do
    url "https://github.com/mlaify/attackmap-analyzer-terraform/archive/0423498276c6d50e64fa7fb77ef3acd6daccd80c.tar.gz"
    version "0.4.0"
    sha256 "a6f0d4b5803bbff0a9abcec5c6f1f11342f5333bbd6d1abe21c05adec1fb9b50"
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
