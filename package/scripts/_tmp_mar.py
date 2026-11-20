# -*- coding: utf-8 -*-
import docx
from docx.oxml.ns import qn

p = r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计报告-202301190144-袁文平.docx'
d = docx.Document(p)
for i, s in enumerate(d.sections):
    tw = s.page_width.twips
    print('sec', i, 'page', tw, 'left', s.left_margin.twips, 'right', s.right_margin.twips,
          'usable', tw - s.left_margin.twips - s.right_margin.twips)
