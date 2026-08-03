# C2RTL Dilithium NTT CC Mismatch

Two C/C++ inputs are synthesized independently from the Dilithium NTT source.
The second input flips bit 0 of the transformed array before returning.

Run from this directory:

```sh
kepler-formal --config config.yaml
```

A correct SEC result is `Different` at `k=0`. This regression exercises the
combinational, zero-state path rather than a temporal PDR proof.

When this regression was added, KF incorrectly reported `Equivalent at k=0`.
That zero-state shortcut is the bug captured by this case.
