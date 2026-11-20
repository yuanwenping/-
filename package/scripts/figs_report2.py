# -*- coding: utf-8 -*-
"""课程设计报告 图3.3 系统功能结构图（横向文字分层）"""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from figlib import Fig, quit_app

BASE = r'E:\毕业项目实训\pakeage\docs'
VSDX = os.path.join(BASE, '报告图源')
PNG = os.path.join(BASE, '图片')
os.makedirs(VSDX, exist_ok=True)

MODULES = [
    ('账号与组织', ['企业注册', '员工账号', '权限管理']),
    ('批次管理', ['原料批次', '加工批次', '批次关系']),
    ('业务填报', ['岗位表单', '附件证据', '提交审核']),
    ('审核与上链', ['审核意见', '链码提交', '失败重试']),
    ('交接流转', ['发货交接', '运输在途', '收货确认']),
    ('监管与查询', ['监管处置', '追溯查询', '存证核验']),
]

PITCH = 0.98
COLW = 0.90
X0 = 0.15
HEAD_Y, HEAD_H = 0.68, 0.32
ITEM_Y0, ITEM_STEP, ITEM_H = 1.22, 0.34, 0.26
ITEM_X_OFF, ITEM_W = 0.19, 0.71

W = 6.10
H = ITEM_Y0 + 3 * ITEM_STEP + 0.26
f = Fig(W, H, 'report-fn')
f.tag(0, H - 0.08, W, 0.08, ' ', size=1)   # 底部留白，避免导出裁边

# 根节点
root_w = 3.00
root_x = (W - root_w) / 2.0
f.rect(root_x, 0.12, root_w, 0.36, '常德酱板鸭全链条可信溯源系统', size=9)
f.arrow(W / 2.0, 0.48, W / 2.0, 0.60, arrow=False)

# 水平总线
first_cx = X0 + COLW / 2.0
last_cx = X0 + 5 * PITCH + COLW / 2.0
f.arrow(first_cx, 0.60, last_cx, 0.60, arrow=False)

for i, (name, items) in enumerate(MODULES):
    cx = X0 + i * PITCH + COLW / 2.0
    f.arrow(cx, 0.60, cx, HEAD_Y, arrow=False)
    f.rect(X0 + i * PITCH, HEAD_Y, COLW, HEAD_H, name, size=8)

    spine_x = X0 + i * PITCH + 0.07
    ys = [ITEM_Y0 + k * ITEM_STEP for k in range(len(items))]
    f.arrow(spine_x, HEAD_Y + HEAD_H, spine_x, ys[-1] + ITEM_H / 2.0, arrow=False)
    for k, (y, it) in enumerate(zip(ys, items)):
        f.rect(X0 + i * PITCH + ITEM_X_OFF, y, ITEM_W, ITEM_H, it, size=7.5)
        f.arrow(spine_x, y + ITEM_H / 2.0, X0 + i * PITCH + ITEM_X_OFF, y + ITEM_H / 2.0,
                arrow=False)

f.save(os.path.join(VSDX, '报告图3.3-系统功能结构图.vsdx'),
       os.path.join(PNG, 'figr_3.png'))
quit_app()
print('done')
