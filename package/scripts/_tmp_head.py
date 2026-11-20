# -*- coding: utf-8 -*-
import pymupdf

doc = pymupdf.open(r'E:/毕业项目实训/pakeage/docs/预览/报告预览.pdf')
for pno in (4, 9, 10):
    pg = doc[pno - 1]
    print('=== page', pno)
    for b in pg.get_text('dict')['blocks']:
        for l in b.get('lines', []):
            for s in l['spans']:
                t = s['text']
                if t.strip() and ('设计目的' in t or '系统设计' in t or '需求分析' in t or t.strip()[0] in '1234567'):
                    print('  span x0=%.1f y=%.1f size=%.1f font=%s %r' %
                          (s['bbox'][0], s['bbox'][1], s['size'], s['font'], t[:24]))
    # 找小尺寸矢量图形（可能是方块符号）
    small = []
    for d in pg.get_drawings():
        r = d['rect']
        if 1 < r.width < 12 and 1 < r.height < 12:
            small.append((round(r.x0, 1), round(r.y0, 1), round(r.width, 1), round(r.height, 1), d['type']))
    if small:
        print('  small drawings:', small[:10])
    imgs = pg.get_images(full=True)
    if imgs:
        print('  images:', len(imgs))
