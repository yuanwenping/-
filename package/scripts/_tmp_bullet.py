# -*- coding: utf-8 -*-
import pymupdf

pdfs = {
    'report': r'E:/毕业项目实训/pakeage/docs/预览/报告预览.pdf',
    'work': r'E:/毕业项目实训/pakeage/docs/预览/实训作品预览.pdf',
}
chrs = ['\u2022', '\u00b7', '\u25cf', '\u25aa', '\u25a0', '\u2023', '\u2219', '\u00b0']
for k, p in pdfs.items():
    doc = pymupdf.open(p)
    print('#####', k, len(doc))
    for i, pg in enumerate(doc, 1):
        t = pg.get_text()
        for c in chrs:
            if c in t:
                cnt = t.count(c)
                print('  page', i, 'char', hex(ord(c)), 'count', cnt)
    # list bullets via drawing? skip
