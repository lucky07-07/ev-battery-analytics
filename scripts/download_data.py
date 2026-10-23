"""Download the BMW i3 driving dataset from Kaggle into data/raw/.

Usage:
    python scripts/download_data.py

Needs a Kaggle API token in ~/.kaggle/kaggle.json (Kaggle → Settings → API → Create New Token).
Original source: "Battery and Heating Data in Real Driving Cycles", TU Munich, IEEE DataPort (CC BY 4.0).
"""
import base64
import hashlib
import json
import urllib.request
import zipfile
from pathlib import Path

DATASET = "atechnohazard/battery-and-heating-data-in-real-driving-cycles"
ROOT = Path(__file__).resolve().parents[1]
DOWNLOAD = ROOT / "data" / "download"
RAW = ROOT / "data" / "raw"


def main():
    token = json.loads((Path.home() / ".kaggle" / "kaggle.json").read_text())
    auth = base64.b64encode(f"{token['username']}:{token['key']}".encode()).decode()
    DOWNLOAD.mkdir(parents=True, exist_ok=True)
    zip_path = DOWNLOAD / "battery-and-heating-data-in-real-driving-cycles.zip"
    request = urllib.request.Request(f"https://www.kaggle.com/api/v1/datasets/download/{DATASET}",
                                     headers={"Authorization": f"Basic {auth}"})
    with urllib.request.urlopen(request, timeout=600) as response, open(zip_path, "wb") as f:
        while chunk := response.read(1 << 20):
            f.write(chunk)
    print(f"downloaded {zip_path.name} ({zip_path.stat().st_size / 1e6:.1f} MB), "
          f"sha256 {hashlib.sha256(zip_path.read_bytes()).hexdigest()}")
    RAW.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(zip_path) as z:
        z.extractall(RAW)
    print(f"extracted {len(list(RAW.glob('Trip*.csv')))} trip files to {RAW}")


if __name__ == "__main__":
    main()
