# ICS Cards Robot Framework tests

Robot Framework + Browser library (Playwright), using resource files for page keywords, against QA (`https://www.qa.icscards.nl`, default) or production (`--env prod`).
The suite covers the same home-page checks as the Playwright and Selenium projects.

## Setup
Install [Node.js LTS](https://nodejs.org/) with npm, then open a new terminal.
Check that `node --version` and `npm.cmd --version` work before initializing Browser.

From the repository root:
```powershell
python -m venv .venv; .\.venv\Scripts\Activate.ps1
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
.\.venv\Scripts\rfbrowser.exe init
```
Using explicit paths ensures installation and initialization use this project's virtual
environment, even if a different Python is on `PATH`. If `rfbrowser.exe` is missing,
rerun the pip installation command above and check for errors.
If you prefer an existing virtual environment, activate it, install the requirements there,
and verify `Get-Command rfbrowser` points to that environment before running `rfbrowser init`.

## Run
```powershell
python run_tests.py                         # all tests, headless; opens report.html
python run_tests.py --smoke                  # smoke tests only
python run_tests.py --headed --slowmo 500    # visible Chromium with 500 ms slow-motion
python run_tests.py --browser firefox        # use Firefox instead of Chromium
python run_tests.py --env prod               # test production
python run_tests.py --base-url https://example.test  # overrides --env
python run_tests.py --no-open-report         # don't open the report (e.g. on CI)
```

Each run writes Robot Framework's `report.html`, `log.html`, and `output.xml` in this folder. Failed tests capture a screenshot in the log.

## Layout
- `tests/home.robot` home-page scenarios
- `resources/home.resource` home-page keywords and selectors
- `resources/common.resource` browser lifecycle and shared variables
- `run_tests.py` runner options and report opening
