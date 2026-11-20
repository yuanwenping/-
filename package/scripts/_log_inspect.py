import docx, sys
from docx.oxml.ns import qn
from lxml import etree

files = [
 r"E:/没用的的东西/2026下学期实训/专业综合实践-学生实训日志-202201190XXX-姓名.docx",
 r"E:/没用的的东西/2026下学期实训/文档/专业综合实践-学生实训日志-202201190144-袁文平.docx",
 r"E:/没用的的东西/2026下学期实训/文档/专业综合实践-学生实训日志-202201190144-袁文平-第二次.docx",
]
for f in files:
    print("="*90)
    print(f)
    d = docx.Document(f)
    body = d.element.body
    kids = list(body.iterchildren())
    print("blocks:", len(kids), " paragraphs:", len(d.paragraphs), " tables:", len(d.tables))
    for i,ch in enumerate(kids):
        tag = ch.tag.split('}')[1]
        if tag == 'p':
            t = ''.join(x.text or '' for x in ch.findall('.//'+qn('w:t')))
            has_pic = ch.find('.//'+qn('w:drawing')) is not None
            print(i, 'P ', ('[IMG]' if has_pic else ''), repr(t[:100]))
        elif tag == 'tbl':
            rows = ch.findall(qn('w:tr'))
            print(i, 'TBL rows=', len(rows))
            for ri,tr in enumerate(rows):
                cells = tr.findall(qn('w:tc'))
                vals = []
                for tc in cells:
                    t = ''.join(x.text or '' for x in tc.findall('.//'+qn('w:t')))
                    vals.append(t.replace('\n','|')[:40])
                print('     r%d'%ri, len(cells), vals)
        else:
            print(i, tag)
