# -*- coding: utf-8 -*-
import docx
from docx.oxml.ns import qn

p = r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计报告-202301190144-袁文平.docx'
d = docx.Document(p)
kids = list(d.element.body.iterchildren())
for i in range(60, 120):
    ch = kids[i]
    tag = ch.tag.split('}')[1]
    t = ''.join(x.text or '' for x in ch.findall('.//' + qn('w:t')))
    has_img = len(ch.findall('.//' + qn('w:drawing')))
    sty = ch.find(qn('w:pPr') + '/' + qn('w:pStyle'))
    sv = sty.get(qn('w:val')) if sty is not None else '-'
    print(i, tag, 'sty=%s' % sv, 'img=%d' % has_img, repr(t[:45]))
