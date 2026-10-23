# Trip report TripB25
TripB25 is a winter trip on 2020-01-11 (Munich North, weather: slightly cloudy). It covered 13.5 km in 17 minutes: 14 min driving, 3 min stopped.
Mean outside temperature while driving was 5.7 °C. The battery started at 10 °C and warmed by 3 °C.
Energy: consumption 18.9 kWh per 100 km; 2.93 kWh drawn from the battery, 0.38 kWh recovered by regenerative braking (13 % of drawn energy), 0.31 kWh used for cabin heating (10 % of drawn energy).
Battery: 7 heavy-load voltage-sag events, median apparent pack resistance 196 mΩ.
This trip was a locked test trip for the SoC model; the model's mean error on it was 2.2 SoC points.
Anomaly flags (4):
- A · battery resistance: resistance 224 mΩ vs about 121 mΩ expected at 12 °C (1.8×); SoC 39 %: the expected curve ignores SoC, and resistance is higher in the lower half; moderate current (101 A), so the estimate is noisier; 4 flagged events in this trip: a persistent state, not a one-off spike
- A · battery resistance: resistance 204 mΩ vs about 116 mΩ expected at 13 °C (1.8×); SoC 41 %: the expected curve ignores SoC, and resistance is higher in the lower half; moderate current (108 A), so the estimate is noisier; 4 flagged events in this trip: a persistent state, not a one-off spike
- A · battery resistance: resistance 196 mΩ vs about 116 mΩ expected at 13 °C (1.7×); SoC 40 %: the expected curve ignores SoC, and resistance is higher in the lower half; 4 flagged events in this trip: a persistent state, not a one-off spike
- A · battery resistance: resistance 197 mΩ vs about 121 mΩ expected at 12 °C (1.6×); SoC 41 %: the expected curve ignores SoC, and resistance is higher in the lower half; moderate current (114 A), so the estimate is noisier; 4 flagged events in this trip: a persistent state, not a one-off spike