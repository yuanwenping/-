# -*- coding: utf-8 -*-
import sys
import fitz

pdf = sys.argv[1]
pages = [int(x) for x in sys.argv[2].split(',')]
tag = sys.argv[3]
doc = fitz.open(pdf)
for n in pages:
    pg = doc[n - 1]
    pix = pg.get_pixmap(dpi=110)
    out = 'docs/预览/%s_%d.png' % (tag, n)
    pix.save(out)
    print(out, pix.width, pix.height)
