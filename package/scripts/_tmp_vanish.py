# -*- coding: utf-8 -*-
import zipfile
from lxml import etree

W = '{http://schemas.openxmlformats.org/wordprocessingml/2006/main}'
p = r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计作品-202301190144-袁文平-实训作品.docx'
z = zipfile.ZipFile(p)
doc = etree.fromstring(z.read('word/document.xml'))

# 1) 隐藏文字
vanish = doc.findall('.//' + W + 'vanish')
print('vanish runs:', len(vanish))
for v in vanish[:10]:
    r = v.getparent().getparent()
    txt = ''.join(t.text or '' for t in r.iter(W + 't')) if r is not None else ''
    print('   hidden run text=', repr(txt[:20]))

# 2) 特殊符号字符
chars = {}
for t in doc.iter(W + 't'):
    for ch in (t.text or ''):
        if ord(ch) > 0x2000 and ord(ch) not in (0x201c, 0x201d, 0x2018, 0x2019, 0x2014, 0x2013,
                                                0x2026, 0x3000, 0x3001, 0x3002, 0xff08, 0xff09,
                                                0xff0c, 0xff1a, 0xff1b, 0xff1f, 0xff01, 0x2015):
            chars[ch] = chars.get(ch, 0) + 1
print('odd chars:', {hex(ord(k)): v for k, v in sorted(chars.items(), key=lambda x: -x[1])[:15]})

# 3) 4.3.2 段落
for par in doc.iter(W + 'p'):
    txt = ''.join(t.text or '' for t in par.iter(W + 't'))
    if txt.strip().startswith('4.3.2'):
        print('=== 4.3.2 para runs:')
        for r in par.findall(W + 'r'):
            rt = ''.join(t.text or '' for t in r.iter(W + 't'))
            rPr = r.find(W + 'rPr')
            flags = []
            if rPr is not None:
                for tag in ('vanish', 'b', 'sz', 'rFonts', 'u'):
                    e = rPr.find(W + tag)
                    if e is not None:
                        flags.append(tag + '=' + str(e.get(W + 'val') or e.get(W + 'ascii') or ''))
            print('   run', repr(rt[:20]), flags)
        break
