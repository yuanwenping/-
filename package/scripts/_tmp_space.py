# -*- coding: utf-8 -*-
import docx
from docx.oxml.ns import qn

p = r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计报告-202301190144-袁文平.docx'
d = docx.Document(p)
kids = list(d.element.body.iterchildren())
prev = ''
for i, el in enumerate(kids):
    if el.tag != qn('w:p'):
        prev = 'TBL'
        continue
    t = ''.join(x.text or '' for x in el.findall('.//' + qn('w:t')))
    if t and not t.strip():
        print(i, 'space-only', repr(t[:20]), 'prev=', prev[:30])
    prev = t.strip()[:30] or ('EMPTY' if not t else '')
