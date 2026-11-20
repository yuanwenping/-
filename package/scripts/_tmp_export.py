# -*- coding: utf-8 -*-
import os
import pythoncom
import win32com.client as win32

DOC = r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计作品-202301190144-袁文平-实训作品.docx'
PDF = r'E:/毕业项目实训/pakeage/docs/预览/作品预览2.pdf'

pythoncom.CoInitialize()
app = win32.gencache.EnsureDispatch('Word.Application')
app.Visible = False
app.DisplayAlerts = 0
app.ScreenUpdating = False
doc = app.Documents.Open(DOC.replace('/', '\\'))
try:
    doc.Fields.Update()
    doc.Repaginate()
    print('pages', doc.ComputeStatistics(2))
    doc.ExportAsFixedFormat(PDF.replace('/', '\\'), 17)
    print('pdf ok')
finally:
    doc.Close(0)
    app.Quit()
