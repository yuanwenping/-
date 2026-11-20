# -*- coding: utf-8 -*-
"""对比：显示/隐藏编辑标记时，标题左侧方块是否消失；并读取 ListFormat 细节"""
import time
import pythoncom
import win32com.client as win32
import win32gui
import win32ui
import win32con

DOC = r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计作品-202301190144-袁文平-实训作品.docx'
NEEDLE = '4.3 区块链设计'


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
    rng = doc.Content
    rng.Find.Text = NEEDLE
    assert rng.Find.Execute()
    app.Activate()
    doc.ActiveWindow.ScrollIntoView(rng, True)
    par = rng.Paragraphs(1)
    lf = par.Range.ListFormat
    print('ListType', lf.ListType, 'ListString', repr(lf.ListString), 'Level', lf.ListLevelNumber)
    print('Style', par.Style.NameLocal, 'OutLine', par.OutlineLevel)
    print('text', repr(par.Range.Text[:12]))
    print('KeepWithNext', par.ParagraphFormat.KeepWithNext, 'PageBreakBefore', par.ParagraphFormat.PageBreakBefore)
    print('LeftIndent', par.ParagraphFormat.LeftIndent, 'FirstLineIndent', par.ParagraphFormat.FirstLineIndent)

    doc.ActiveWindow.View.ShowParagraphs = True
    time.sleep(1.2)
    grab(r'E:/毕业项目实训/pakeage/docs/预览/cmp_on.bmp')
    doc.ActiveWindow.View.ShowParagraphs = False
    time.sleep(1.2)
    grab(r'E:/毕业项目实训/pakeage/docs/预览/cmp_off.bmp')
    print('shots ok', flush=True)
finally:
    doc.Close(0)
    app.Quit()
