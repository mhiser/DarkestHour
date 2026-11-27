# BC audit of flagged classes (issue #35)

This table covers every `BallisticCoefficient` line that had a TODO, "pls check", "assumed" or a similar note.
The method, the units and the verified bands are in [README.md](README.md).

Columns:

- BC: the value before this audit. New BC: the value after the audit, where it changed.
- MV: muzzle speed from `Speed` x 0.0165695, in m/s.
- Mass: projectile mass used for the check, in kg. "-" means no reliable figure.
- BC/SD: the current BC divided by sectional density (lb/in^2).
- Verdict: "retained" means the value fits a verified sibling. "suspect, retained" means the value looks off, but a calibrated sight table or a linked value depends on it. "changed" means the value was wrong by the standard of issue #30.

Verified bands: capped AP and APC 1.66 to 2.06, HVAP 1.81 to 1.91, gun HE about 1.95, blunt shot about 0.81.

| Class | Round | BC | New BC | MV (m/s) | Mass (kg) | BC/SD | Old comment | Verdict | Basis |
|---|---|---|---|---|---|---|---|---|---|
| `DH_17PounderCannonShell` | 17pdr Mk.IV APC | 2.45 |  | 884 | 7.71 | 1.30 | TODO: pls check | retained | BC/SD 1.30 lies between blunt shot (0.81) and capped APC (1.66 to 2.06). |
| `DH_17PounderCannonShellHE` | 17pdr Mk.I HE-T | 2.45 |  | 884 | 6.98 | 1.43 | TODO: pls, check | retained | BC/SD 1.43. Gun HE without a long ogive sits below M71 (1.95). |
| `DH_45mmM1937GunCannonShell` | 45 mm BR-240 APBC | 0.7 |  | 760 | 1.43 | 0.70 | TODO: try to find an accurate BC (this is from AHZ) | retained | BC/SD 0.70, close to the blunt M77 shot (0.81). Sight tables are tuned to it. |
| `DH_45mmM1937GunCannonShellAPCR` | 45 mm BR-240P APCR | 0.7 |  | 760 | 0.85 | 1.17 | TODO: pls check accurate BC (this is from AHZ) | retained | BC/SD 1.17. Uncapped arrowhead APCR has more drag than capped HVAP. No cannon loads this class. |
| `DH_45mmM1937GunCannonShellHE` | 45 mm O-240 HE | 0.6 |  | 335 | 2.13 | 0.40 | TODO: try to find an accurate BC (this is from AHZ) | suspect, retained | BC/SD 0.40 is low for HE. Mechanical and optical tables are tuned to it. Speed is 335 m/s, so drag has a small effect. A change needs both tables recalibrated in game. |
| `DH_6PounderCannonShellAPDS` | 6pdr Mk.I APDS | 1.15 |  | 1219 | - |  | TODO: pls, check | retained | No verified APDS value exists. 6pdr (1.15) below 17pdr (1.47) follows sub-projectile mass. The table is tuned to it. |
| `DH_AT57CannonShell` | 57 mm M86 APC | 1.19 |  | 831 | 2.86 | 0.95 | TODO: find correct BC | retained | BC/SD 0.95. Same projectile pattern and value as the Cromwell 6pdr Mk.IX APC. |
| `DH_Bofors40mmCannonShell` | 40 mm M81A1 AP | 0.984 |  | 881 | 0.89 | 1.24 | TODO: try to find an accurate BC (this is same as US 37mm) | retained | BC/SD 1.24. Copied from US 37 mm, which is consistent once mass and caliber are scaled. |
| `DH_Bofors40mmCannonShellHE` | 40 mm Mk.II HE-T | 0.984 |  | 881 | 0.9 | 1.23 | TODO: pls, check | retained | BC/SD 1.23. Same ratio as the 37 mm M63 HE. |
| `DH_Flak88CannonShell` | 88 mm PzGr.39 | 3.3 |  | 800 | 10.2 | 1.76 | pls, check | retained | BC/SD 1.76, inside the verified band. PzGr.39/43 uses 3.8 (2.04) for a near identical shell. |
| `DH_Flak88CannonShellHE` | 88 mm Sprgr. L/4.5 | 2.4 |  | 820 | 9.0 | 1.45 | TODO: pls, check | retained | BC/SD 1.45, plausible for gun HE. |
| `DH_LeIG18CannonShellHE` | 75 mm Igr.38 HE | 2.96 |  | 115 | 6.0 | 1.95 | TODO: pls find correct BC | retained | BC/SD 1.95, same as M71 HE. At 115 m/s drag has almost no effect. |
| `DH_LeIG18CannonShellHEAT` | 75 mm Igr.38 HL/A HEAT | 2.1 |  | 420 | 3.0 | 2.77 | TODO: pls, check | suspect, retained | BC/SD about 2.8 (mass about 3 kg, not confirmed) is above the verified band. The mechanical table is tuned to it. The M116 also fires this class. A change needs the table recalibrated in game. |
| `DH_M116CannonShellHE` | 75 mm M48 HE | 2.8 |  | 136 | 6.62 | 1.67 | TODO: pls check - this is the APC shell's BC | retained | BC/SD 1.67, inside the verified band. The copied APC value suits this shell. |
| `DH_M1927CannonShellHEAT` | 76 mm BP-353A HEAT | 2.1 |  | 311 | 3.94 | 2.18 | TODO: pls, check | suspect, retained | BC/SD about 2.2 (mass not confirmed) is a little above the band. The mechanical table is tuned to it. |
| `DH_Pak36CannonShell` | 37 mm Pzgr. | 2.52 | 1.2 | 745 | 0.685 | 1.69 | TODO: pls, check | changed | Old 2.52 gave BC/SD 3.54, far above any verified round. The new value scales the verified M51 by mass. It is an upper bound, because this shell has no ballistic cap. No sight table depends on it. |
| `DH_Pak36CannonShellAPCR` | 37 mm Pzgr.40 | 0.95 | 0.71 | 1020 | 0.368 | 1.86 | TODO: coeff on this shell? | changed | Old 0.95 gave BC/SD 2.49, above the HVAP band. The new value uses the verified HVAP mean 1.86. No sight table depends on it. |
| `DH_Pak40CannonShell` | 75 mm PzGr.39 | 2.52 |  | 750 | 6.8 | 1.47 | TODO: pls, check | retained | BC/SD 1.47, 11 percent below the band. No cannon loads this class. |
| `DH_Pak40CannonShellAPCR` | 75 mm PzGr.40 | 1.52 |  | 916 | 4.1 | 1.47 | TODO: pls, check | retained | BC/SD 1.47. No cannon loads this class. |
| `DH_Pak43CannonShell` | 88 mm PzGr.39/43 | 3.8 |  | 1000 | 10.16 | 2.04 | TODO: pls, check | retained | BC/SD 2.04, top of the verified band, same as M82. |
| `DH_Pak43CannonShellHE` | 88 mm Sprgr.43 | 3.25 |  | 750 | 9.4 | 1.88 | TODO: Pls check | retained | BC/SD 1.88, near M71 HE (1.95). |
| `DH_ZiS2CannonShell` | 57 mm BR-271 APBC | 1.14 |  | 993 | 3.14 | 0.83 | TODO: find correct BC | retained | BC/SD 0.83, same as the blunt M77 shot. |
| `DH_ZiS2CannonShellAPCR` | 57 mm BR-271P APCR | 1.11 |  | 1270 | 1.79 | 1.42 | assumed | retained | BC/SD 1.42, below the capped HVAP band as expected. |
| `DH_ZiS2CannonShellHE` | 57 mm O-271 HE | 1.14 |  | 702 | 3.75 | 0.69 | assumed | suspect, retained | BC/SD 0.69 is low for HE. The value was copied from the AP shell. The mechanical table is tuned to it. |
| `DH_ZiS3CannonShell` | 76 mm BR-350B APHEBC | 1.55 |  | 662 | 6.5 | 0.97 | TODO: pls, check | retained | BC/SD 0.97, between blunt shot and capped APC. |
| `DH_ZiS3CannonShellAPCR` | 76 mm BR-350P APCR | 1.55 |  | 662 | 3.02 | 2.10 | TODO: pls, check | suspect, retained | Speed, BC and sight table all copy the AP round, so it flies like the AP round. Real BR-350P is about 965 m/s. Fix speed, BC and table together. |
| `DH_AchillesCannonShellAPDS` | 17pdr Mk.I APDS | 1.47 |  | 1284 | - |  | TODO: pls check | retained | No verified APDS value exists. The table is tuned to it. ShellDiameter is 5.0 here and 5.7 on the Firefly. |
| `DH_AchillesCannonShellHE` | 17pdr Mk.I HE-T | 2.45 |  | 884 | 6.98 | 1.43 | TODO: pls check | retained | BC/SD 1.43. |
| `DH_BT7CannonShell` | 45 mm BR-240 APBC | 0.7 |  | 760 | 1.43 | 0.70 | TODO: try to find an accurate BC (this is from AHZ) | retained | BC/SD 0.70. Same round as the 45 mm M1937 gun. |
| `DH_BT7CannonShellHE` | 45 mm O-240 HE | 0.6 |  | 343 | 2.13 | 0.40 | TODO: try to find an accurate BC (this is from AHZ) | suspect, retained | BC/SD 0.40. See the 45 mm M1937 HE row. |
| `DH_Cromwell6PdrCannonShell` | 6pdr Mk.IX APC | 1.19 |  | 831 | 2.86 | 0.95 | pls check | retained | BC/SD 0.95. |
| `DH_Cromwell6PdrCannonShellAPDS` | 6pdr Mk.I APDS | 1.15 |  | 1219 | - |  | TODO: pls, check | retained | Same as the 6pdr gun APDS. No cannon loads this class. |
| `DH_Cromwell6PdrCannonShellHE` | 6pdr Mk.X HE-T | 1.19 |  | 831 | 2.72 | 1.00 | TODO: pls, check | retained | BC/SD 1.00, plausible for a short HE shell. |
| `DH_CromwellCannonShellHE` | 75 mm M48 HE | 1.686 |  | 463 | 6.62 | 1.01 | TODO: pls check | suspect, retained | BC/SD 1.01. The Sherman fires the same M48 shell with 2.8. The mechanical table (Cromwell, Churchill VII) is tuned to 1.686. |
| `DH_GreyhoundCannonShellHE` | 37 mm M63 HE | 0.984 |  | 883 | 0.73 | 1.30 | TODO: find correct BC | retained | BC/SD 1.30. |
| `DH_HellcatCannonShellHE` | 76 mm M42A1 HE | 1.368 | 2.79 | 792 | 5.84 | 1.95 | TODO: pls find correct BC, this is terribly wrong | changed | Old 1.368 gave BC/SD 0.96, half of the verified M71 HE. The new value uses the M71 ratio 1.95. No sight table depends on it. |
| `DH_ISU152CannonShell` | 152 mm BR-540 AP | 4.4 |  | 600 | 48.8 | 1.47 | TODO: find correct BC | retained | BC/SD 1.47, between blunt shot and capped APC. |
| `DH_ISU152CannonShellHE` | 152 mm OF-540 HE | 5.5 |  | 600 | 43.56 | 2.06 | TODO: find correct BC | retained | BC/SD 2.06. |
| `DH_JagdpantherCannonShell` | 88 mm PzGr.39/43 | 3.8 |  | 1000 | 10.16 | 2.04 | TODO: find correct BC | retained | BC/SD 2.04. |
| `DH_SU76CannonShell` | 76 mm BR-350B APHEBC | 1.55 |  | 662 | 6.5 | 0.97 | TODO: pls, check | retained | BC/SD 0.97. |
| `DH_SU76CannonShellAPCR` | 76 mm BR-350P APCR | 1.55 |  | 662 | 3.02 | 2.10 | TODO: pls, check | suspect, retained | See the ZiS-3 APCR row. |
| `DH_Sdkfz2341CannonShellAPCR` | 20 mm Pzgr.40 | 0.75 |  | 1050 | 0.1 | 2.11 | Guesstimate based on lower weight and higher velocity of shell | retained | BC/SD 2.11, near the HVAP band. |
| `DH_Semovente9053CannonShell` | 90 mm AP (90/53) | 3.2 |  | 758 | 10.1 | 1.80 | TODO: Find real value, currently using the flak88 as a basis | retained | BC/SD 1.80 (mass about 10.1 kg, not confirmed). Copied from Flak 88, which is consistent. |
| `DH_Semovente9053CannonShellHE` | 90 mm HE (90/53) | 2.5 |  | 830 | 10.3 | 1.38 | TODO: Find real value | retained | BC/SD 1.38 (mass not confirmed). |
| `DH_ShermanCannonShellHE` | 75 mm M48 HE | 2.8 |  | 619 | 6.62 | 1.67 | TODO: pls check - this is the APC shell's BC | retained | BC/SD 1.67. |
| `DH_ShermanCannonShellSmoke` | 75 mm M64 WP | 2.8 |  | 619 | 6.94 | 1.60 | TODO: pls check - this is the APC shell's BC | retained | BC/SD 1.60. |
| `DH_ShermanFireFlyCannonShell` | 17pdr Mk.IV APC | 2.45 |  | 884 | 7.71 | 1.30 | TODO: pls check | retained | BC/SD 1.30. |
| `DH_ShermanFireFlyCannonShellAPDS` | 17pdr Mk.I APDS | 1.47 |  | 1284 | - |  | TODO: pls check | retained | See the Achilles APDS row. |
| `DH_ShermanFireFlyCannonShellHE` | 17pdr Mk.I HE-T | 2.45 |  | 884 | 6.98 | 1.43 | TODO: pls check | retained | BC/SD 1.43. |
| `DH_ShermanM4A176WCannonShellSmoke` | 76 mm M88 HC smoke | 1.368 |  | 792 | 3.35 | 1.67 | TODO: this seems wrong, pls check | retained | BC/SD about 1.67 (mass not confirmed). The Wolverine smoke uses 1.627 for the same round. |
| `DH_ShermanM4A3105CannonShellHE` | 105 mm M1 HE | 2.96 |  | 472 | 14.97 | 1.53 | TODO: pls check | retained | BC/SD 1.53. Howitzer HE is blunter than gun HE. |
| `DH_ShermanM4A3105CannonShellHEAT` | 105 mm M67 HEAT | 2.96 |  | 381 | 13.26 | 1.73 | TODO: check BC | retained | BC/SD 1.73. |
| `DH_ShermanM4A3105CannonShellSmoke` | 105 mm M60 WP | 2.96 |  | 472 | 15.56 | 1.47 | same as 105mm HE or HEAT shells | retained | BC/SD 1.47. |
| `DH_StuH42CannonShellHE` | 105 mm F.H.Gr.38 | 2.96 |  | 495 | 14.81 | 1.55 | find correct BC - this is likely wrong | retained | BC/SD 1.55, same as the US 105 mm M1 HE. The mechanical table is tuned to it. |
| `DH_StuH42CannonShellSmoke` | 105 mm F.H.Gr.Nb. | 2.96 |  | 495 | 14.7 | 1.56 | same as 105mm HE or HEAT shells | retained | BC/SD about 1.56 (mass not confirmed). |
| `DH_StuartCannonShellHE` | 37 mm M63 HE | 0.984 |  | 792 | 0.73 | 1.30 | TODO: double check this | retained | BC/SD 1.30. |
| `DH_T3476CannonShell` | 76 mm BR-350B APHEBC | 1.55 |  | 662 | 6.5 | 0.97 | TODO: pls, check | retained | BC/SD 0.97. |
| `DH_T3476CannonShellAPCR` | 76 mm BR-350P APCR | 1.55 |  | 662 | 3.02 | 2.10 | TODO: pls, check | suspect, retained | See the ZiS-3 APCR row. |
| `DH_T3476CannonShellHE` | 76 mm OF-350 HE | 1.55 |  | 662 | 6.2 | 1.02 | TODO: find correct BC | retained | BC/SD 1.02. Sight tables are tuned to it. |
| `DH_T3476CannonShellSolid` | 76 mm BR-350SP solid shot | 1.55 |  | 662 | 6.3 | 1.00 | TODO: pls, check | retained | BC/SD 1.00, near blunt shot. |
| `DH_T3485CannonShellAPCR` | 85 mm BR-365P APCR | 2.0 |  | 792 | 3.05 | 3.33 | TODO: find correct BC | suspect, retained | Speed (792 m/s), BC and both sight tables copy the AP round. Real BR-365P is about 1050 m/s. Fix speed, BC and tables together. |
| `DH_T3485CannonShellHE` | 85 mm O-365 HE | 1.55 |  | 660 | 9.54 | 0.83 | find correct BC | retained | BC/SD 0.83, low but plausible for a blunt HE. Sight tables are tuned to it. |
| `DH_Tiger2BCannonShell` | 88 mm PzGr.39/43 | 3.8 |  | 1000 | 10.16 | 2.04 | TODO: find correct BC | retained | BC/SD 2.04. The model in README.md fits its table. |
| `DH_Tiger2BCannonShellAPCR` | 88 mm Pzgr.40/43 | 1.527 | 2.49 | 1130 | 7.3 | 1.86 | TODO: find correct BC - this is grossly incorrect | changed | Changed in the #30 commit, together with the sight table. |
| `DH_Tiger2BCannonShellHE` | 88 mm Sprgr.43 | 3.25 |  | 750 | 9.4 | 1.88 | TODO: find correct BC | retained | BC/SD 1.88. |
| `DH_TigerCannonShell` | 88 mm PzGr.39 | 3.3 |  | 800 | 10.2 | 1.76 | TODO: find correct BC | retained | BC/SD 1.76. |
| `DH_TigerCannonShellHE` | 88 mm Sprgr. L/4.5 | 2.4 |  | 820 | 9.0 | 1.45 | TODO: find correct BC | retained | BC/SD 1.45. |
| `DH_WolverineCannonShellHE` | 76 mm M42A1 HE (3 in M7) | 1.368 | 2.48 | 792 | 5.84 | 1.73 | TODO: find correct BC | changed | Old 1.368 gave BC/SD 0.96. The new value is the Hellcat HE value scaled by the verified M7/M1 APC ratio. No sight table depends on it. |
| `DH_WolverineCannonShellSmoke` | 76 mm M88 HC smoke | 1.627 |  | 792 | 3.35 | 1.98 | TODO: pls check | retained | BC/SD about 1.98 (mass not confirmed). The Sherman 76 smoke uses 1.368 for the same round. |
| `DH_AVT40Bullet` | 7.62x54R ball | 0.511 |  | 840 | - |  | TODO: was 0.37 in RO, why the change? | retained | RO used 0.37, the type L light ball. 0.511 is in the published G1 range for type D heavy ball. |
| `DH_DP27Bullet` | 7.62x54R ball | 0.511 |  | 840 | - |  | TODO: was 0.37 in RO, why the change? | retained | RO used 0.37, the type L light ball. 0.511 is in the published G1 range for type D heavy ball. |
| `DH_DP27LateBullet` | 7.62x54R ball | 0.511 |  | 840 | - |  | TODO: was 0.37 in RO, why the change? | retained | RO used 0.37, the type L light ball. 0.511 is in the published G1 range for type D heavy ball. |
| `DH_DT29Bullet` | 7.62x54R ball | 0.511 |  | 840 | - |  | TODO: was 0.37 in RO, why the change? | retained | RO used 0.37, the type L light ball. 0.511 is in the published G1 range for type D heavy ball. |
| `DH_M9530Bullet` | 8x56R M.30 S | 0.515 |  | 620 | - |  | to do: find the real one (this is taken from kar98) | retained | The 8x56R M.30 S spitzer (13.4 g) is close to the 7.92 mm sS bullet (12.8 g). The Kar98 value fits. |
| `DH_M9531Bullet` | 8x56R M.30 S | 0.515 |  | 620 | - |  | to do: find the real one (this is taken from kar98) | retained | The 8x56R M.30 S spitzer (13.4 g) is close to the 7.92 mm sS bullet (12.8 g). The Kar98 value fits. |
| `DH_SVT38Bullet` | 7.62x54R ball | 0.511 |  | 840 | - |  | TODO: was 0.37 in RO, why the change? | retained | RO used 0.37, the type L light ball. 0.511 is in the published G1 range for type D heavy ball. |
| `DH_SVT40Bullet` | 7.62x54R ball | 0.511 |  | 840 | - |  | TODO: was 0.37 in RO, why the change? | retained | RO used 0.37, the type L light ball. 0.511 is in the published G1 range for type D heavy ball. |

## Follow-up items found in the audit

- 75 mm M48 HE has two BCs: Sherman 2.8 and Cromwell 1.686. Recalibrate the Cromwell table before the values are aligned.
- 76 mm M88 smoke has two BCs: Sherman 76 1.368 and Wolverine 1.627.
- 76 mm M42A1 HE on the Sherman 76 uses 3.21, the APC value. The Hellcat now uses 2.79.
- 88 mm PzGr.39 (3.3) and PzGr.39/43 (3.8) are near identical shells with different BCs. Both sit inside the verified band.
- The Soviet APCR classes (BR-350P, BR-365P) copy the AP speed, BC and sight tables. A real fix changes all three together and recalibrates in game.
- The 17pdr APDS `ShellDiameter` is 5.0 on the Achilles and 5.7 on the Firefly.
- After any future BC change, recalibrate the sight table in game with the auto range debug tool in `DHVehicleCannon`.
