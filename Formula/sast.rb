class Sast < Formula
  include Language::Python::Virtualenv

  desc "Free, fast static application security testing for CI/CD"
  homepage "https://insom.ai"
  # The `sast` launcher from PyPI (pure-Python, zero deps). It downloads the
  # OS-matched SAST engine binary from insom.ai on first run, sha256-verified,
  # and caches it. Bump url+sha256 with scripts/update_formula.py on each release.
  url "https://files.pythonhosted.org/packages/9f/6d/09e6241bb7c0040e16e4e42bf8c707e275654d318309f973ae632a9f60ec/sast-1.6.5.tar.gz"
  sha256 "9adda252129f4b174bad7adcc98322f3fa9b253380dbcb4666c8fe8cdeceaf9f"
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
