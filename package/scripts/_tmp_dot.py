# -*- coding: utf-8 -*-
import docx
from docx.oxml.ns import qn

paths = {
    'report': r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计报告-202301190144-袁文平.docx',
    'work': r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计作品-202301190144-袁文平-实训作品.docx',
}
bad = '\u2022\u00b7\u25cf\u25aa\u25a0\u2023\u2219'
for k, p in paths.items():
    d = docx.Document(p)
    print('#####', k)
    n = 0
    for i, par in enumerate(d.paragraphs):
        t = par.text
        if t and (t[0] in bad or t.lstrip()[:1] in bad):
            n += 1
            print('  dot-para', i, repr(t[:50]))
    # sym elements
    syms = d.element.body.findall('.//' + qn('w:sym'))
    print('  w:sym count', len(syms))
    for s in syms[:10]:
        print('   ', s.get(qn('w:font')), s.get(qn('w:char')))
    # paragraphs with numPr in numbering.xml numId mapping for list bullets
    print('  dot paras', n)
