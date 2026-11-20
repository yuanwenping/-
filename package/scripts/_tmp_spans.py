# -*- coding: utf-8 -*-
import pymupdf

doc = pymupdf.open(r'E:/毕业项目实训/pakeage/docs/预览/报告预览.pdf')
pg = doc[0]
for b in pg.get_text('dict')['blocks']:
    for l in b.get('lines', []):
        for s in l['spans']:
            t = s['text'].strip()
            if t:
                print('x0=%.1f x1=%.1f y=%.1f size=%.1f %r' % (s['bbox'][0], s['bbox'][2], s['bbox'][1], s['size'], t[:30]))
print('---')
print('page w', pg.rect.width)
for d in pg.get_drawings():
    r = d['rect']
    if r.width > 40:
        print('draw x0=%.1f x1=%.1f y=%.1f' % (r.x0, r.x1, r.y0))
