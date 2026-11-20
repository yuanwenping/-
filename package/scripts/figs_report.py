# -*- coding: utf-8 -*-
"""课程设计报告 图3.1 系统总体用例图"""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from figlib import Fig, quit_app

BASE = r'E:\毕业项目实训\pakeage\docs'
VSDX = os.path.join(BASE, '报告图源')
PNG = os.path.join(BASE, '图片')
os.makedirs(VSDX, exist_ok=True)

W, H = 8.60, 7.40
f = Fig(W, H, 'report-uc')

f.boundary(2.30, 0.16, 4.50, 7.05, '常德酱板鸭全链条可信溯源系统', size=11)

COL_A, COL_B = 2.45, 4.62
CW, CH = 2.02, 0.44
STEP = 0.86
ROW0_A = 0.50
ROW0_B = 1.36

LEFT_CASES = ['创建追溯批次', '岗位业务填报', '质量自检提交', '审核与上链确认',
              '交接流转确认', '运输过程登记', '销售出库登记', '门店追溯码核验']
RIGHT_CASES = ['追溯查询与核验', '监督抽检与处置', '企业注册审核',
               '账号与角色管理', '审计日志查看', '扫码查询产品履历']


def box(tag, idx):
    if tag == 'A':
        return COL_A, ROW0_A + idx * STEP
    return COL_B, ROW0_B + idx * STEP


for i, n in enumerate(LEFT_CASES):
    x, y = box('A', i)
    f.ellipse(x, y, CW, CH, n, size=9)
for i, n in enumerate(RIGHT_CASES):
    x, y = box('B', i)
    f.ellipse(x, y, CW, CH, n, size=9)

LEFT_ACTORS = [
    ('原料供应商', 0.52, [('A', 0), ('A', 1), ('A', 2)]),
    ('加工企业', 2.12, [('A', 0), ('A', 1), ('A', 2), ('A', 3)]),
    ('物流企业', 3.72, [('A', 4), ('A', 5)]),
    ('销售商', 5.32, [('A', 4), ('A', 6), ('A', 7)]),
]
RIGHT_ACTORS = [
    ('监管部门', 1.10, [('B', 0), ('B', 1)]),
    ('平台管理员', 3.20, [('B', 2), ('B', 3), ('B', 4)]),
    ('消费者', 5.20, [('B', 5)]),
]

for name, ay, links in LEFT_ACTORS:
    anchor = f.actor(0.36, ay, name, size=10, label_w=1.20)
    for tag, idx in links:
        x, y = box(tag, idx)
        f.arrow(anchor[0] + 0.19, anchor[1], x, y + CH / 2.0)

for name, ay, links in RIGHT_ACTORS:
    anchor = f.actor(7.10, ay, name, size=10, label_w=1.28)
    for tag, idx in links:
        x, y = box(tag, idx)
        f.arrow(anchor[0] - 0.19, anchor[1], x + CW, y + CH / 2.0)

f.save(os.path.join(VSDX, '报告图3.1-系统总体用例图.vsdx'),
       os.path.join(PNG, 'figr_1.png'))
quit_app()
print('done')
