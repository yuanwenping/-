# -*- coding: utf-8 -*-
"""验证标题左侧小方块是否为“与下段同页(keepNext)”标记"""
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
    print('found', target is not None, target.Style.NameLocal if target else '')
    fmt = target.Range.ParagraphFormat
    print('KeepWithNext', fmt.KeepWithNext, 'KeepTogether', fmt.KeepTogether,
          'PageBreakBefore', fmt.PageBreakBefore, flush=True)
    doc.ActiveWindow.View.ShowParagraphs = True
    app.Activate()
    doc.ActiveWindow.ScrollIntoView(target.Range, True)
    time.sleep(1.2)
    grab(r'E:/毕业项目实训/pakeage/docs/预览/kwn_on.bmp')
    fmt.KeepWithNext = False
    time.sleep(1.5)
    grab(r'E:/毕业项目实训/pakeage/docs/预览/kwn_off.bmp')
    print('shots ok', flush=True)
finally:
    doc.Close(0)
    app.Quit()
