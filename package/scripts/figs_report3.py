# -*- coding: utf-8 -*-
"""报告用代码节选图：干净收尾 + 更大字号"""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
import figs_code_pil as F

ROOT = r'E:\毕业项目实训\pakeage'
PNG = os.path.join(ROOT, 'docs', '图片')


def excerpt(rel, start_line, end_line, limit=78):
    path = os.path.join(ROOT, rel)
    raw = open(path, encoding='utf-8').read().splitlines()
    out = [l.replace('\t', '    ').rstrip() for l in raw[start_line - 1:end_line]]
    widths = [len(l) - len(l.lstrip(' ')) for l in out if l.strip()]
    cut = min(widths) if widths else 0
    out = [l[cut:] if l.strip() else '' for l in out]
    return F.wrap(out, limit=limit)


F.render(excerpt(r'chaincode\tracecc\contract.go', 111, 130),
         os.path.join(PNG, 'figr_4.png'), size=22)

lines5 = excerpt(r'backend\src\main\java\com\changde\trace\trace\TraceService.java', 421, 441)
lines5.append('    // ……（事务内回填交易编号、区块高度与批次末态，略）')
F.render(lines5, os.path.join(PNG, 'figr_5.png'), size=22)
