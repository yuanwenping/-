# -*- coding: utf-8 -*-
import pymupdf

doc = pymupdf.open(r'E:/毕业项目实训/pakeage/docs/预览/报告预览.pdf')
pg = doc[0]
print('page size', pg.rect)
for d in pg.get_drawings():
    r = d['rect']
    if r.height < 2 and r.width > 40:
        print('hline x0=%.1f x1=%.1f y=%.1f w=%.1f' % (r.x0, r.x1, r.y0, r.width))
