```
title: Data and scale contracts
summary: Validates pairing and finite bounds before rendering or indexing.
```

import (Domain, paired, domain) from vizx.scales

fn test_domains_and_pair_validation() -> none:
  x: list[f64]
  y: list[f64]
  caught: bool = false
  try:
    paired(x, y)
  except ValueError:
    caught = true
  assert caught
  x.append(1.0)
  caught = false
  try:
    paired(x, y)
  except ValueError:
    caught = true
  assert caught
  y.append(0.0 - 4.0)
  assert paired(x, y) == 1
  yd: Domain = domain(y, true)
  assert yd.low == (0.0 - 4.0)
  assert yd.high == 0.0
  assert yd.map(0.0, 100.0, 0.0) == 0.0
  assert yd.map(0.0 - 4.0, 100.0, 0.0) == 100.0
  constant: Domain = domain(x)
  assert constant.low < 1.0
  assert constant.high > 1.0
  huge: f64 = 1.0
  for power in range(0, 16):
    huge = huge * 10000000000.0
  x.append(huge)
  y.append(1.0)
  caught = false
  try:
    paired(x, y)
  except ValueError:
    caught = true
  assert caught
