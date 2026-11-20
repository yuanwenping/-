# -*- coding: utf-8 -*-
"""验证黑方块是否来自“显示对象锚点”"""
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
    print('saved', path, hashlib.md5(open(path, 'rb').read()).hexdigest()[:8], flush=True)


pythoncom.CoInitialize()
app = win32.gencache.EnsureDispatch('Word.Application')
app.Visible = True
app.DisplayAlerts = 0
doc = app.Documents.Open(DOC.replace('/', '\\'))
try:
    app.Activate()
    app.Selection.GoTo(1, 1, 33)
    time.sleep(1.2)
    v = doc.ActiveWindow.View
    v.ShowParagraphs = False
    v.ShowSpaces = False
    time.sleep(1.5)
    grab(r'E:/毕业项目实训/pakeage/docs/预览/an_on.bmp')
    v.ShowObjectAnchors = False
    v.ShowCropMarks = False
    time.sleep(1.5)
    grab(r'E:/毕业项目实训/pakeage/docs/预览/an_off.bmp')
    print('done', flush=True)
finally:
    doc.Close(0)
    app.Quit()
