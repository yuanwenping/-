# -*- coding: utf-8 -*-
import docx, re, sys
from lxml import etree
from docx.oxml.ns import qn

p = r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计报告-202301190144-袁文平.docx'
d = docx.Document(p)
kids = list(d.element.body.iterchildren())
for i in (70, 71, 73, 79):
    print('=== block', i, kids[i].tag.split('}')[1])
    x = etree.tostring(kids[i], pretty_print=True).decode()
    x = re.sub(r' xmlns:[a-zA-Z0-9]+="[^"]*"', '', x)
    print(x[:1500])
