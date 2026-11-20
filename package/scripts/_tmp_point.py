# -*- coding: utf-8 -*-
"""用 RangeFromPoint 判断页面左侧黑方块到底是什么对象"""
import time
import pythoncom
import win32com.client as win32
import win32gui
import win32ui
import win32con

DOC = r'E:/没用的的东西/2026下学期实训/文档/专业综合实践-课程设计作品-202301190144-袁文平-实训作品.docx'

pythoncom.CoInitialize()
app = win32.gencache.EnsureDispatch('Word.Application')
app.Visible = True
app.DisplayAlerts = 0
doc = app.Documents.Open(DOC.replace('/', '\\'))
try:
    app.Activate()
    app.Selection.GoTo(1, 1, 33)
    v = doc.ActiveWindow.View
    v.ShowParagraphs = False
    v.ShowSpaces = False
    time.sleep(1.5)
    print('shapes', doc.Shapes.Count, 'inline', doc.InlineShapes.Count)
    for i in range(1, min(doc.Shapes.Count, 10) + 1):
        s = doc.Shapes.Item(i)
        print('  shape', i, s.Type, s.Name, 'anchor page', s.Anchor.Information(3))
    for x, y in ((508, 448), (508, 470), (520, 450), (500, 445), (515, 445)):
        try:
            r = doc.ActiveWindow.RangeFromPoint(x, y)
            print('point', x, y, '->', type(r).__name__,
                  repr(getattr(r, 'Text', '')[:20]))
            try:
                print('    style', r.Paragraphs(1).Style.NameLocal)
            except Exception as e:
                print('    style err', e)
            try:
                print('    inline', r.InlineShapes.Count, 'shapes', r.ShapeRange.Count)
            except Exception as e:
                print('    shape err', e)
        except Exception as e:
            print('point', x, y, 'ERR', e)
finally:
    doc.Close(0)
    app.Quit()
