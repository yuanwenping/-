import docx, re
from docx.oxml.ns import qn
from lxml import etree

f = r"E:/没用的的东西/2026下学期实训/文档/专业综合实践-学生实训日志-202201190144-袁文平-第二次.docx"
d = docx.Document(f)
tb = d.tables[0]
trs = tb._tbl.findall(qn('w:tr'))

def pinfo(p, idx):
    pPr = p.find(qn('w:pPr'))
    num = pPr.find(qn('w:numPr')) if pPr is not None else None
    numid = None
    if num is not None:
        n = num.find(qn('w:numId'))
        numid = n.get(qn('w:val')) if n is not None else '?'
    sty = pPr.find(qn('w:pStyle')) if pPr is not None else None
    styname = sty.get(qn('w:val')) if sty is not None else ''
    ind = pPr.find(qn('w:ind')) if pPr is not None else None
    inds = dict(ind.attrib) if ind is not None else {}
    t = ''.join(x.text or '' for x in p.findall('.//'+qn('w:t')))
    runs = p.findall(qn('w:r'))
    szs = []
    for r in runs:
        rPr = r.find(qn('w:rPr'))
        if rPr is not None:
            sz = rPr.find(qn('w:sz'))
            if sz is not None: szs.append(sz.get(qn('w:val')))
    img = p.find('.//'+qn('w:drawing')) is not None
    print("  p%-2d style=%-14s num=%s ind=%s img=%s runs=%d sz=%s txt=%r"%(
        idx, styname, numid, inds, img, len(runs), sorted(set(szs)), t[:40]))

print("== header row 0 ==")
for ci,tc in enumerate(trs[0].findall(qn('w:tc'))):
    for p in tc.findall(qn('w:p')):
        pinfo(p, ci)
        print("    xml:", re.sub(r' xmlns:[a-z0-9]+="[^"]*"','',etree.tostring(p).decode())[:700])
print("== content row 1 ==")
for p in trs[1].findall(qn('w:tc'))[0].findall(qn('w:p')):
    pinfo(p, 0)
print("== numbering defs ==")
xm = d.part.numbering_part.element
for num in xm.findall(qn('w:num')):
    print(" num", num.get(qn('w:numId')), "abstract", num.find(qn('w:abstractNumId')).get(qn('w:val')))
