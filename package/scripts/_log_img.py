import docx, hashlib, re
from docx.oxml.ns import qn
from lxml import etree
from docx.parts.image import ImagePart

for f in [r"E:/没用的的东西/2026下学期实训/文档/专业综合实践-学生实训日志-202201190144-袁文平.docx",
          r"E:/没用的的东西/2026下学期实训/文档/专业综合实践-学生实训日志-202201190144-袁文平-第二次.docx"]:
    print("="*80); print(f.split('/')[-1])
    d = docx.Document(f)
    for rel in d.part.rels.values():
        if 'image' in rel.reltype:
            blob = rel.target_part.blob
            print("  rel", rel.rId, rel.target_ref, len(blob), hashlib.md5(blob).hexdigest()[:8])
    tb = d.tables[0]
    for ri,tr in enumerate(tb._tbl.findall(qn('w:tr'))):
        for tc in tr.findall(qn('w:tc')):
            for pi,p in enumerate(tc.findall(qn('w:p'))):
                for tag in ('w:drawing','w:pict','w:object'):
                    for dr in p.findall('.//'+qn(tag)):
                        x = re.sub(r' xmlns:[a-z0-9]+="[^"]*"','',etree.tostring(dr).decode())
                        rid = re.findall(r'r:embed="([^"]+)"', x)
                        iext = re.findall(r'<wp:extent cx="(\d+)" cy="(\d+)"', x)
                        tag2 = 'anchor' if '<wp:anchor' in x else 'inline'
                        print("  row%d para%d %s %s rid=%s ext=%s len=%d"%(ri,pi,tag,tag2,rid,iext,len(x)))
                        print("   ", x[:300])
