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
  url "https://github.com/mlaify/AttackMap/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "df911b49f9639a3e051de2cc9e4ea5aa26f51cfbc893f5f3e7c6212b72976cb3"
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
    url "https://github.com/mlaify/attackmap-analyzer-atproto/archive/d2cb6ed6d5e69adf929a1fd7f66947830ecfd5fc.tar.gz"
    version "0.1.0"
    sha256 "30ccdaa55bba80def26ac0a65f0f4e9b0e6ae69e020f6a9e5ac90a927551d008"
  end

  resource "attackmap-analyzer-c" do
    url "https://github.com/mlaify/attackmap-analyzer-c/archive/1c2789ef62e57b713789f483b9409a5c64644795.tar.gz"
    version "0.1.0"
    sha256 "e2a743263716dd2e4c23e675d10a9ffa5c7f4ad5831d644b411ab29e8eaf876f"
  end

  resource "attackmap-analyzer-cpp" do
    url "https://github.com/mlaify/attackmap-analyzer-cpp/archive/61fa5325696620665bf9ceab10ec7bed378888ec.tar.gz"
    version "0.1.0"
    sha256 "0416c27b791c009f84ea3a36dd835e9351cff04b996ae3e9241543cbc70da6a3"
  end

  resource "attackmap-analyzer-dotnet" do
    url "https://github.com/mlaify/attackmap-analyzer-dotnet/archive/a1f00d05bc915940ed684f438c678e696f3de53d.tar.gz"
    version "0.1.0"
    sha256 "e3e586211b62e3bb13ecbac7be2fab1be69e3155898aefb7cac0e40a18f70482"
  end

  resource "attackmap-analyzer-go" do
    url "https://github.com/mlaify/attackmap-analyzer-go/archive/e92fc3de5c34485c4ea06032052ad0f6c21fd133.tar.gz"
    version "0.1.0"
    sha256 "38ee1e1858c92f212f090533345839d6980864dc0ccf699bfb52b84ca02c73b7"
  end

  resource "attackmap-analyzer-iac" do
    url "https://github.com/mlaify/attackmap-analyzer-iac/archive/002efc484fc26ead1243aa34b610ccb2230147b0.tar.gz"
    version "0.1.0"
    sha256 "cfeabd6e61de78ecc9c1ebe505e6c0cd711e8cb3c0b64d0a3d49b12adc0f931d"
  end

  resource "attackmap-analyzer-java-spring" do
    url "https://github.com/mlaify/attackmap-analyzer-java-spring/archive/98dec01669ca90216cea4559495ee310224fd8f3.tar.gz"
    version "0.1.0"
    sha256 "1c5e23b03b4779abf102a280d63b4a17afcefe2ae49437a8b02cb38429d7b139"
  end

  resource "attackmap-analyzer-node-service" do
    url "https://github.com/mlaify/attackmap-analyzer-node-service/archive/8573b4a8dcefda5518a771c1a84be93b2eb9be05.tar.gz"
    version "0.2.0"
    sha256 "2973ff8ae237328bd52646c1b0ac297a10cb3db1232fd12b82d9353ef07d493e"
  end

  resource "attackmap-analyzer-omeka-s" do
    url "https://github.com/mlaify/attack-map-analyzer-omeka-s/archive/6b9e478689a825dbcba655de4ff0bf63a3a3c544.tar.gz"
    version "0.1.0"
    sha256 "dd13bdfcee10d1e502a77cac632463a1346275d9bb45d1dc46aa88b85a3f7186"
  end

  resource "attackmap-analyzer-php-laminas" do
    url "https://github.com/mlaify/attackmap-analyzer-php-laminas/archive/7eac668b6f64a1d3fc3fa731317cb253a98915ce.tar.gz"
    version "0.1.0"
    sha256 "f492ac757c6b3fded123a3e69b9882997d2522eb3da2c265b4b319e6392b887b"
  end

  resource "attackmap-analyzer-php-web" do
    url "https://github.com/mlaify/attackmap-analyzer-php-web/archive/69143bd994ec9111cffc2f78d4020bad611e68c7.tar.gz"
    version "0.1.0"
    sha256 "bbf98028d339eccc324870098bea6c6cf449ca43908b3e7238d944c9450afa0d"
  end

  resource "attackmap-analyzer-python" do
    url "https://github.com/mlaify/attackmap-analyzer-python/archive/1bcce0dd5d639cb83ada65cc3f5024bb5a1d9782.tar.gz"
    version "0.1.0"
    sha256 "79ec007464b167527e9477a47dfb737bc1cbacb8eb00b09b644ce215a08a2b15"
  end

  resource "attackmap-analyzer-rust" do
    url "https://github.com/mlaify/attackmap-analyzer-rust/archive/c2e02d2855e6102153140f2644504b1cc0a95fb8.tar.gz"
    version "0.1.0"
    sha256 "19866300ae184a1a8ffdf846f98d5604f7e417b18cb71705293a48947610d58c"
  end

  resource "attackmap-analyzer-swift" do
    url "https://github.com/mlaify/attackmap-analyzer-swift/archive/bae13e58a49f46c15992197517cf9c036a75d83c.tar.gz"
    version "0.1.0"
    sha256 "ec52206392aae543255601f428ba39323b90849c33657cba8eb94828fb3109ac"
  end

  resource "attackmap-analyzer-terraform" do
    url "https://github.com/mlaify/attackmap-analyzer-terraform/archive/736f2c22051ffca537785edebf941a2d5ddb2487.tar.gz"
    version "0.1.0"
    sha256 "0ad7cfb79f16ce9b3b8f8f3df8812d90e911008954632f76e65156db6032cdaf"
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
