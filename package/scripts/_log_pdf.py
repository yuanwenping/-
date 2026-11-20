# -*- coding: utf-8 -*-
import os, sys, pythoncom, win32com.client as win32

def export(doc_path, pdf_path):
    os.makedirs(os.path.dirname(pdf_path), exist_ok=True)
    pythoncom.CoInitialize()
    app = win32.gencache.EnsureDispatch('Word.Application')
    app.Visible = False
    app.DisplayAlerts = 0
    app.ScreenUpdating = False
    doc = app.Documents.Open(doc_path.replace('/', '\\'), ReadOnly=True)
    try:
        doc.Repaginate()
        print('pages', doc.ComputeStatistics(2))
        doc.ExportAsFixedFormat(pdf_path.replace('/', '\\'), 17)
        print('pdf ok', pdf_path)
    finally:
        doc.Close(0)
        app.Quit()

if __name__ == '__main__':
    export(sys.argv[1], sys.argv[2])
