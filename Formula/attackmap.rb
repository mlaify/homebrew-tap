# typed: false
# frozen_string_literal: true

# AttackMap — AI-assisted defensive security analyzer for codebases.
# Homepage: https://github.com/mlaify/AttackMap
#
# This formula installs `attackmap` into a Homebrew-managed virtualenv and
# pulls every official analyzer plugin from PyPI via the `[all]` extra.
#
# NOTE: This is a "loose" formula — it does not pin every transitive
# dependency with sha256 resources. That is the canonical Homebrew pattern
# for Python CLIs, but it requires every wheel to be on PyPI first. After
# 0.1.0 ships to PyPI, regenerate this formula with `scripts/regenerate.sh`
# (which uses homebrew-pypi-poet) to produce a fully-pinned version.
class Attackmap < Formula
  include Language::Python::Virtualenv

  desc "AI-assisted defensive security analyzer for codebases"
  homepage "https://github.com/mlaify/AttackMap"
  url "https://files.pythonhosted.org/packages/source/a/attackmap/attackmap-0.1.0.tar.gz"
  # TODO: replace with the real sha256 from `pip download attackmap==0.1.0 --no-deps`
  # once the package is published to PyPI.
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"
  head "https://github.com/mlaify/AttackMap.git", branch: "main"

  depends_on "python@3.12"

  # Loose install path: create a Homebrew-managed virtualenv, then `pip install`
  # the [all] extra at brew-install time. This pulls every official analyzer
  # plugin (attackmap-analyzer-python, -rust, -go, ...) and the LLM extra.
  def install
    venv = virtualenv_create(libexec, "python3.12")
    venv.pip_install_and_link buildpath
    venv.pip_install "attackmap[all]==#{version}"
  end

  test do
    # Smoke test: CLI is wired and prints the help text.
    assert_match "AttackMap", shell_output("#{bin}/attackmap --help")

    # Smoke test: at least one analyzer plugin is discovered.
    assert_match "python", shell_output("#{bin}/attackmap modules")
  end
end
