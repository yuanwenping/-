# -*- coding: utf-8 -*-
"""导出报告 PDF 以便校验版式"""
import os
import sys

try:
    import pythoncom
    import win32com.client as win32
except ImportError:
    sys.exit('need pywin32')

DOC = r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计报告-202301190144-袁文平.docx'
PDF = r'E:/毕业项目实训/pakeage/docs/预览/报告预览.pdf'


def main():
    os.makedirs(os.path.dirname(PDF), exist_ok=True)
    pythoncom.CoInitialize()
    app = win32.gencache.EnsureDispatch('Word.Application')
    app.Visible = False
    app.DisplayAlerts = 0
    app.ScreenUpdating = False
    doc = app.Documents.Open(DOC.replace('/', '\\'))
    try:
        doc.Fields.Update()
        doc.Repaginate()
        pages = doc.ComputeStatistics(2)
        words = doc.ComputeStatistics(0)
        chars = doc.ComputeStatistics(3)
        print('pages', pages, 'words', words, 'chars', chars)
        doc.Save()
        doc.ExportAsFixedFormat(PDF.replace('/', '\\'), 17)
        print('pdf ok')
    finally:
        doc.Close(0)
        app.Quit()


if __name__ == '__main__':
    main()
