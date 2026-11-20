# -*- coding: utf-8 -*-
"""截取 Word 窗口（显示段落标记）以定位用户所见符号"""
import sys
import time
import pythoncom
import win32com.client as win32
import win32gui
import win32ui
import win32con

DOC = sys.argv[1]
NEEDLE = sys.argv[2]
OUT = sys.argv[3]


def grab(path):
    hwnd = win32gui.GetDesktopWindow()
    left, top, right, bot = win32gui.GetWindowRect(hwnd)
    w, h = right - left, bot - top
    hdc = win32gui.GetWindowDC(hwnd)
    mfc = win32ui.CreateDCFromHandle(hdc)
    dc = mfc.CreateCompatibleDC()
    bmp = win32ui.CreateBitmap()
    bmp.CreateCompatibleBitmap(mfc, w, h)
    dc.SelectObject(bmp)
    dc.BitBlt((0, 0), (w, h), mfc, (0, 0), win32con.SRCCOPY)
    bmp.SaveBitmapFile(dc, path)
    print('saved', path, w, h, flush=True)


pythoncom.CoInitialize()
app = win32.gencache.EnsureDispatch('Word.Application')
app.Visible = True
app.DisplayAlerts = 0
doc = app.Documents.Open(DOC.replace('/', '\\'))
try:
    try:
        doc.ActiveWindow.View.ShowParagraphs = True
    except Exception as e:
        print('paras', e)
    rng = doc.Content
    find = rng.Find
    find.Text = NEEDLE
    find.Forward = True
    ok = find.Execute()
    print('find', ok, flush=True)
    if ok:
        app.Activate()
        doc.ActiveWindow.ScrollIntoView(rng, True)
    time.sleep(2.0)
    grab(OUT.replace('/', '\\'))
finally:
    doc.Close(0)
    app.Quit()
