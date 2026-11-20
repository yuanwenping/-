# -*- coding: utf-8 -*-
import docx
from docx.oxml.ns import qn

p = r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计报告-202301190144-袁文平.docx'
d = docx.Document(p)
body = d.element.body
for tag in ('w:ins', 'w:del', 'w:commentReference', 'w:sdt', 'w:fldSimple', 'w:bookmarkStart',
            'w:inline', 'w:anchor', 'w:numPr', 'w:numId'):
    n = len(body.findall('.//' + qn(tag)))
    print(tag, n)
# 图片段落 drawing 详情
for i, el in enumerate(body.iterchildren()):
    ds = el.findall('.//' + qn('w:drawing'))
    if ds:
        for dr in ds:
            inl = dr.findall('.//' + qn('wp:inline'))
            anc = dr.findall('.//' + qn('wp:anchor'))
            print('block', i, 'inline', len(inl), 'anchor', len(anc))
