class Sast < Formula
  include Language::Python::Virtualenv

  desc "Free, fast static application security testing for CI/CD"
  homepage "https://insom.ai"
  # The `sast` launcher from PyPI (pure-Python, zero deps). It downloads the
  # OS-matched SAST engine binary from insom.ai on first run, sha256-verified,
  # and caches it. Bump url+sha256 with scripts/update_formula.py on each release.
  url "https://files.pythonhosted.org/packages/f1/57/565b6cbdfc3cae979df48f5b7b774079a15b9a632405b07fdbacb6af219f/sast-0.1.1.tar.gz"
  sha256 "b713fe327fdeae2caa132b7538f80c0a04ab10a8f9e91ec20844ac885611aa66"
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
