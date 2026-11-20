import docx, re
from docx.oxml.ns import qn
from lxml import etree

f = r"E:/没用的的东西/2026下学期实训/文档/专业综合实践-学生实训日志-202201190144-袁文平-第二次.docx"
d = docx.Document(f)
tb = d.tables[0]
trs = tb._tbl.findall(qn('w:tr'))
for ri in (1,3):
    tc = trs[ri].findall(qn('w:tc'))[0]
    p = tc.findall(qn('w:p'))[0]
    print("row",ri,"label xml:", re.sub(r' xmlns:[a-z0-9]+="[^"]*"','',etree.tostring(p).decode())[:800])
xm = d.part.numbering_part.element
for num in xm.findall(qn('w:num')):
    print("NUM", num.get(qn('w:numId')))
    print("   ", re.sub(r' xmlns:[a-z0-9]+="[^"]*"','',etree.tostring(num).decode())[:400])
for an in xm.findall(qn('w:abstractNum')):
    print("ABS", an.get(qn('w:abstractNumId')))
    lvl = an.find(qn('w:lvl'))
    print("   ", re.sub(r' xmlns:[a-z0-9]+="[^"]*"','',etree.tostring(lvl).decode())[:500])
