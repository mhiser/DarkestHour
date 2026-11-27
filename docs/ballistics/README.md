# Ballistic coefficients

This page records how projectile `BallisticCoefficient` (BC) values are set and checked.
The per-class audit is in [bc-audit.md](bc-audit.md).

## What the engine does with BC

- `ROBallisticProjectile` (in the shipped `ROEngine.u`) declares `BallisticCoefficient`.
- Its `PostBeginPlay` sets `BCInverse = 1 / BallisticCoefficient`.
- The drag step is native code. Its script text uses imperial units (`ScaleFactor = 18.4` units per foot).
- Penetration does not use BC. `DHPenetrationTable` is indexed by range only.
- BC changes the drop and the retained speed. So BC must agree with the gunsight table of the round.

## Units and scale

Treat BC as a G1 coefficient in lb/in^2.
The 16 values marked "verified on range at 1000 yards" give the in-engine scale.
For each, the ratio BC / SD is shown. SD is the sectional density, mass (lb) / diameter (in)^2.

| Round | Mass | SD (lb/in^2) | BC | BC / SD |
|---|---|---|---|---|
| 37 mm M51 APC (Stuart, Greyhound) | 0.87 kg | 0.904 | 1.52 | 1.68 |
| 75 mm M61 APC (Sherman, Cromwell) | 6.79 kg | 1.716 | 2.98 | 1.74 |
| 76 mm M62 APC (76 mm M1) | 7.00 kg | 1.714 | 3.21 | 1.87 |
| 76 mm M62 APC (3 in M7, Wolverine) | 7.00 kg | 1.714 | 2.85 | 1.66 |
| 90 mm M82 APC (Jackson) | 10.94 kg | 1.921 | 3.95 | 2.06 |
| 90 mm M71 HE (Jackson) | 10.55 kg | 1.853 | 3.62 | 1.95 |
| 90 mm M77 AP shot, blunt (Jackson) | 10.94 kg | 1.921 | 1.564 | 0.81 |
| 76 mm M93 HVAP | 4.22 kg | 1.033 | 1.87 | 1.81 |
| 90 mm M304 HVAP | 7.62 kg | 1.338 | 2.55 | 1.91 |

Bands used in the audit:

- Capped and streamlined AP, APC and APCBC: BC / SD from 1.66 to 2.06.
- Full-caliber-body APCR and HVAP: BC / SD from 1.81 to 1.91.
- Streamlined gun HE: about 1.95 (M71).
- Blunt AP shot without a ballistic cap: about 0.81 (M77).

These ratios equal 1 / i, where i is the G1 form factor. A range of i from 0.5 to 0.6 is normal for capped shells.

## Gunsight tables

`MechanicalRanges` holds gun pitch in rotator units (65536 per turn) for each sight range.
The tables were set in engine with the auto range debug tool in `DHVehicleCannon`.
A BC change makes the old table wrong. Do not change BC on a round with a calibrated table without a table update.

A point-mass G1 model reproduces the Tiger II tables well:

- Gravity 9.81 m/s^2, sea level air density, standard G1 drag table.
- One drag scale factor, 0.7, for all rounds.
- With these values the model fits the `DH_Tiger2BCannonShell` table (BC 3.8, 1000 m/s, 100 m to 3000 m) with an RMS error of 1.9 pitch units.
- The model also shows that the old `DH_Tiger2BCannonShellAPCR` table matches BC 1.4 to 1.5. So that table was tuned to the old BC of 1.527.

To move a table to a new BC, add the model difference to each old entry:
`new(R) = old(R) + pitch(R, new BC) - pitch(R, old BC)`.
This keeps the in-engine sight offset and changes only the drop part.
Confirm the result in game with the auto range debug tool or `CalibrateFire`.

## Tiger II APCR (Pzgr.40/43), issue #30

- Projectile: 7.3 kg, 88 mm, 1130 m/s (8.8 cm KwK 43 data, for example Wikipedia "8.8 cm KwK 43").
- The repo `Speed=68198.0` is 1130 m/s, so the speed agrees.
- SD = 16.09 lb / 3.465 in^2 = 1.340.
- The two verified HVAP rounds give BC / SD of 1.81 and 1.91, mean 1.86.
- BC = 1.340 x 1.86 = 2.49.
- Cross-check: the M304 value scaled by mass and caliber gives 2.55. The old value 1.527 is below the smaller M93 (1.87).
- The `MechanicalRanges` table moved with the method above. The change is 0 to 2 pitch units up to 1000 m and 50 units at 4000 m.
- No cannon in the repo loads this class now. The change has no live gameplay effect until a cannon uses it.
