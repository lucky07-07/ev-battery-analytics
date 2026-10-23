**Reading the cross-checks**
- Integrated distance matches the overview for every trip except **TripA30**. The overview rows for A30 and A31 also
  share a start time, and A31's end SoC in the overview contradicts its own file, so those two overview rows look
  partly copy-pasted. **The values integrated from the signals are used from here on;** the overview figures
  stay for reference only.
- Net battery energy follows SoC used almost perfectly. The slope implies a full battery of roughly 22 kWh,
  in line with the rated energy of the BMW i3 60 Ah pack (about 21.6 kWh). The power integration can be trusted.

## 8 · Summary

- **Smoothing:** Savitzky-Golay over 2 s keeps the depth of current and power peaks, while a moving average
  flattens them. Savitzky-Golay is therefore used for `voltage_smooth_v`, `current_smooth_a` and `power_smooth_kw`.
- **Segments:** 1,193 continuous phases (566 driving, 625 stopped, 2 charging). The 2 s merge relabelled only 0.2 % of samples.
- **Voltage sag:** 556 heavy-load events. Winter events are deeper, and the apparent pack resistance is clearly
  higher in the cold, which is a physical effect, not noise.
- **Temperature rise:** winter trips start colder and warm up faster per hour of driving than summer trips.
- **Energy:** per-trip energy used, recovered, charged and spent on heating, plus consumption per 100 km. Two independent
  checks confirm the integration: distance matches the overview, and battery energy tracks SoC used.
  The one mismatch (TripA30) is an error in the overview sheet.

Interpreting these patterns is the job of the next step, EDA.