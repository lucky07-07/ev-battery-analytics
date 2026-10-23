### 3.2 SoC gaps: fill only what can be filled honestly

Each SoC gap is one block of consecutive missing samples. SoC changes slowly, so short gaps of up to 5 s are filled:
- **inside a trip:** linear interpolation between the values on either side
- **at the first or last sample of a trip:** the nearest recorded value (many trips miss SoC only in their very last sample)

Longer gaps are left missing and flagged, because a guessed SoC would contaminate the models.

### 3.3 Heating-power "spike" in TripB02: checked, kept

Notebook 01 flagged heating power up to about 39 kW in TripB02, against about 7 kW in every other trip.
Before removing it, check it against the independent signals that measure the same thing.

### 3.5 Stale CAN heating-power readings (found during EDA)

The EDA in notebook 04 showed a summer trip (TripA06, about 30 °C outside) with a mean "heating power" of 5.3 kW.
In that trip the CAN heating signal stays frozen at 5.32 kW while the **requested** heating power is 0 and the battery
current is far too low to feed a 5 kW heater. The CAN value was held, not measured.

**Rule:** CAN heating power above 0.5 kW while the requested heating power is below 100 W is set to missing and
flagged `heating_can_invalid`. The check below shows the rule only fires in summer trips; in winter, the CAN value
agrees with the request and the LIN signal.

## 9 · Summary

- **Schema:** 49 raw headers (summer and winter variants, typos and a duplicate) mapped to one clean schema of named, unit-suffixed columns.
  Winter-only signals stay empty for summer trips.
- **Fixes:** each one is in `meta.cleaning_log` and `reports/02_cleaning_log.csv`:
  - one out-of-range SoC value set to missing;
  - short SoC gaps of up to 5 s filled (mostly a single missing first or last sample), and the four long gaps (B07, B09, B28, B34) left missing and flagged;
  - the TripB02 heating event kept, because four independent signals confirm it, and flagged instead;
  - the coolant-flow offset converted;
  - stale CAN heating-power readings in summer trips (heating reported while none was requested) set to missing and flagged. This was found in the EDA, notebook 04.
- **Header issues** are solved by the column map. The **SoC jump** in TripB14 came from the same final-row zero, so it is fixed by 3.1.
  The **trip count** (70, not 72) needs no fix.
- **Phases:** every sample is labelled `driving`, `stopped` or `charging`, so charging no longer mixes into driving analysis.
- **Warehouse:** `data/warehouse/volvo.duckdb` (raw, clean and meta schemas). All data-quality checks pass, and the notebook stops if one fails.