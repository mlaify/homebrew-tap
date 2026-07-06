# typed: false
# frozen_string_literal: true

# AttackMap — AI-assisted defensive security analyzer for codebases.
# Homepage: https://github.com/mlaify/AttackMap
#
# This formula installs `attackmap` into a Homebrew-managed virtualenv with
# every official analyzer plugin pinned by sha256 via `resource` blocks.
# Regenerate after every release with `scripts/regenerate.sh <version>`.
class Attackmap < Formula
  include Language::Python::Virtualenv

  desc "AI-assisted defensive security analyzer for codebases"
  homepage "https://github.com/mlaify/AttackMap"
  # BEGIN sdist: managed by scripts/regenerate.sh — do not edit by hand
  url "https://files.pythonhosted.org/packages/09/11/ad11b52e6b185cf9255198ff07ba912adb88a656b438b3c18cefb11eb55c/attackmap-0.3.2.tar.gz"
  sha256 "3ed178c59e8cb3e54ed027758d979a8f26cc8e0bae9e743f9b8ce7888303f11b"
  # END sdist
  license "MIT"
  head "https://github.com/mlaify/AttackMap.git", branch: "main"

  depends_on "rust" => :build
  depends_on "python@3.12"
  # Rust toolchain for pydantic-core's sdist. Homebrew's virtualenv
  # install runs pip with `--no-binary :all:`, so any wheel-only Python
  # package with a Rust extension has to build from source.

  # BEGIN resources: managed by scripts/regenerate.sh — do not edit by hand
  resource "annotated-doc" do
    url "https://files.pythonhosted.org/packages/57/ba/046ceea27344560984e26a590f90bc7f4a75b06701f653222458922b558c/annotated_doc-0.0.4.tar.gz"
    sha256 "fbcda96e87e9c92ad167c2e53839e57503ecfda18804ea28102353485033faa4"
  end
  resource "annotated-types" do
    url "https://files.pythonhosted.org/packages/ee/67/531ea369ba64dcff5ec9c3402f9f51bf748cec26dde048a2f973a4eea7f5/annotated_types-0.7.0.tar.gz"
    sha256 "aff07c09a53a08bc8cfccb9c85b05f1aa9a2a6f23728d790723543408344ce89"
  end
  resource "attackmap-analyzer-atproto" do
    url "https://files.pythonhosted.org/packages/c8/24/72973ac18a6bb05f2959a8e9eaa756e47ee589aeda30938def6e95634482/attackmap_analyzer_atproto-0.1.0.tar.gz"
    sha256 "8a39b97b1ee2f94de5d304f264799c03ee0c7898e962d6e3ec0769b356a39bb2"
  end
  resource "attackmap-analyzer-c" do
    url "https://files.pythonhosted.org/packages/28/a5/9236014453ce338c4b4cfa4e4b60acaf4fcc60b6cf08eb305493d1c5499f/attackmap_analyzer_c-0.1.0.tar.gz"
    sha256 "06848f05cab604a15dfdbd33bb35131ec1fa1ab92a5f68477d801e5874d703ca"
  end
  resource "attackmap-analyzer-cpp" do
    url "https://files.pythonhosted.org/packages/26/80/80945873d31ffc8f61c89a1aadbf8b90b49dd0a328d934af91f77b7110d1/attackmap_analyzer_cpp-0.1.0.tar.gz"
    sha256 "e274707d8b24fa28d9c16a954ce9837d7638c82df92801e70384db4a7e8ef911"
  end
  resource "attackmap-analyzer-dotnet" do
    url "https://files.pythonhosted.org/packages/b3/98/b7a96fde0a9cecb267ebe5f2451f05c7060be42f9961a467c4f4c9401d41/attackmap_analyzer_dotnet-0.1.0.tar.gz"
    sha256 "9912838c9c36020248b2b7dd4ebfcf7649e8d9f194586094c29e83e3a1fd27c9"
  end
  resource "attackmap-analyzer-go" do
    url "https://files.pythonhosted.org/packages/9d/73/c526aa9c641f5c1cdb55910dede39470018eeda93e0a1823aa901ff4ae2f/attackmap_analyzer_go-0.1.0.tar.gz"
    sha256 "2a416f7611fce9d154d977dff5278fa3399802b2c771e7f54a8b35cef626f1d6"
  end
  resource "attackmap-analyzer-iac" do
    url "https://files.pythonhosted.org/packages/33/85/798c0e984a0e3d03540eb22fccd0e17bb4e6fc61e3e116273fd1c7207986/attackmap_analyzer_iac-0.1.0.tar.gz"
    sha256 "093c3fb1c17ccbfd612e61205b32d93f6c5586e165fef86e98cd69a8fd1dd25a"
  end
  resource "attackmap-analyzer-java-spring" do
    url "https://files.pythonhosted.org/packages/a7/fe/5042dcbe8a942a145802f4e33f0f02355968dfdee5a47c6bd9193df002e1/attackmap_analyzer_java_spring-0.1.0.tar.gz"
    sha256 "19c0ce351238f42aeb18c45586f010d3c3b6e6461ff306aafa1bc6f29dbada28"
  end
  resource "attackmap-analyzer-node-service" do
    url "https://files.pythonhosted.org/packages/20/27/c708307fb877e4361eed67122412e43d7e50f37baeab88f332ebcd035ba8/attackmap_analyzer_node_service-0.2.0.tar.gz"
    sha256 "70930e19c5c969ddf05c81698ee7b83c99118d5ee4d870f9eb4353c570824b09"
  end
  resource "attackmap-analyzer-omeka-s" do
    url "https://files.pythonhosted.org/packages/c1/22/8c4e42708741cc7a963316e81f5efde670c2952674fdc1d57c44f38d1a40/attackmap_analyzer_omeka_s-0.1.0.tar.gz"
    sha256 "defc26baae43e0df55c94a23c2950dec1e07f1b0a60d120f96c7f15d16b3c47f"
  end
  resource "attackmap-analyzer-php-laminas" do
    url "https://files.pythonhosted.org/packages/2a/59/56380127fa3dbbd95a9889f5bab64ba7a67c26a18e4a4c7b715ff3451b8b/attackmap_analyzer_php_laminas-0.1.0.tar.gz"
    sha256 "86a27a1ac3b082ac8749bf9a10e07444830a63ab15ca39ee578a4cea34e9c660"
  end
  resource "attackmap-analyzer-php-web" do
    url "https://files.pythonhosted.org/packages/eb/a5/6ea90f719ef72c4cbaad5edd154b3e9189858da3480bac28c6c256f3ad0f/attackmap_analyzer_php_web-0.1.0.tar.gz"
    sha256 "278c8d67fb2a09a8d0f71066f0a9df3895572eb1ad5c7e3468f09f2ca3e2d3ff"
  end
  resource "attackmap-analyzer-python" do
    url "https://files.pythonhosted.org/packages/96/25/eae68e77fc93d4ef83893de4d7c9ae238787d8e41af8a0d8f537454c0c12/attackmap_analyzer_python-0.1.0.tar.gz"
    sha256 "f9ce682893792f2b3cc39c29bbd074571e05574871c8049f189e64f3cae6276a"
  end
  resource "attackmap-analyzer-rust" do
    url "https://files.pythonhosted.org/packages/a4/e2/c945879d8edf07c231d6aa2427975d456dc54d4576ebc9411c32aa5e1954/attackmap_analyzer_rust-0.1.0.tar.gz"
    sha256 "99106bcca98856588dee5ceac015ce4e8c63e008dde3ec4c09433817e54a57f3"
  end
  resource "attackmap-analyzer-terraform" do
    url "https://files.pythonhosted.org/packages/9e/82/b4dd334dc99a64fea99ec29e42cb20f559f7783bcb36f2a6843c6d7f7265/attackmap_analyzer_terraform-0.1.0.tar.gz"
    sha256 "759c572ac226b8148da96817295146981f9f9bcc8e93d6b8b2efdd2b7fb512c2"
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
    url "https://files.pythonhosted.org/packages/6a/51/63fe664f3908c97be9d2e4f1158eb633317598cfa6e1fc14af5383f17512/networkx-3.6.1.tar.gz"
    sha256 "26b7c357accc0c8cde558ad486283728b65b6a95d85ee1cd66bafab4c8168509"
  end
  resource "pydantic" do
    url "https://files.pythonhosted.org/packages/18/a5/b60d21ac674192f8ab0ba4e9fd860690f9b4a6e51ca5df118733b487d8d6/pydantic-2.13.4.tar.gz"
    sha256 "c40756b57adaa8b1efeeced5c196f3f3b7c435f90e84ea7f443901bec8099ef6"
  end
  resource "pydantic-core" do
    url "https://files.pythonhosted.org/packages/9d/56/921726b776ace8d8f5db44c4ef961006580d91dc52b803c489fafd1aa249/pydantic_core-2.46.4.tar.gz"
    sha256 "62f875393d7f270851f20523dd2e29f082bcc82292d66db2b64ea71f64b6e1c1"
  end
  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/c3/b2/bc9c9196916376152d655522fdcebac55e66de6603a76a02bca1b6414f6c/pygments-2.20.0.tar.gz"
    sha256 "6757cd03768053ff99f3039c1a36d6c0aa0b263438fcab17520b30a303a82b5f"
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
    url "https://files.pythonhosted.org/packages/7c/f7/68adc395201b20b872d68e975386832e8005ffeacedd43a1d837a32815be/typer-0.26.8.tar.gz"
    sha256 "c244a6bd558886fe3f8780efb6bdd28bb9aff005a94eedebaa5cb32926fe2f7e"
  end
  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/f6/cc/6253133b5bb138fc3306cebfbda2c520f545d36b5be2c7255cc528bb45d6/typing_extensions-4.16.0.tar.gz"
    sha256 "dc983d19a509c94dba722ee6abd33940f7c05a89e243c47e907eb4db6f1a43e5"
  end
  resource "typing-inspection" do
    url "https://files.pythonhosted.org/packages/55/e3/70399cb7dd41c10ac53367ae42139cf4b1ca5f36bb3dc6c9d33acdb43655/typing_inspection-0.4.2.tar.gz"
    sha256 "ba561c48a67c5958007083d386c3295464928b01faa735ab8547c5692e87f464"
  end
  # END resources

  def install
    virtualenv_install_with_resources
  end

  test do
    # Smoke test: CLI is wired and prints the help text.
    assert_match "AttackMap", shell_output("#{bin}/attackmap --help")

    # Smoke test: at least one analyzer plugin is discovered.
    assert_match "python", shell_output("#{bin}/attackmap modules")
  end
end
