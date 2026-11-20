# -*- coding: utf-8 -*-
"""组装课程设计报告：专业综合实践-课程设计报告-202301190144-袁文平.docx"""
import copy
import os
import shutil
import sys

import docx
from docx.oxml import OxmlElement
from docx.oxml.ns import qn
from docx.shared import Cm

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from report_content import COVER, CONTENT

SRC = r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计报告-202301190144-袁文平.docx'
BAK = r'E:/毕业项目实训/pakeage/docs/模板备份/专业综合实践-课程设计报告-模板备份.docx'
IMGDIR = r'E:/毕业项目实训/pakeage/docs/图片'
OUT = SRC

TOTAL_TW = 8500          # 正文可用宽度（twips）


# ---------------------------------------------------------------- 基础工具
def ptext(el):
    return ''.join(t.text or '' for t in el.iter(qn('w:t')))


def strip_sectpr(p_el):
    pPr = p_el.find(qn('w:pPr'))
    if pPr is None:
        return
    for s in pPr.findall(qn('w:sectPr')):
        pPr.remove(s)


def set_para_text(p_el, text):
    runs = p_el.findall(qn('w:r'))
    if not runs:
        r = OxmlElement('w:r')
        p_el.append(r)
        runs = [r]
    first = runs[0]
    for r in runs[1:]:
        p_el.remove(r)
    for t in first.findall(qn('w:t')):
        first.remove(t)
    t = OxmlElement('w:t')
    t.set(qn('xml:space'), 'preserve')
    t.text = text
    first.append(t)
    return p_el


def set_cell_text(cell, text):
    """保留单元格原有字体格式，仅替换文字"""
    ps = cell.findall(qn('w:p'))
    for extra in ps[1:]:
        cell.remove(extra)
    p = ps[0]
    runs = p.findall(qn('w:r'))
    if runs:
        first = runs[0]
        rPr = first.find(qn('w:rPr'))
        if rPr is not None:
            for c in rPr.findall(qn('w:color')):
                rPr.remove(c)
        for r in runs[1:]:
            p.remove(r)
        for t in first.findall(qn('w:t')):
            first.remove(t)
        for br in first.findall(qn('w:br')):
            first.remove(br)
        t = OxmlElement('w:t')
        t.set(qn('xml:space'), 'preserve')
        t.text = str(text).replace('\n', '')
        first.append(t)
    else:
        r = OxmlElement('w:r')
        rPr = OxmlElement('w:rPr')
        rf = OxmlElement('w:rFonts')
        rf.set(qn('w:ascii'), 'Times New Roman')
        rf.set(qn('w:eastAsia'), '宋体')
        rf.set(qn('w:hAnsi'), 'Times New Roman')
        rPr.append(rf)
        sz = OxmlElement('w:sz')
        sz.set(qn('w:val'), '21')
        rPr.append(sz)
        r.append(rPr)
        t = OxmlElement('w:t')
        t.set(qn('xml:space'), 'preserve')
        t.text = str(text).replace('\n', '')
        r.append(t)
        p.append(r)


# ---------------------------------------------------------------- 段落构造
def new_para(text, *, size=21, bold=False, jc=None, first_line=False,
             before=0, after=0, line=240, keep_next=False, eastasia='宋体'):
    p = OxmlElement('w:p')
    pPr = OxmlElement('w:pPr')
    if keep_next:
        pPr.append(OxmlElement('w:keepNext'))
    sp = OxmlElement('w:spacing')
    sp.set(qn('w:before'), str(before))
    sp.set(qn('w:after'), str(after))
    sp.set(qn('w:line'), str(line))
    sp.set(qn('w:lineRule'), 'auto')
    pPr.append(sp)
    if first_line:
        ind = OxmlElement('w:ind')
        ind.set(qn('w:firstLineChars'), '200')
        ind.set(qn('w:firstLine'), str(int(size * 10 * 2 / 2)))
        pPr.append(ind)
    if jc:
        e = OxmlElement('w:jc')
        e.set(qn('w:val'), jc)
        pPr.append(e)
    p.append(pPr)

    r = OxmlElement('w:r')
    rPr = OxmlElement('w:rPr')
    rf = OxmlElement('w:rFonts')
    rf.set(qn('w:ascii'), 'Times New Roman')
    rf.set(qn('w:eastAsia'), eastasia)
    rf.set(qn('w:hAnsi'), 'Times New Roman')
    rf.set(qn('w:cs'), 'Times New Roman')
    rPr.append(rf)
    if bold:
        rPr.append(OxmlElement('w:b'))
        rPr.append(OxmlElement('w:bCs'))
    sz = OxmlElement('w:sz')
    sz.set(qn('w:val'), str(size))
    rPr.append(sz)
    szcs = OxmlElement('w:szCs')
    szcs.set(qn('w:val'), str(size))
    rPr.append(szcs)
    r.append(rPr)
    t = OxmlElement('w:t')
    t.set(qn('xml:space'), 'preserve')
    t.text = text
    r.append(t)
    p.append(r)
    return p


def add_picture_before(doc, anchor, path, width_cm):
    p = doc.add_paragraph()
    run = p.add_run()
    run.add_picture(path, width=Cm(width_cm))
    pPr = p._p.get_or_add_pPr()
    pPr.append(OxmlElement('w:keepNext'))
    sp = OxmlElement('w:spacing')
    sp.set(qn('w:before'), '120')
    sp.set(qn('w:after'), '60')
    sp.set(qn('w:line'), '240')
    sp.set(qn('w:lineRule'), 'auto')
    pPr.append(sp)
    jc = OxmlElement('w:jc')
    jc.set(qn('w:val'), 'center')
    pPr.append(jc)
    anchor.addprevious(p._p)


# ---------------------------------------------------------------- 三线表
def _cell_border(tcPr, edge, sz):
    borders = tcPr.find(qn('w:tcBorders'))
    if borders is None:
        borders = OxmlElement('w:tcBorders')
        tcPr.append(borders)
    e = OxmlElement('w:' + edge)
    e.set(qn('w:val'), 'single')
    e.set(qn('w:sz'), str(sz))
    e.set(qn('w:space'), '0')
    e.set(qn('w:color'), '000000')
    borders.append(e)


def three_line_table(rows, widths):
    tbl = OxmlElement('w:tbl')
    tblPr = OxmlElement('w:tblPr')
    tw = OxmlElement('w:tblW')
    tw.set(qn('w:w'), str(TOTAL_TW))
    tw.set(qn('w:type'), 'dxa')
    tblPr.append(tw)
    jc = OxmlElement('w:jc')
    jc.set(qn('w:val'), 'center')
    tblPr.append(jc)
    borders = OxmlElement('w:tblBorders')
    for edge, val, sz in (('top', 'single', 12), ('left', 'nil', 0), ('bottom', 'single', 12),
                          ('right', 'nil', 0), ('insideH', 'nil', 0), ('insideV', 'nil', 0)):
        e = OxmlElement('w:' + edge)
        e.set(qn('w:val'), val)
        if val != 'nil':
            e.set(qn('w:sz'), str(sz))
            e.set(qn('w:space'), '0')
            e.set(qn('w:color'), '000000')
        borders.append(e)
    tblPr.append(borders)
    layout = OxmlElement('w:tblLayout')
    layout.set(qn('w:type'), 'fixed')
    tblPr.append(layout)
    mar = OxmlElement('w:tblCellMar')
    for edge, w in (('top', 20), ('left', 70), ('bottom', 20), ('right', 70)):
        e = OxmlElement('w:' + edge)
        e.set(qn('w:w'), str(w))
        e.set(qn('w:type'), 'dxa')
        mar.append(e)
    tblPr.append(mar)
    tbl.append(tblPr)

    grid = OxmlElement('w:tblGrid')
    colw = [int(w * TOTAL_TW) for w in widths]
    for w in colw:
        gc = OxmlElement('w:gridCol')
        gc.set(qn('w:w'), str(w))
        grid.append(gc)
    tbl.append(grid)

    ncol = len(widths)
    col_max = []
    for ci in range(ncol):
        col_max.append(max(len(str(r[ci]).replace('\n', '')) for r in rows if ci < len(r)))

    for ri, row in enumerate(rows):
        tr = OxmlElement('w:tr')
        trPr = OxmlElement('w:trPr')
        trPr.append(OxmlElement('w:cantSplit'))
        if ri == 0:
            trPr.append(OxmlElement('w:tblHeader'))
        tr.append(trPr)
        for ci, val in enumerate(row):
            tc = OxmlElement('w:tc')
            tcPr = OxmlElement('w:tcPr')
            tcW = OxmlElement('w:tcW')
            tcW.set(qn('w:w'), str(colw[ci]))
            tcW.set(qn('w:type'), 'dxa')
            tcPr.append(tcW)
            va = OxmlElement('w:vAlign')
            va.set(qn('w:val'), 'center')
            tcPr.append(va)
            if ri == 0:
                _cell_border(tcPr, 'bottom', 6)
            tc.append(tcPr)

            txt = str(val).replace('\n', '')
            p = OxmlElement('w:p')
            pPr = OxmlElement('w:pPr')
            if ri < len(rows) - 1:
                pPr.append(OxmlElement('w:keepNext'))
            sp = OxmlElement('w:spacing')
            sp.set(qn('w:before'), '30')
            sp.set(qn('w:after'), '30')
            sp.set(qn('w:line'), '240')
            sp.set(qn('w:lineRule'), 'auto')
            pPr.append(sp)
            j = OxmlElement('w:jc')
            j.set(qn('w:val'), 'center' if col_max[ci] <= 10 else 'left')
            pPr.append(j)
            p.append(pPr)
            r = OxmlElement('w:r')
            rPr = OxmlElement('w:rPr')
            rf = OxmlElement('w:rFonts')
            rf.set(qn('w:ascii'), 'Times New Roman')
            rf.set(qn('w:eastAsia'), '宋体')
            rf.set(qn('w:hAnsi'), 'Times New Roman')
            rPr.append(rf)
            if ri == 0:
                rPr.append(OxmlElement('w:b'))
            sz = OxmlElement('w:sz')
            sz.set(qn('w:val'), '21')
            rPr.append(sz)
            r.append(rPr)
            t = OxmlElement('w:t')
            t.set(qn('xml:space'), 'preserve')
            t.text = txt
            r.append(t)
            p.append(r)
            tc.append(p)
            tr.append(tc)
        tbl.append(tr)
    return tbl


# ---------------------------------------------------------------- 表格填充
def fill_grid_table(tbl, rows):
    trs = tbl.findall(qn('w:tr'))
    for ri, row in enumerate(rows):
        if ri >= len(trs):
            break
        tcs = trs[ri].findall(qn('w:tc'))
        for ci, val in enumerate(row):
            if ci >= len(tcs):
                break
            set_cell_text(tcs[ci], val)


COVER_TW = 8500      # 封面表格总宽（twips），与版心同宽
COVER_LW = 2760      # 标签列
COVER_RW = 5740      # 取值列（带下边框，形成填空线）


def _cover_cell(width, bottom_line=False):
    tc = OxmlElement('w:tc')
    tcPr = OxmlElement('w:tcPr')
    tcW = OxmlElement('w:tcW')
    tcW.set(qn('w:w'), str(width))
    tcW.set(qn('w:type'), 'dxa')
    tcPr.append(tcW)
    if bottom_line:
        bs = OxmlElement('w:tcBorders')
        e = OxmlElement('w:bottom')
        e.set(qn('w:val'), 'single')
        e.set(qn('w:sz'), '6')
        e.set(qn('w:space'), '0')
        e.set(qn('w:color'), '000000')
        bs.append(e)
        tcPr.append(bs)
    va = OxmlElement('w:vAlign')
    va.set(qn('w:val'), 'bottom')
    tcPr.append(va)
    tc.append(tcPr)
    return tc


def _cover_para(text, *, size=32, bold=False, eastasia='宋体'):
    p = OxmlElement('w:p')
    pPr = OxmlElement('w:pPr')
    sp = OxmlElement('w:spacing')
    sp.set(qn('w:before'), '0')
    sp.set(qn('w:after'), '0')
    sp.set(qn('w:line'), '400')
    sp.set(qn('w:lineRule'), 'exact')
    pPr.append(sp)
    j = OxmlElement('w:jc')
    j.set(qn('w:val'), 'center')
    pPr.append(j)
    p.append(pPr)
    p.append(make_run(text, size=size, bold=bold, eastasia=eastasia))
    return p


def build_cover_table(rows):
    """仿作品封面：左列标签居中加粗，右列取值居中且单元格下边框作填空线"""
    tbl = OxmlElement('w:tbl')
    tblPr = OxmlElement('w:tblPr')
    tw = OxmlElement('w:tblW')
    tw.set(qn('w:w'), str(COVER_TW))
    tw.set(qn('w:type'), 'dxa')
    tblPr.append(tw)
    jc = OxmlElement('w:jc')
    jc.set(qn('w:val'), 'center')
    tblPr.append(jc)
    borders = OxmlElement('w:tblBorders')
    for edge in ('top', 'left', 'bottom', 'right', 'insideH', 'insideV'):
        e = OxmlElement('w:' + edge)
        e.set(qn('w:val'), 'nil')
        borders.append(e)
    tblPr.append(borders)
    layout = OxmlElement('w:tblLayout')
    layout.set(qn('w:type'), 'fixed')
    tblPr.append(layout)
    tbl.append(tblPr)

    grid = OxmlElement('w:tblGrid')
    for w in (COVER_LW, COVER_RW):
        gc = OxmlElement('w:gridCol')
        gc.set(qn('w:w'), str(w))
        grid.append(gc)
    tbl.append(grid)

    for label, value, size in rows:
        tr = OxmlElement('w:tr')
        trPr = OxmlElement('w:trPr')
        trPr.append(OxmlElement('w:cantSplit'))
        h = OxmlElement('w:trHeight')
        h.set(qn('w:val'), '769')
        h.set(qn('w:hRule'), 'atLeast')
        trPr.append(h)
        tr.append(trPr)

        tcl = _cover_cell(COVER_LW)
        tcl.append(_cover_para(label, size=size, bold=True, eastasia='华文中宋'))
        tr.append(tcl)

        tcv = _cover_cell(COVER_RW, bottom_line=True)
        for seg in str(value).split('\n'):
            tcv.append(_cover_para(seg, size=size))
        tr.append(tcv)
        tbl.append(tr)
    return tbl


def cover_fill(doc):
    """封面：学年行居中，字段区改为两列表格（标签列 + 居中取值列 + 下划线）"""
    body = doc.element.body
    year_el = None
    field_els = []
    for el in body.findall(qn('w:p')):
        txt = ptext(el)
        s = txt.strip()
        if s.startswith('1') and '设计目的' in s:
            break            # 正文开始，封面处理结束
        if not s:
            continue
        if '学年' in s and '学期' in s:
            year_el = el
            continue
        for probe, label, value, size in COVER[1:]:
            if s.startswith(probe):
                field_els.append((el, label, value, size))
                break
    assert year_el is not None and len(field_els) == 7, (len(field_els), year_el is not None)

    # 学年学期行：居中，年份与“一”保留填空下划线
    for r in year_el.findall(qn('w:r')):
        year_el.remove(r)
    pPr = year_el.find(qn('w:pPr'))
    if pPr is None:
        pPr = OxmlElement('w:pPr')
        year_el.insert(0, pPr)
    for tag in ('w:ind', 'w:jc', 'w:spacing'):
        for e in pPr.findall(qn(tag)):
            pPr.remove(e)
    sp = OxmlElement('w:spacing')
    sp.set(qn('w:before'), '0')
    sp.set(qn('w:after'), '0')
    sp.set(qn('w:line'), '400')
    sp.set(qn('w:lineRule'), 'exact')
    pPr.append(sp)
    j = OxmlElement('w:jc')
    j.set(qn('w:val'), 'center')
    pPr.append(j)
    for seg, u in ((' 2026 ', True), ('--', False), (' 2027 ', True),
                   ('  学年  第 ', False), ('一', False), (' 学期', False)):
        year_el.append(make_run(seg, size=30, underline=u))

    # 字段区：七行合并为一张两列表格
    first = field_els[0][0]
    first.addprevious(build_cover_table([(l, v, s) for _, l, v, s in field_els]))
    for el, _, _, _ in field_els:
        body.remove(el)


def clean_marks(doc):
    """图、表题注与图片段落：清掉列表编号等继承属性，避免行首出现项目符号"""
    import re
    keep = {qn('w:keepNext'), qn('w:keepLines'), qn('w:spacing'),
            qn('w:ind'), qn('w:jc'), qn('w:rPr')}
    body = doc.element.body
    for p in body.findall(qn('w:p')):
        txt = ptext(p).strip()
        is_cap = bool(re.match(r'^[图表]\s*\d', txt))
        is_pic = p.find('.//' + qn('w:drawing')) is not None
        if not (is_cap or is_pic):
            continue
        pPr = p.find(qn('w:pPr'))
        if pPr is None:
            continue
        for e in list(pPr):
            if e.tag not in keep:
                pPr.remove(e)


def make_run(text, *, size=32, bold=False, underline=False, eastasia='宋体'):
    r = OxmlElement('w:r')
    rPr = OxmlElement('w:rPr')
    rf = OxmlElement('w:rFonts')
    rf.set(qn('w:ascii'), 'Times New Roman')
    rf.set(qn('w:eastAsia'), eastasia)
    rf.set(qn('w:hAnsi'), 'Times New Roman')
    rPr.append(rf)
    if bold:
        rPr.append(OxmlElement('w:b'))
    if underline:
        u = OxmlElement('w:u')
        u.set(qn('w:val'), 'single')
        rPr.append(u)
    sz = OxmlElement('w:sz')
    sz.set(qn('w:val'), str(size))
    rPr.append(sz)
    szcs = OxmlElement('w:szCs')
    szcs.set(qn('w:val'), str(size))
    rPr.append(szcs)
    r.append(rPr)
    for i, seg in enumerate(str(text).split('\n')):
        if i:
            r.append(OxmlElement('w:br'))
        if not seg:
            continue
        t = OxmlElement('w:t')
        t.set(qn('xml:space'), 'preserve')
        t.text = seg
        r.append(t)
    return r


def resize_table(tbl, widths, total=TOTAL_TW):
    """按比例重设表格列宽（dxa）"""
    tblPr = tbl.find(qn('w:tblPr'))
    if tblPr is not None:
        for old in tblPr.findall(qn('w:tblW')):
            tblPr.remove(old)
        tw = OxmlElement('w:tblW')
        tw.set(qn('w:w'), str(total))
        tw.set(qn('w:type'), 'dxa')
        tblPr.append(tw)
        for lay in tblPr.findall(qn('w:tblLayout')):
            tblPr.remove(lay)
        lay = OxmlElement('w:tblLayout')
        lay.set(qn('w:type'), 'fixed')
        tblPr.append(lay)
    colw = [int(w * total) for w in widths]
    grid = tbl.find(qn('w:tblGrid'))
    if grid is not None:
        gcs = grid.findall(qn('w:gridCol'))
        for gc, w in zip(gcs, colw):
            gc.set(qn('w:w'), str(w))
    for tr in tbl.findall(qn('w:tr')):
        for tc, w in zip(tr.findall(qn('w:tc')), colw):
            tcPr = tc.find(qn('w:tcPr'))
            if tcPr is None:
                continue
            for old in tcPr.findall(qn('w:tcW')):
                tcPr.remove(old)
            e = OxmlElement('w:tcW')
            e.set(qn('w:w'), str(w))
            e.set(qn('w:type'), 'dxa')
            tcPr.insert(0, e)


def repeat_header(tbl):
    """首行作为重复表头，行内禁止断行"""
    trs = tbl.findall(qn('w:tr'))
    for ri, tr in enumerate(trs):
        trPr = tr.find(qn('w:trPr'))
        if trPr is None:
            trPr = OxmlElement('w:trPr')
            tr.insert(0, trPr)
        if ri == 0 and trPr.find(qn('w:tblHeader')) is None:
            trPr.append(OxmlElement('w:tblHeader'))
        if trPr.find(qn('w:cantSplit')) is None:
            trPr.append(OxmlElement('w:cantSplit'))


def main():
    os.makedirs(os.path.dirname(BAK), exist_ok=True)
    if not os.path.exists(BAK):
        shutil.copy2(SRC, BAK)

    doc = docx.Document(BAK)
    body = doc.element.body
    children = list(body)

    h1 = h2_tpl = p_tpl = None
    anchor_thought = None
    tbl41 = tbl42 = tbl_thought = None
    for el in children:
        txt = ptext(el)
        if el.tag == qn('w:p'):
            if txt.strip() == '1 设计目的' and h1 is None:
                h1 = el
            if txt.strip().startswith('3.1 需求分析') and h2_tpl is None:
                h2_tpl = el
            if txt.strip().startswith('《专业综合实践》是区块链工程') and p_tpl is None:
                p_tpl = el
            if txt.strip().startswith('5.设计体会') or txt.strip().startswith('5. 设计体会'):
                anchor_thought = el
        else:
            t = ptext(el)
            if '项目名称' in t and '项目周期' in t and tbl41 is None:
                tbl41 = el
            if '计划任务' in t and '计划课时' in t and tbl42 is None:
                tbl42 = el
            if '设计体会' in t and '评阅意见' in t and tbl_thought is None:
                tbl_thought = el

    assert h1 is not None and h2_tpl is not None and p_tpl is not None
    assert anchor_thought is not None and tbl41 is not None and tbl42 is not None
    assert tbl_thought is not None, '未找到设计体会表格'

    tbl41 = copy.deepcopy(tbl41)
    tbl42 = copy.deepcopy(tbl42)

    # ---- 删除 1 设计目的 与 5.设计体会 之间的模板内容 ----
    i0 = children.index(h1)
    i1 = children.index(anchor_thought)
    for el in children[i0 + 1:i1]:
        body.remove(el)

    # ---- 逐项写入 ----
    h1_tpl = copy.deepcopy(h1)
    strip_sectpr(h1_tpl)
    for item in CONTENT:
        kind = item[0]
        if kind == 'h1':
            el = copy.deepcopy(h1_tpl)
            strip_sectpr(el)
            set_para_text(el, item[1])
        elif kind == 'h2':
            el = copy.deepcopy(h2_tpl)
            strip_sectpr(el)
            set_para_text(el, item[1])
        elif kind == 'p':
            el = copy.deepcopy(p_tpl)
            strip_sectpr(el)
            set_para_text(el, item[1])
        elif kind == 'img':
            path = os.path.join(IMGDIR, item[1])
            assert os.path.exists(path), path
            add_picture_before(doc, anchor_thought, path, item[2])
            continue
        elif kind == 'cap':
            el = new_para(item[1], size=21, bold=True, jc='center',
                          before=0, after=150, eastasia='宋体')
        elif kind == 'tcap':
            el = new_para(item[1], size=21, bold=True, jc='center',
                          before=150, after=60, keep_next=True, eastasia='宋体')
        elif kind == 'tbl':
            el = three_line_table(item[1], item[2])
        elif kind == 'tbl41':
            el = copy.deepcopy(tbl41)
            fill_grid_table(el, item[1])
            resize_table(el, [0.22, 0.78])
            repeat_header(el)
        elif kind == 'tbl42':
            el = copy.deepcopy(tbl42)
            fill_grid_table(el, item[1])
            resize_table(el, [0.10, 0.13, 0.35, 0.09, 0.33])
            repeat_header(el)
        elif kind == 'thought':
            continue
        else:
            raise ValueError(kind)
        anchor_thought.addprevious(el)

    # ---- 设计体会另起一页 ----
    pPr = anchor_thought.find(qn('w:pPr'))
    if pPr is None:
        pPr = OxmlElement('w:pPr')
        anchor_thought.insert(0, pPr)
    if pPr.find(qn('w:pageBreakBefore')) is None:
        pb = OxmlElement('w:pageBreakBefore')
        sp = pPr.find(qn('w:spacing'))
        if sp is not None:
            sp.addprevious(pb)
        else:
            pPr.insert(0, pb)

    # ---- 设计体会表格 ----
    trs = tbl_thought.findall(qn('w:tr'))
    head = trs[0].findall(qn('w:tc'))
    set_cell_text(head[1], '袁文平')
    set_cell_text(head[3], '202301190144')

    cell = trs[2].findall(qn('w:tc'))[0]
    for p in cell.findall(qn('w:p')):
        cell.remove(p)
    thought = next(it[1] for it in CONTENT if it[0] == 'thought')
    for para in thought:
        p = OxmlElement('w:p')
        pPr = OxmlElement('w:pPr')
        sp = OxmlElement('w:spacing')
        sp.set(qn('w:before'), '0')
        sp.set(qn('w:after'), '0')
        sp.set(qn('w:line'), '300')
        sp.set(qn('w:lineRule'), 'auto')
        pPr.append(sp)
        ind = OxmlElement('w:ind')
        ind.set(qn('w:firstLineChars'), '200')
        ind.set(qn('w:firstLine'), '480')
        pPr.append(ind)
        j = OxmlElement('w:jc')
        j.set(qn('w:val'), 'both')
        pPr.append(j)
        p.append(pPr)
        r = OxmlElement('w:r')
        rPr = OxmlElement('w:rPr')
        rf = OxmlElement('w:rFonts')
        rf.set(qn('w:ascii'), 'Times New Roman')
        rf.set(qn('w:eastAsia'), '宋体')
        rf.set(qn('w:hAnsi'), 'Times New Roman')
        rPr.append(rf)
        sz = OxmlElement('w:sz')
        sz.set(qn('w:val'), '24')
        rPr.append(sz)
        r.append(rPr)
        t = OxmlElement('w:t')
        t.set(qn('xml:space'), 'preserve')
        t.text = para
        r.append(t)
        p.append(r)
        cell.append(p)

    # 体会正文行距 1.2，使“设计体会+评阅意见”整表落在同一页
    for tc in tbl_thought.findall('.//' + qn('w:tc')):
        for p in tc.findall(qn('w:p')):
            pPr = p.find(qn('w:pPr'))
            if pPr is None:
                continue
            sp = pPr.find(qn('w:spacing'))
            if sp is not None and sp.get(qn('w:line')) == '300':
                sp.set(qn('w:line'), '290')

    # ---- 封面 ----
    cover_fill(doc)

    # ---- 图、表题注去掉列表/项目符号属性 ----
    clean_marks(doc)

    # 评阅意见行高度略作收紧，保证“设计体会+评阅意见”同页
    trs = tbl_thought.findall(qn('w:tr'))
    for ri, tr in enumerate(trs):
        trPr = tr.find(qn('w:trPr'))
        if trPr is None:
            trPr = OxmlElement('w:trPr')
            tr.insert(0, trPr)
        if trPr.find(qn('w:cantSplit')) is None:
            trPr.append(OxmlElement('w:cantSplit'))
    trPr = trs[3].find(qn('w:trPr'))
    if trPr is not None:
        h = trPr.find(qn('w:trHeight'))
        if h is not None:
            h.set(qn('w:val'), '2500')
            h.set(qn('w:hRule'), 'atLeast')

    # 评阅意见栏减少一个空行，给整表留出安全余量（防止不同机器上再次跨页）
    tc3 = trs[3].findall(qn('w:tc'))[0]
    blanks = [x for x in tc3.findall(qn('w:p'))
              if not ''.join(t.text or '' for t in x.iter(qn('w:t'))).strip()]
    if len(blanks) > 1:
        tc3.remove(blanks[-2])

    # 表格后的空段落压到 1 磅，避免把整页撑出新的一页
    tail = tbl_thought.getnext()
    while tail is not None and tail.tag != qn('w:p'):
        tail = tail.getnext()
    if tail is not None:
        for r in tail.findall(qn('w:r')):
            tail.remove(r)
        tPr = tail.find(qn('w:pPr'))
        if tPr is None:
            tPr = OxmlElement('w:pPr')
            tail.insert(0, tPr)
        for e in tPr.findall(qn('w:spacing')):
            tPr.remove(e)
        sp = OxmlElement('w:spacing')
        sp.set(qn('w:before'), '0')
        sp.set(qn('w:after'), '0')
        sp.set(qn('w:line'), '20')
        sp.set(qn('w:lineRule'), 'exact')
        tPr.append(sp)
        tr = OxmlElement('w:r')
        rPr = OxmlElement('w:rPr')
        sz = OxmlElement('w:sz')
        sz.set(qn('w:val'), '2')
        rPr.append(sz)
        tr.append(rPr)
        tail.append(tr)

    doc.save(OUT)
    print('saved', OUT)
    print('paragraphs', len(doc.paragraphs), 'tables', len(doc.tables))


if __name__ == '__main__':
    main()
