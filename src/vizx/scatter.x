```
title: Scatter charts
summary: Numeric Cartesian points with a configurable uniform marker radius.
```

import (Figure, dimensions, document) from .figure
import (Domain, paired, domain) from .scales
import axes from .axes
import (color, circle) from .svg

fn scatter(x: list[f64], y: list[f64], title: str = "Scatter chart", width: i32 = 720, height: i32 = 460, color_index: i32 = 2, marker_size: f64 = 5.0) -> Figure:
  dimensions(width, height)
  size: i32 = paired(x, y)
  if !(marker_size >= 1.0 && marker_size <= 20.0):
    raise ValueError("vizx marker_size must be a finite radius from 1 to 20")
  fill: str = color(color_index)
  xd: Domain = domain(x)
  yd: Domain = domain(y)
  right: f64 = cast(width, f64) - 30.0
  bottom: f64 = cast(height, f64) - 55.0
  body: str = axes(xd, yd, right, bottom)
  index: i32 = 0
  while index < size:
    body = body + circle(xd.map(x[index], 78.0, right), yd.map(y[index], bottom, 70.0), marker_size, fill)
    index = index + 1
  return document(body, title, width, height)
