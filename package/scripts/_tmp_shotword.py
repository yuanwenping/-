# -*- coding: utf-8 -*-
"""打开 Word（可见），开启“显示编辑标记”，滚动到图3.1 页并截屏，用于确认用户所见的小黑点来源"""
import os
import time
import pythoncom
import win32com.client as win32
import win32gui
import win32ui
import win32con

DOC = r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计报告-202301190144-袁文平.docx'
OUT = r'E:/毕业项目实训/pakeage/docs/预览/word_marks.bmp'

pythoncom.CoInitialize()
app = win32.gencache.EnsureDispatch('Word.Application')
app.Visible = True
app.DisplayAlerts = 0
doc = app.Documents.Open(DOC.replace('/', '\\'))
try:
    try:
        app.Options.ShowFormattingMarks = True
    except Exception as e:
        print('showmarks fail', e)
    app.WindowState = 1  # maximize
    rng = doc.Content
    find = rng.Find
    find.Text = '图3.1  系统总体用例图'
    find.Forward = True
    if find.Execute():
        doc.ActiveWindow.ScrollIntoView(rng, True)
    time.sleep(1.5)

    hwnd = win32gui.GetForegroundWindow()
    print('hwnd', hwnd, win32gui.GetWindowText(hwnd))
    left, top, right, bot = win32gui.GetWindowRect(hwnd)
    w, h = right - left, bot - top
    hwndDC = win32gui.GetWindowDC(hwnd)
    mfcDC = win32ui.CreateDCFromHandle(hwndDC)
    saveDC = mfcDC.CreateCompatibleDC()
    bmp = win32ui.CreateBitmap()
    bmp.CreateCompatibleBitmap(mfcDC, w, h)
    saveDC.SelectObject(bmp)
    saveDC.BitBlt((0, 0), (w, h), mfcDC, (0, 0), win32con.SRCCOPY)
    bmp.SaveBitmapFile(saveDC, OUT.replace('/', '\\'))
    print('saved', OUT, w, h, flush=True)
finally:
    doc.Close(0)
    app.Quit()
