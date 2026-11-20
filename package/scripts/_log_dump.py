import docx
from docx.oxml.ns import qn

files = [
 r"E:/没用的的东西/2026下学期实训/文档/专业综合实践-学生实训日志-202201190144-袁文平.docx",
 r"E:/没用的的东西/2026下学期实训/文档/专业综合实践-学生实训日志-202201190144-袁文平-第二次.docx",
]
for f in files:
    print("="*100)
    print(f)
    d = docx.Document(f)
    tb = d.tables[0]
    for ri,tr in enumerate(tb.rows):
        for ci,tc in enumerate(tr.cells):
            print("---- r%d c%d ----"%(ri,ci))
            for p in tc.paragraphs:
                print("   [%s|%s|%s] %s"%(p.style.name, p.alignment,
                       p.paragraph_format.line_spacing, p.text))
