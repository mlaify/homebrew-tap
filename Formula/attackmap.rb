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
  url "https://files.pythonhosted.org/packages/d2/6c/a19a6b87093a5133bbe24ac8abb52b37a2a35dabef9f4b6933b6b2a1f144/attackmap-0.1.0.tar.gz"
  sha256 "d6d65adfd42e28c96562c9213872f0460cea3f18f5a65dc7e958f794fcb6c3cb"
  # END sdist
  license "MIT"
  head "https://github.com/mlaify/AttackMap.git", branch: "main"

  depends_on "python@3.12"

  # BEGIN resources: managed by scripts/regenerate.sh — do not edit by hand
  resource "annotated-doc" do
    url "https://files.pythonhosted.org/packages/57/ba/046ceea27344560984e26a590f90bc7f4a75b06701f653222458922b558c/annotated_doc-0.0.4.tar.gz"
    sha256 "fbcda96e87e9c92ad167c2e53839e57503ecfda18804ea28102353485033faa4"
  end
  resource "annotated-types" do
    url "https://files.pythonhosted.org/packages/ee/67/531ea369ba64dcff5ec9c3402f9f51bf748cec26dde048a2f973a4eea7f5/annotated_types-0.7.0.tar.gz"
    sha256 "aff07c09a53a08bc8cfccb9c85b05f1aa9a2a6f23728d790723543408344ce89"
  end
  resource "anthropic" do
    url "https://files.pythonhosted.org/packages/7b/dd/808c144d4a883fcfd12fe0d7689b1d86bbbea6666c1cc957ad19f1017c22/anthropic-0.112.0.tar.gz"
    sha256 "e180cd91aa5b9b32e4007fe69892ab128d8a86b9f90825103b1903fbc977d0af"
  end
  resource "anyio" do
    url "https://files.pythonhosted.org/packages/3b/72/5562aabb8dd7181e8e860622a38bea08d17842b99ecd4c91f84ac95251b0/anyio-4.14.1.tar.gz"
    sha256 "8d648a3544c1a700e3ff78615cd679e4c5c3f149904287e73687b2596963629e"
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
  resource "attackmap-analyzer-java-spring" do
    url "https://files.pythonhosted.org/packages/a7/fe/5042dcbe8a942a145802f4e33f0f02355968dfdee5a47c6bd9193df002e1/attackmap_analyzer_java_spring-0.1.0.tar.gz"
    sha256 "19c0ce351238f42aeb18c45586f010d3c3b6e6461ff306aafa1bc6f29dbada28"
  end
  resource "attackmap-analyzer-node-service" do
    url "https://files.pythonhosted.org/packages/e3/24/3930ba04eea5150a6650c456d59f4cc7506233f512e88888cbbf63d3d06e/attackmap_analyzer_node_service-0.1.0.tar.gz"
    sha256 "c76b334423ed855cdbfae0efd5aa118038eb0b1540d5cb0ed29b54caf0974c20"
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
  resource "certifi" do
    url "https://files.pythonhosted.org/packages/c9/c7/424b75da314c1045981bd9777432fad05a9e0c69daa4ed7e308bbaffe405/certifi-2026.6.17.tar.gz"
    sha256 "024c88eeec92ca068db80f02b8b07c9cef7b9fe261d1d535abfd5abd6f6af432"
  end
  resource "distro" do
    url "https://files.pythonhosted.org/packages/fc/f8/98eea607f65de6527f8a2e8885fc8015d3e6f5775df186e443e0964a11c3/distro-1.9.0.tar.gz"
    sha256 "2fa77c6fd8940f116ee1d6b94a2f90b13b5ea8d019b98bc8bafdcabcdd9bdbed"
  end
  resource "docstring-parser" do
    url "https://files.pythonhosted.org/packages/e0/4d/f332313098c1de1b2d2ff91cf2674415cc7cddab2ca1b01ae29774bd5fdf/docstring_parser-0.18.0.tar.gz"
    sha256 "292510982205c12b1248696f44959db3cdd1740237a968ea1e2e7a900eeb2015"
  end
  resource "h11" do
    url "https://files.pythonhosted.org/packages/01/ee/02a2c011bdab74c6fb3c75474d40b3052059d95df7e73351460c8588d963/h11-0.16.0.tar.gz"
    sha256 "4e35b956cf45792e4caa5885e69fba00bdbc6ffafbfa020300e549b208ee5ff1"
  end
  resource "httpcore" do
    url "https://files.pythonhosted.org/packages/06/94/82699a10bca87a5556c9c59b5963f2d039dbd239f25bc2a63907a05a14cb/httpcore-1.0.9.tar.gz"
    sha256 "6e34463af53fd2ab5d807f399a9b45ea31c3dfa2276f15a2c3f00afff6e176e8"
  end
  resource "httpx" do
    url "https://files.pythonhosted.org/packages/b1/df/48c586a5fe32a0f01324ee087459e112ebb7224f646c0b5023f5e79e9956/httpx-0.28.1.tar.gz"
    sha256 "75e98c5f16b0f35b567856f597f06ff2270a374470a5c2392242528e3e3e42fc"
  end
  resource "idna" do
    url "https://files.pythonhosted.org/packages/cd/63/9496c57188a2ee585e0f1db071d75089a11e98aa86eb99d9d7618fc1edce/idna-3.18.tar.gz"
    sha256 "ffb385a7e039654cef1ab9ef32c6fafe283c0c0467bba1d9029738ce4a14a848"
  end
  resource "jiter" do
    url "https://files.pythonhosted.org/packages/66/b5/55f06bb281d92fb3cc86d14e1def2bd908bb77693183e7cb1f5a3c388b0c/jiter-0.15.0.tar.gz"
    sha256 "4251acc80e2b7c9b7b8823456ea0fceeb0734dac2df7636d3c711b38476b5a76"
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
  resource "pydantic_core" do
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
  resource "sniffio" do
    url "https://files.pythonhosted.org/packages/a2/87/a6771e1546d97e7e041b6ae58d80074f81b7d5121207425c964ddf5cfdbd/sniffio-1.3.1.tar.gz"
    sha256 "f4324edc670a0f49750a81b895f35c3adb843cca46f0530f79fc1babb23789dc"
  end
  resource "typer" do
    url "https://files.pythonhosted.org/packages/5e/ed/ef06584ccdd5c410df0837951ecd7e15d9a6144ea1bd4c73cecab1a89891/typer-0.26.7.tar.gz"
    sha256 "e314a34c617e419c091b2830dda3ea1f257134ff593061a8f5b9717ab8dddb3a"
  end
  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/72/94/1a15dd82efb362ac84269196e94cf00f187f7ed21c242792a923cdb1c61f/typing_extensions-4.15.0.tar.gz"
    sha256 "0cea48d173cc12fa28ecabc3b837ea3cf6f38c6d1136f85cbaaf598984861466"
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
