# -*- coding: utf-8 -*-
import sys
import pymupdf
from PIL import Image
import io

pdf = sys.argv[1]
out = sys.argv[2]
cols = int(sys.argv[3]) if len(sys.argv) > 3 else 5
doc = pymupdf.open(pdf)
thumbs = []
for pg in doc:
    pix = pg.get_pixmap(dpi=40)
    thumbs.append(Image.open(io.BytesIO(pix.tobytes('png'))))
w, h = thumbs[0].size
rows = (len(thumbs) + cols - 1) // cols
sheet = Image.new('RGB', (cols * w, rows * h), 'white')
for i, im in enumerate(thumbs):
    sheet.paste(im, ((i % cols) * w, (i // cols) * h))
sheet.save(out)
print(out, sheet.size, len(thumbs))
