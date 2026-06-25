class Sast < Formula
  include Language::Python::Virtualenv

  desc "Free, fast static application security testing for CI/CD"
  homepage "https://insom.ai"
  # The `sast` launcher from PyPI (pure-Python, zero deps). It downloads the
  # OS-matched SAST engine binary from insom.ai on first run, sha256-verified,
  # and caches it. Bump url+sha256 with scripts/update_formula.py on each release.
  url "https://files.pythonhosted.org/packages/88/8d/9eb00a159f1e19a1bcfde255a7a28eb0e133509628d287c2e9a32d8252fc/sast-1.6.6.tar.gz"
  sha256 "79c148446f35f56311f124995c1ff2eb8dbc13cdf108a34abf4fa55914f5e069"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    # The launcher must report its version without touching the network.
    assert_match "sast launcher", shell_output("#{bin}/sast self-version")
    assert_match "sast", shell_output("#{bin}/sast self-where")
  end
end
