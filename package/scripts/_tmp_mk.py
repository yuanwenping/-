# -*- coding: utf-8 -*-
"""显示/隐藏编辑标记，同一页截图对比"""
import hashlib
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
    print('saved', path, hashlib.md5(open(path, 'rb').read()).hexdigest()[:10], flush=True)


pythoncom.CoInitialize()
app = win32.gencache.EnsureDispatch('Word.Application')
app.Visible = True
app.DisplayAlerts = 0
doc = app.Documents.Open(DOC.replace('/', '\\'))
try:
    app.Activate()
    app.Selection.GoTo(1, 1, 33)
    time.sleep(1.0)
    doc.ActiveWindow.View.ShowParagraphs = True
    time.sleep(2.0)
    grab(r'E:/毕业项目实训/pakeage/docs/预览/mk_on.bmp')
    doc.ActiveWindow.View.ShowParagraphs = False
    time.sleep(2.0)
    grab(r'E:/毕业项目实训/pakeage/docs/预览/mk_off.bmp')
    print('done', flush=True)
finally:
    doc.Close(0)
    app.Quit()
