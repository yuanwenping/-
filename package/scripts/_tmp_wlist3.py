# -*- coding: utf-8 -*-
"""Word 视图下：找出任何带项目符号/编号的段落（含样式继承），输出符号与位置"""
import pythoncom
import win32com.client as win32

DOCS = [
    r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计报告-202301190144-袁文平.docx',
    r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计作品-202301190144-袁文平-实训作品.docx',
]

pythoncom.CoInitialize()
app = win32.gencache.EnsureDispatch('Word.Application')
app.Visible = False
app.DisplayAlerts = 0
for DOC in DOCS:
    print('#####', DOC.split('/')[-1])
    doc = app.Documents.Open(DOC.replace('/', '\\'), ReadOnly=True)
    try:
        n = doc.Paragraphs.Count
        for i in range(1, n + 1):
            par = doc.Paragraphs.Item(i)
            lf = par.Range.ListFormat
            ls = lf.ListString
            if ls:
                t = par.Range.Text.replace('\r', '').replace('\x07', '')[:45]
                print('  idx=%d type=%d sym=%r style=%s text=%r' %
                      (i, lf.ListType, ls, par.Style.NameLocal, t))
    finally:
        doc.Close(0)
app.Quit()
