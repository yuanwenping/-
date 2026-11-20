import docx, re
from docx.oxml.ns import qn
from lxml import etree
from docx.parts.image import ImagePart

for f in [r"E:/没用的的东西/2026下学期实训/文档/专业综合实践-学生实训日志-202201190144-袁文平.docx",
          r"E:/没用的的东西/2026下学期实训/文档/专业综合实践-学生实训日志-202201190144-袁文平-第二次.docx"]:
    print("="*80); print(f)
    d = docx.Document(f)
    imgs = [p for p in d.part.package.iter_parts() if isinstance(p, ImagePart)]
    print("image parts:", len(imgs), "total bytes:", sum(len(p.blob) for p in imgs))
    for r in d.part.rels.values():
        if "image" in r.reltype:
            print("  rel", r.rId, r.reltype.split('/')[-1], getattr(r,'target_ref','')[:60])
    tb = d.tables[0]
    print("tblPr:", re.sub(r' xmlns:[a-z0-9]+="[^"]*"','',etree.tostring(tb._tbl.tblPr,pretty_print=False).decode())[:600])
    for ri,tr in enumerate(tb._tbl.findall(qn('w:tr'))):
        trPr = tr.find(qn('w:trPr'))
        print(" row",ri,"tc=",len(tr.findall(qn('w:tc'))), "trPr=", re.sub(r' xmlns:[a-z0-9]+="[^"]*"','',etree.tostring(trPr).decode()) if trPr is not None else None)
        for tc in tr.findall(qn('w:tc')):
            tcPr = tc.find(qn('w:tcPr'))
            print("   tcPr=", re.sub(r' xmlns:[a-z0-9]+="[^"]*"','',etree.tostring(tcPr).decode())[:400] if tcPr is not None else None)
            print("   paras=", len(tc.findall(qn('w:p'))), "imgs=", len(tc.findall('.//'+qn('w:drawing'))))
