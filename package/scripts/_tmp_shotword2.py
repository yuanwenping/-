# -*- coding: utf-8 -*-
"""截取 Word 打印视图（显示段落/空格标记）用于定位“黑点”"""
import time
import pythoncom
import win32com.client as win32
import win32gui
import win32ui
import win32con

DOC = r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计报告-202301190144-袁文平.docx'
OUT = r'E:/毕业项目实训/pakeage/docs/预览/word_marks.bmp'


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
    try:
        doc.ActiveWindow.View.ShowSpaces = True
    except Exception as e:
        print('spaces', e)
    rng = doc.Content
    find = rng.Find
    find.Text = '图3.1  系统总体用例图'
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
