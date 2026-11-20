# -*- coding: utf-8 -*-
import zipfile
from lxml import etree

W = '{http://schemas.openxmlformats.org/wordprocessingml/2006/main}'
WP = '{http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing}'
DOCS = {
    'report': r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计报告-202301190144-袁文平.docx',
    'work': r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计作品-202301190144-袁文平-实训作品.docx',
}
for k, p in DOCS.items():
    z = zipfile.ZipFile(p)
    doc = etree.fromstring(z.read('word/document.xml'))
    inl = len(doc.findall('.//' + WP + 'inline'))
    anc = len(doc.findall('.//' + WP + 'anchor'))
    print(k, 'inline', inl, 'anchor', anc)
    # 表格环绕属性
    tbls = doc.findall('.//' + W + 'tbl')
    wrapped = 0
    for t in tbls:
        tp = t.find(W + 'tblPr')
        if tp is not None:
            ta = tp.find(W + 'tblpPr')
            if ta is not None:
                wrapped += 1
    print('  tables', len(tbls), 'floating', wrapped)
