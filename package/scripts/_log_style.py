import docx, re
from docx.oxml.ns import qn
from lxml import etree

f = r"E:/没用的的东西/2026下学期实训/文档/专业综合实践-学生实训日志-202201190144-袁文平-第二次.docx"
d = docx.Document(f)
sec = d.sections[0]
print("page", sec.page_width.cm, sec.page_height.cm, "margins", sec.left_margin.cm, sec.right_margin.cm, sec.top_margin.cm, sec.bottom_margin.cm)

def dump(el, label=""):
    x = etree.tostring(el, pretty_print=True).decode()
    x = re.sub(r' xmlns:[a-z0-9]+="[^"]*"', '', x)
    print("### ", label)
    print(x[:2500])

# cover paragraphs 5,9..14
body = d.element.body
kids = list(body.iterchildren())
for i in (5, 9, 10, 13, 14):
    dump(kids[i], "cover p%d"%i)

tb = d.tables[0]
print("\n=== table XML (head) ===")
dump(tb._tbl, "table")
