# -*- coding: utf-8 -*-
import sys
import pythoncom
import win32com.client as win32

DOC = sys.argv[1]
pythoncom.CoInitialize()
app = win32.gencache.EnsureDispatch('Word.Application')
app.Visible = False
app.DisplayAlerts = 0
doc = app.Documents.Open(DOC.replace('/', '\\'), ReadOnly=True)
try:
    n = doc.Paragraphs.Count
    print('paragraphs', n, flush=True)
    hits = 0
    for i in range(1, n + 1):
        par = doc.Paragraphs.Item(i)
        ls = par.Range.ListFormat.ListString
        if ls:
            hits += 1
            t = par.Range.Text.replace('\r', '').replace('\x07', '')[:40]
            print('idx=%d sym=%r style=%s text=%r' % (i, ls, par.Style.NameLocal, t), flush=True)
    print('hits', hits, flush=True)
finally:
    doc.Close(0)
    app.Quit()
