# -*- coding: utf-8 -*-
"""跳到标题所在页，对比 keepNext=True/False 时标题左侧标记"""
import time
import pythoncom
import win32com.client as win32
import win32gui
import win32ui
import win32con

DOC = r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计作品-202301190144-袁文平-实训作品.docx'


def grab(path):
    hwnd = win32gui.GetDesktopWindow()
    l, t, r, b = win32gui.GetWindowRect(hwnd)
    w, h = r - l, b - t
    hdc = win32gui.GetWindowDC(hwnd)
    mfc = win32ui.CreateDCFromHandle(hdc)
    dc = mfc.CreateCompatibleDC()
    bmp = win32ui.CreateBitmap()
    bmp.CreateCompatibleBitmap(mfc, w, h)
    dc.SelectObject(bmp)
    dc.BitBlt((0, 0), (w, h), mfc, (0, 0), win32con.SRCCOPY)
    bmp.SaveBitmapFile(dc, path)


pythoncom.CoInitialize()
app = win32.gencache.EnsureDispatch('Word.Application')
app.Visible = True
app.DisplayAlerts = 0
doc = app.Documents.Open(DOC.replace('/', '\\'))
try:
    target = None
    for i in range(1, 500):
        par = doc.Paragraphs.Item(i)
        txt = par.Range.Text.replace('\r', '').strip()
        if txt.startswith('4.3 区块链设计') and 'TOC' not in par.Style.NameLocal:
            target = par
            break
    pg = target.Range.Information(3)
    print('page', pg, 'style', target.Style.NameLocal,
          'keep', target.Range.ParagraphFormat.KeepWithNext, flush=True)
    app.Activate()
    doc.ActiveWindow.View.ShowParagraphs = True
    app.Selection.GoTo(1, 1, pg)
    time.sleep(1.5)
    grab(r'E:/毕业项目实训/pakeage/docs/预览/kwn_on.bmp')
    target.Range.ParagraphFormat.KeepWithNext = False
    time.sleep(1.5)
    grab(r'E:/毕业项目实训/pakeage/docs/预览/kwn_off.bmp')
    print('done', flush=True)
finally:
    doc.Close(0)
    app.Quit()
