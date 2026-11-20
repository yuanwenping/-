# -*- coding: utf-8 -*-
import docx
from docx.oxml.ns import qn

paths = [
    r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计作品-202301190144-袁文平-实训作品.docx',
]
for p in paths:
    d = docx.Document(p)
    print('#####', p)
    cnt = 0
    for i, par in enumerate(d.paragraphs):
        pPr = par._p.pPr
        has = pPr is not None and pPr.find(qn('w:numPr')) is not None
        if has:
            cnt += 1
            if cnt <= 20:
                print(i, par.style.name, repr(par.text[:40]))
    print('numPr total', cnt)
