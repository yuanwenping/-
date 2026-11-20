# -*- coding: utf-8 -*-
import re
import docx
from lxml import etree
from docx.oxml.ns import qn

p = r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计作品-202301190144-袁文平-实训作品.docx'
d = docx.Document(p)
for i, el in enumerate(d.element.body.iterchildren()):
    t = ''.join(x.text or '' for x in el.iter(qn('w:t')))
    if t.strip() in ('4.3 区块链设计', '4.3.1 区块链网络'):
        print('=== block', i, repr(t))
        x = etree.tostring(el, pretty_print=True).decode()
        x = re.sub(r' xmlns:[a-zA-Z0-9]+="[^"]*"', '', x)
        print(x[:2500])
