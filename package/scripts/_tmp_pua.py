# -*- coding: utf-8 -*-
import pymupdf

pdfs = {
    'report': r'E:/毕业项目实训/pakeage/docs/预览/报告预览.pdf',
    'work': r'E:/毕业项目实训/pakeage/docs/预览/实训作品预览.pdf',
}
for k, p in pdfs.items():
    doc = pymupdf.open(p)
    print('#####', k)
    for i, pg in enumerate(doc, 1):
        for b in pg.get_text('dict')['blocks']:
            for l in b.get('lines', []):
                for s in l['spans']:
                    for ch in s['text']:
                        o = ord(ch)
                        if 0xE000 <= o <= 0xF8FF or 0x2000 <= o <= 0x206F:
                            print('  p%d font=%s ch=U+%04X %r span=%r' %
                                  (i, s['font'], o, ch, s['text'][:30]))
