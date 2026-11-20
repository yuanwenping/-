# -*- coding: utf-8 -*-
import docx
from docx.oxml.ns import qn

DOCS = {
    'report': r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计报告-202301190144-袁文平.docx',
    'work': r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计作品-202301190144-袁文平-实训作品.docx',
}
for k, p in DOCS.items():
    d = docx.Document(p)
    body = d.element.body
    kids = list(body.iterchildren())
    print('#####', k, 'blocks', len(kids))
    hits = []
    for i, el in enumerate(kids):
        if el.tag != qn('w:p'):
            if el.tag == qn('w:tbl'):
                tb = ''.join(x.text or '' for x in el.iter(qn('w:t')))[:18]
                print('  tbl@%d %r' % (i, tb))
            continue
        t = ''.join(x.text or '' for x in el.findall('.//' + qn('w:t')))
        if t and not t.strip():
            hits.append((i, t))
    print('  whitespace-only paras:', len(hits))
    for i, t in hits[:30]:
        print('    i=%d len=%d %r' % (i, len(t), t[:12]))
