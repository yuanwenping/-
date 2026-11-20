import docx, re
from docx.oxml.ns import qn
from lxml import etree

f = r"E:/没用的的东西/2026下学期实训/文档/专业综合实践-学生实训日志-202201190144-袁文平-第二次.docx"
d = docx.Document(f)
kids = list(d.element.body.iterchildren())
for i in (13,14):
    p = kids[i]
    print("### block", i)
    print(re.sub(r' xmlns:[a-z0-9]+="[^"]*"','',etree.tostring(p, pretty_print=True).decode())[:3000])
