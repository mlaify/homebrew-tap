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
  url "https://github.com/mlaify/AttackMap/archive/refs/tags/v0.6.5.tar.gz"
  sha256 "6b78ae4c854ff02198e75e4929c1b74b0e50b6998d04ad181649847e5b3155e2"
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
    url "https://github.com/mlaify/attackmap-analyzer-atproto/archive/d94f7ab3673cb062f1f2d6d731abb03cea8a2034.tar.gz"
    version "0.2.1"
    sha256 "ba86abe556bc7c37ad0cfebc9f8ee69bb44eb76a97c0be4fcd191b78e5f92681"
  end

  resource "attackmap-analyzer-c" do
    url "https://github.com/mlaify/attackmap-analyzer-c/archive/e6abfcb8634826347243ecb477f7c63b2cbdb337.tar.gz"
    version "0.2.1"
    sha256 "c314b59f2ed13a7e6093d85ee762b1ab980d5ed577c0a8c7f028f78925332a1b"
  end

  resource "attackmap-analyzer-cpp" do
    url "https://github.com/mlaify/attackmap-analyzer-cpp/archive/4d9d98edbb3ef03f7d9fa27fd4437b2c4002d7af.tar.gz"
    version "0.2.1"
    sha256 "a046f82ac80c89f579b0b40992a17c65257e849cedf1c46081fe571f2816dc84"
  end

  resource "attackmap-analyzer-dotnet" do
    url "https://github.com/mlaify/attackmap-analyzer-dotnet/archive/d940638fafde355ff4a0c22439389baefc3003c8.tar.gz"
    version "0.2.1"
    sha256 "d09d35896d2156cc74561918c5fe80b227e95600b54957b3f9d9e52f51904332"
  end

  resource "attackmap-analyzer-go" do
    url "https://github.com/mlaify/attackmap-analyzer-go/archive/64b425f9b14c97705173b9543ea21d4f612e98a3.tar.gz"
    version "0.2.1"
    sha256 "30729422fe06efca2dbf78d123277514e1a74a7c9a1df60ce07c0a1e1c394d37"
  end

  resource "attackmap-analyzer-iac" do
    url "https://github.com/mlaify/attackmap-analyzer-iac/archive/6e598f7a783aab4cdc0defa6ec2f9016fc6b0643.tar.gz"
    version "0.2.1"
    sha256 "df604a209971227646e7c193bde2b7d71487c6c960eb7274289c18942e252c0d"
  end

  resource "attackmap-analyzer-java-spring" do
    url "https://github.com/mlaify/attackmap-analyzer-java-spring/archive/3aa4290f109f6de86049d81d8637040abdb3a789.tar.gz"
    version "0.2.1"
    sha256 "2abd3e02c6beaec7d6b578d4f211fbd70cf98318b5c708882d89aedb97a8af37"
  end

  resource "attackmap-analyzer-node-service" do
    url "https://github.com/mlaify/attackmap-analyzer-node-service/archive/744101eeb9d1b4eae0c8e718e5af531ea33872af.tar.gz"
    version "0.3.1"
    sha256 "effe000ad592dd0bdb4db29646d7b72bd1329bad30a753a1095db5911b7b5653"
  end

  resource "attackmap-analyzer-omeka-s" do
    url "https://github.com/mlaify/attackmap-analyzer-omeka-s/archive/becc3f86a516d43036e3e42d72bcde4bbac85176.tar.gz"
    version "0.2.1"
    sha256 "7a0d884f0254ed1a350be048bbe18dbfc9eb395ca99f781a38b000627ff1697e"
  end

  resource "attackmap-analyzer-php-laminas" do
    url "https://github.com/mlaify/attackmap-analyzer-php-laminas/archive/7a0b3945470eece08ce36f2821ff25765a113b4f.tar.gz"
    version "0.2.1"
    sha256 "c48ea8591d46f0febf18c2465b3da262c890bc5c6245617ebc0252aa2034234f"
  end

  resource "attackmap-analyzer-php-web" do
    url "https://github.com/mlaify/attackmap-analyzer-php-web/archive/bcae04c48f3f4bb359b3cb68d93521f277b939ab.tar.gz"
    version "0.2.1"
    sha256 "22adcee1e9f0b0edf0b32d50aaa649233bb5556f3c632a3d175b126d7ce73ad6"
  end

  resource "attackmap-analyzer-python" do
    url "https://github.com/mlaify/attackmap-analyzer-python/archive/280cb9ca851d467de4d28a1f0d89a92388b956f8.tar.gz"
    version "0.2.1"
    sha256 "7d5fcd749e2ddaab16f7078a6be6aacf6d1c186d1b972cd954a3d610c1920276"
  end

  resource "attackmap-analyzer-rust" do
    url "https://github.com/mlaify/attackmap-analyzer-rust/archive/6da4016f8826c6634fdc025145308ce0b06390b2.tar.gz"
    version "0.2.1"
    sha256 "e6efda3bab3845710caf0124682ad10f656176b5d5d8c781351f601f4ce9c92a"
  end

  resource "attackmap-analyzer-swift" do
    url "https://github.com/mlaify/attackmap-analyzer-swift/archive/7e7808d3575f50fdc2106a793011825672e5326f.tar.gz"
    version "0.2.1"
    sha256 "f1db2a8ada3c3a41c84d7708dd3adc2da46c7d520a6513478c025228a96bd407"
  end

  resource "attackmap-analyzer-terraform" do
    url "https://github.com/mlaify/attackmap-analyzer-terraform/archive/8856e56969e8e4ace98a0a395417fa5899a71151.tar.gz"
    version "0.2.2"
    sha256 "063b378a36ad68e51cba0bf30b09bfcc84edeb12b266ca3b9d2999c12fc4f8fe"
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
