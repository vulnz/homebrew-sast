# homebrew-sast

Homebrew tap for **[sast](https://pypi.org/project/sast/)** — free, fast static
application security testing for CI/CD.

> **Benchmark:** 85.7% class recall on 31 vulnerable repos vs Semgrep 58.9%,
> SonarQube 26.8%, Bandit 16.1% — [full head-to-head →](https://insom.ai/benchmark)

## Install

```bash
brew install vulnz/sast/sast
```

(That's shorthand for `brew tap vulnz/sast && brew install sast`.)

Then:

```bash
sast .                 # scan the current directory
sast ./src -f sarif    # write a SARIF report
sast --help
```

## How it works

`brew install` lays down the tiny `sast` launcher in an isolated virtualenv.
The first time you run `sast`, it downloads the OS-matched SAST engine binary
from insom.ai (checksum-verified) and caches it; later runs reuse it and it
auto-updates daily. See the [launcher repo](https://github.com/vulnz/sast).

> macOS note: the engine ships for Linux and Windows today; the macOS engine
> build is published separately on insom.ai. Until it's available, `sast` on
> macOS will report that no macOS build exists yet.

## Maintaining

After publishing a new `sast` release to PyPI, bump the formula:

```bash
python scripts/update_formula.py     # pulls latest url + sha256 from PyPI
git commit -am "sast X.Y.Z" && git push
```

## Why a tap (not `brew install sast`)?

A bare `brew install sast` would require acceptance into `homebrew-core`, which
has notability/review requirements. A tap gives you `brew install vulnz/sast/sast`
immediately, fully under your control.
