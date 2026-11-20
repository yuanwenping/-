# -*- coding: utf-8 -*-
import docx
from docx.oxml.ns import qn

p = r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计报告-202301190144-袁文平.docx'
d = docx.Document(p)
kids = list(d.element.body.iterchildren())
for i in range(3, 22):
    el = kids[i]
    sec = el.find('.//' + qn('w:sectPr'))
    bk = el.findall('.//' + qn('w:bookmarkStart'))
    t = ''.join(x.text or '' for x in el.findall('.//' + qn('w:t')))
    print(i, el.tag.split('}')[1], 'sectPr' if sec is not None else '', 'bm=%d' % len(bk), repr(t[:40]))
