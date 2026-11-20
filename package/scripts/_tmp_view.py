# -*- coding: utf-8 -*-
"""列出 Word 视图（View）所有显示开关的当前取值"""
import pythoncom
import win32com.client as win32

DOC = r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计作品-202301190144-袁文平-实训作品.docx'

pythoncom.CoInitialize()
app = win32.gencache.EnsureDispatch('Word.Application')
app.Visible = False
app.DisplayAlerts = 0
doc = app.Documents.Open(DOC.replace('/', '\\'), ReadOnly=True)
try:
    v = doc.ActiveWindow.View
    names = [n for n in dir(v) if n.lower().startswith(('show', 'display'))]
    for n in names:
        try:
            val = getattr(v, n)
        except Exception as e:
            val = 'ERR %s' % e
        print('%-28s %s' % (n, val))
finally:
    doc.Close(0)
    app.Quit()
