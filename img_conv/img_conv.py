import json
from argparse import ArgumentParser
from pathlib import Path
import time


def main(src: Path, out: Path):
    print(f"generating {out} from {src}")
    time.sleep(5)
    out.parent.mkdir(parents=True, exist_ok=True)
    cfg = json.loads(src.read_text())
    content = f"{cfg}"
    out.write_text(content)


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("--src", type=Path, required=True)
    parser.add_argument("--out", type=Path, required=True)
    args = parser.parse_args()
    main(**vars(args))
