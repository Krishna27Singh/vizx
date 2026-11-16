```
title: Line charts
summary: Connects numeric coordinates in input order, without sorting.
```

import (Figure, dimensions, document) from .figure
import (Domain, paired, domain) from .scales
import axes from .axes
import (color, segment, circle) from .svg

fn line(x: list[f64], y: list[f64], title: str = "Line chart", width: i32 = 720, height: i32 = 460, color_index: i32 = 1) -> Figure:
  dimensions(width, height)
  size: i32 = paired(x, y)
  fill: str = color(color_index)
  xd: Domain = domain(x)
  yd: Domain = domain(y)
  right: f64 = cast(width, f64) - 30.0
  bottom: f64 = cast(height, f64) - 55.0
  body: str = axes(xd, yd, right, bottom)
  index: i32 = 0
  while index < size:
    px: f64 = xd.map(x[index], 78.0, right)
    py: f64 = yd.map(y[index], bottom, 70.0)
    if index > 0:
      body = body + segment(xd.map(x[index - 1], 78.0, right), yd.map(y[index - 1], bottom, 70.0), px, py, fill, 2.5)
    body = body + circle(px, py, 3.5, fill)
    index = index + 1
  return document(body, title, width, height)
