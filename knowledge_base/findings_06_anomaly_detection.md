## 5 · Findings

**40 flags in total, across 23 trips.** Five trips are flagged by more than one detector: B09 (3), A04, A08, B02 and B10.

**A · Battery resistance:** 18 of 556 sag events (3 %) show a resistance well above what their temperature predicts (up to 1.8×).
- They cluster in TripB14 (6 events) and TripB25 (4 events). Clustering points to a persistent battery state during
  those minutes, not single noisy readings.
- The clustered events (B14, B25) and the B09 events, 11 of the 18, sit at **SoC below 50 %**, and most flags occur at
  moderate current (about 100 A), where the estimate is noisier. The expected curve models temperature only, so the
  most likely explanation for the clusters is the extra resistance at lower SoC. Adding SoC to the expected curve
  is the next refinement.

**B · Unexpected consumption: no trip flagged.**
- The leave-one-out model explains every trip's consumption within the limit (largest |z| is 2.5, mean error 1.3 kWh/100 km).
- Once temperature, speed, time stopped and climate load are known, no trip used unexplained energy. That is a useful
  negative result: there is no hidden consumption problem in this vehicle's data.

**C · Unusual trip profile:** 7 trips (10 %) are unusual for their season, each with a readable reason:
- **TripB13:** regeneration share high for winter, with a warmer battery than usual.
- **TripA04:** very fast battery warm-up on a short, fast trip (about 103 km/h on average).
- **TripB09 and TripB10:** many voltage-sag events. B09 includes charging, and B10 is a highway trip in the cold.
- **TripA08:** a lot of time stopped.

**D · Signal quality:** 15 recordings carry known logging problems:
- **10 summer trips:** stale CAN heating values.
- **4 winter trips:** SoC not logged towards the end.
- **TripB02:** the real 23–26 kW heating event, which should be checked against heater control.

**Root-cause notes** are generated for every flag (`anomaly.flags.reason`). They state the measured value against
the expected value and the conditions that most likely explain it.