## 6 · Findings

**Selected model for both tasks: the stacked ensemble.** It had the lowest cross-validated error in both tasks, and
the gain holds on the 14 locked test trips.

| Task | Stacked ensemble on unseen test trips | Best single model in cross-validation |
|---|---|---|
| A · SoC estimation | **MAE 2.12 SoC points, R² 0.96** | Polynomial Ridge (tuned), CV MAE 2.46 |
| B · segment energy | **MAE 1.99 kWh/100 km, R² 0.76** | MLP (tuned), CV MAE 3.02 |

**1. Blending different model families beats any single model.**
- For SoC, the stack weights polynomial Ridge most (0.53), then Ridge, LightGBM and the MLP.
- For segment energy it blends polynomial Ridge, MLP, Ridge and XGBoost.
- The linear models capture the near-linear battery physics. The tree and neural models add the non-linear parts the linear models miss.

**2. Linear models lead the single-model ranking for SoC.** Terminal voltage is close to open-circuit voltage(SoC)
minus current × resistance. Polynomial Ridge adds the curvature of the voltage–SoC relationship, and tree models
cannot extrapolate to voltage and temperature combinations from unseen trips.

**3. Hyperparameter tuning helped only a little (0–3 %).**
- Optuna (TPE) tuned the top 3 models of each task.
- The best gain was polynomial Ridge for SoC, from 2.53 to 2.46.
- This is an honest result: with sensible defaults, the limit is the information in the signals, not the settings.
- Because the top 3 for SoC were all linear, the tree models were not tuned. They still contribute through the stack.

**4. Cross-validation and test scores differ for Task B,** because a few extreme training segments sit in the
cross-validation folds (the 23 kW heating event in TripB02, a downhill segment that recovered energy). They inflate
the cross-validated RMSE of every model. The ranking was decided on cross-validation before the test set was opened.

**5. Where the models still fail:** a cold battery and low SoC for Task A, and short or winter segments for Task B.
This is the same pattern as before, and it matches the temperature-dependent resistance found in notebook 04.

**What drives the predictions** (permutation importance on the test trips): voltage features dominate SoC estimation,
and heating power dominates energy per km.

**Limitations**
- 70 trips from one car, so the test set has only 14 trips.
- Recorded SoC is itself a BMS estimate, not a lab ground truth.
- The stack's own cross-validated score reuses the same folds as its base models, so it is slightly optimistic.
  The untouched test set confirms it.