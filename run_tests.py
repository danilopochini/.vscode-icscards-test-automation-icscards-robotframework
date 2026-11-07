import argparse
import webbrowser
from pathlib import Path

from robot import run


ENVIRONMENTS = {
    "qa": "https://www.qa.icscards.nl",
    "prod": "https://www.icscards.nl",
}


def main() -> int:
    parser = argparse.ArgumentParser(description="Run the ICS Cards Robot Framework suite.")
    parser.add_argument("--env", choices=ENVIRONMENTS, default="qa", help="environment to test (default: qa)")
    parser.add_argument("--base-url", help="base URL, overrides --env")
    parser.add_argument("--browser", choices=("chromium", "firefox", "webkit"), default="chromium")
    parser.add_argument("--headed", action="store_true", help="show the browser window")
    parser.add_argument("--slowmo", type=float, default=0, metavar="MS", help="slow browser actions by milliseconds")
    parser.add_argument("--smoke", action="store_true", help="run only tests tagged smoke")
    parser.add_argument("--no-open-report", action="store_true", help="do not open report.html after the run")
    args = parser.parse_args()

    project_dir = Path(__file__).resolve().parent
    report_path = project_dir / "report.html"
    variables = [
        f"ENV:{args.env}",
        f"BASE_URL:{args.base_url or ENVIRONMENTS[args.env]}",
        f"BROWSER:{args.browser}",
        f"HEADLESS:{not args.headed}",
        f"SLOWMO:{args.slowmo / 1000:g}s",
    ]
    options = {
        "outputdir": str(project_dir),
        "output": str(project_dir / "output.xml"),
        "log": str(project_dir / "log.html"),
        "report": str(report_path),
        "reportbackground": "#70d970:#70d970:#70d970",
        "variable": variables,
    }
    if args.smoke:
        options["include"] = "smoke"

    result = run(str(project_dir / "tests"), **options)
    if not args.no_open_report and report_path.exists():
        webbrowser.open(report_path.as_uri())
    return int(result)


if __name__ == "__main__":
    raise SystemExit(main())
