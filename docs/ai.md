# AI Anomaly Detection

## Overview
This module adds intelligence to the CloudOps platform by detecting unusual behavior in system metrics (CPU, memory, latency). It helps prevent outages and supports predictive scaling.

## Example Script
```python
import pandas as pd
from sklearn.ensemble import IsolationForest

# Sample CPU usage data
data = pd.DataFrame({"cpu":[20,22,19,95,21,20]})

# Train anomaly detection model
model = IsolationForest(contamination=0.1)
model.fit(data)

# Predict anomalies (-1 = anomaly, 1 = normal)
print("Anomaly detection results:", model.predict(data))
