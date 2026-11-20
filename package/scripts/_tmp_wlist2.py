# -*- coding: utf-8 -*-
"""检查作品文档：Word 视图下哪些段落带项目符号/编号"""
import pythoncom
import win32com.client as win32

DOC = r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计作品-202301190144-袁文平-实训作品.docx'

pythoncom.CoInitialize()
app = win32.gencache.EnsureDispatch('Word.Application')
app.Visible = False
app.DisplayAlerts = 0
doc = app.Documents.Open(DOC.replace('/', '\\'), ReadOnly=True)
try:
    print('paragraphs', doc.Paragraphs.Count)
    for i in range(1, doc.Paragraphs.Count + 1):
        par = doc.Paragraphs.Item(i)
        lt = par.Range.ListFormat.ListType
        if lt != 0:
            t = par.Range.Text.replace('\r', '').replace('\x07', '')[:40]
            print('LIST idx=%d type=%d style=%s text=%r' % (i, lt, par.Style.NameLocal, t))
finally:
    doc.Close(0)
    app.Quit()
