# -*- coding: utf-8 -*-
"""解析 styles.xml / numbering.xml，找出带编号（项目符号）的段落样式"""
import zipfile
from lxml import etree
from collections import Counter

W = '{http://schemas.openxmlformats.org/wordprocessingml/2006/main}'
DOCS = {
    'report': r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计报告-202301190144-袁文平.docx',
    'work': r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计作品-202301190144-袁文平-实训作品.docx',
}

for k, p in DOCS.items():
    print('#####', k)
    z = zipfile.ZipFile(p)
    sty = etree.fromstring(z.read('word/styles.xml'))
    # numId -> abstractNumId
    num2abs = {}
    abs_def = {}
    if 'word/numbering.xml' in z.namelist():
        num = etree.fromstring(z.read('word/numbering.xml'))
        for n in num.findall(W + 'num'):
            num2abs[n.get(W + 'numId')] = n.find(W + 'abstractNumId').get(W + 'val')
        for a in num.findall(W + 'abstractNum'):
            aid = a.get(W + 'abstractNumId')
            lvl = a.find(W + 'lvl')
            fmt = lvl.find(W + 'numFmt').get(W + 'val') if lvl is not None else '?'
            txt = lvl.find(W + 'lvlText').get(W + 'val') if lvl is not None else '?'
            abs_def[aid] = (fmt, txt)
    for s in sty.findall(W + 'style'):
        if s.get(W + 'type') != 'paragraph':
            continue
        pPr = s.find(W + 'pPr')
        if pPr is None:
            continue
        npr = pPr.find(W + 'numPr')
        if npr is None:
            continue
        nid = npr.find(W + 'numId')
        nid = nid.get(W + 'val') if nid is not None else '?'
        name = s.find(W + 'name')
        name = name.get(W + 'val') if name is not None else '?'
        based = s.find(W + 'basedOn')
        based = based.get(W + 'val') if based is not None else ''
        absid = num2abs.get(nid, '?')
        print('  style id=%s name=%s based=%s numId=%s abs=%s def=%s' %
              (s.get(W + 'styleId'), name, based, nid, absid, abs_def.get(absid)))
    # 统计正文中段落使用情况
    doc = etree.fromstring(z.read('word/document.xml'))
    cnt = Counter()
    for par in doc.iter(W + 'p'):
        pPr = par.find(W + 'pPr')
        sid = ''
        if pPr is not None:
            ps = pPr.find(W + 'pStyle')
            if ps is not None:
                sid = ps.get(W + 'val')
        cnt[sid] += 1
    print('  paragraph styles:', cnt.most_common(8))
