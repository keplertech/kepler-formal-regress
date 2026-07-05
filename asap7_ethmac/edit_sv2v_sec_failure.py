#!/usr/bin/env python3
from pathlib import Path
import sys

DESIGN_DIR = Path(__file__).resolve().parent
REPO_ROOT = DESIGN_DIR.parent
sys.path.insert(0, str(REPO_ROOT / "scripts"))

from sv2v_sec_failure_edit import replace_instance_pin_net


LIBERTY_FILES = [
    "./asap7sc7p5t_AO_RVT_FF_nldm_211120.lib.gz",
    "./asap7sc7p5t_INVBUF_RVT_FF_nldm_220122.lib.gz",
    "./asap7sc7p5t_OA_RVT_FF_nldm_211120.lib.gz",
    "./asap7sc7p5t_SIMPLE_RVT_FF_nldm_211120.lib.gz",
    "./asap7sc7p5t_SEQ_RVT_FF_nldm_220123.lib",
]


def main():
    old_net = "_005781_"
    new_net = "_005783_"
    if len(sys.argv) == 2 and sys.argv[1] == "--revert":
        old_net, new_net = new_net, old_net
    elif len(sys.argv) != 1:
        raise SystemExit(f"usage: {Path(sys.argv[0]).name} [--revert]")

    # Verified with sv2v k-induction dual-rail steady: first bad frame is k = 2.
    replace_instance_pin_net(
        DESIGN_DIR,
        "./1_synth_lec.v",
        "_100929_",
        "B",
        old_net,
        new_net,
        liberty_files=LIBERTY_FILES,
        validate_with_naja=True,
    )

if __name__ == "__main__":
    main()
