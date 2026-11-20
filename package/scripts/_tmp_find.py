# -*- coding: utf-8 -*-
import sys
import pymupdf

pdf = sys.argv[1]
doc = pymupdf.open(pdf)
for i, pg in enumerate(doc, 1):
    txt = pg.get_text().replace('\n', ' ')
    for kw in ('图3.1', '表3.1', '图3.2', '表3.2', '图4.1', '图3.8'):
        if kw in txt:
            idx = txt.find(kw)
            print(i, kw, repr(txt[max(0, idx - 30):idx + 40]))
