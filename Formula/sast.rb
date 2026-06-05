class Sast < Formula
  include Language::Python::Virtualenv

  desc "Free, fast static application security testing for CI/CD"
  homepage "https://insom.ai"
  # The `sast` launcher from PyPI (pure-Python, zero deps). It downloads the
  # OS-matched SAST engine binary from insom.ai on first run, sha256-verified,
  # and caches it. Bump url+sha256 with scripts/update_formula.py on each release.
  url "https://files.pythonhosted.org/packages/1e/46/67bd7185e5efea4814425ee89e7fc241095aabf3a864ca2de2b0b5025cd9/sast-1.5.0.tar.gz"
  sha256 "a1dd1c7d989b0de748b469dd21aadcb4fe53b2b2aba7bc3436527128540b7cbc"
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
