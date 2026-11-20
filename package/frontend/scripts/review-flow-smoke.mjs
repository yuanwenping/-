import { chromium } from 'playwright-core'
import path from 'node:path'

const edgePath = 'C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe'
const runtimeDir = path.resolve(process.cwd(), '..', 'runtime')
const baseUrl = process.env.UI_BASE_URL || 'http://127.0.0.1:5173'
const batchId = process.env.TEST_BATCH_ID || 'B-C43F968FBCB24D27A66E'
const suffix = new Date().toISOString().replace(/[-:.TZ]/g, '').slice(0, 14)

const browser = await chromium.launch({ headless: true, executablePath: edgePath })
const page = await browser.newPage({ viewport: { width: 1440, height: 1100 } })
const browserErrors = []
page.on('pageerror', (error) => browserErrors.push(error.message))
page.on('console', (message) => {
  if (message.type() === 'error' && !message.text().includes('status of 404')) {
    browserErrors.push(message.text())
  }
})

async function login(username, password) {
  if (page.url() === 'about:blank') {
    await page.goto(`${baseUrl}/login`, { waitUntil: 'domcontentloaded' })
  }
  await page.evaluate(() => localStorage.clear())
  await page.goto(`${baseUrl}/login`, { waitUntil: 'domcontentloaded' })
  await page.getByPlaceholder('手机号码或平台管理账号').fill(username)
  await page.getByPlaceholder('请输入登录密码').fill(password)
  await page.getByRole('button', { name: '登录系统' }).click()
  await page.waitForURL('**/dashboard')
}

try {
  await login('13910000002', '12345678')
  await page.goto(`${baseUrl}/batches/${batchId}`, { waitUntil: 'domcontentloaded' })
  await page.getByRole('button', { name: '登记业务事件' }).click()

  const dialog = page.getByRole('dialog', { name: '养殖与用药记录' })
  await dialog.waitFor()
  await dialog.getByPlaceholder('养殖批次号').fill(`YANGZHI-${suffix}`)
  await dialog.getByPlaceholder('饲料批次号').fill(`SILIAO-${suffix}`)
  const withdrawalInput = dialog.locator('.el-form-item').filter({ hasText: '休药期截止日' }).locator('input')
  await withdrawalInput.fill('2026-12-01')
  await withdrawalInput.press('Enter')
  await dialog.getByPlaceholder('当前存栏数量').fill('100')
  await dialog.getByPlaceholder('例如：常德加工一车间').fill('浏览器审核流程联调')
  await dialog.getByRole('button', { name: '提交管理员审核' }).click()
  await page.getByText('业务记录已提交，等待企业管理员审核').waitFor()
  await page.screenshot({ path: path.join(runtimeDir, 'event-submit-smoke.png'), fullPage: true })

  await login('13910000001', '12345678')
  await page.goto(`${baseUrl}/reviews`, { waitUntil: 'domcontentloaded' })
  const row = page.locator('.el-table__body tr').first()
  await row.getByRole('button', { name: '审核' }).click()
  const reviewDialog = page.getByRole('dialog', { name: '审核员工提交' })
  await reviewDialog.waitFor()
  await reviewDialog.getByPlaceholder('通过时可选，驳回时必须填写原因').fill('浏览器审核流程联调通过')
  await reviewDialog.getByRole('button', { name: '审核通过并上链' }).click()
  await page.getByRole('button', { name: '确认通过' }).click()
  await page.getByText('审核通过并完成上链').waitFor()
  await page.screenshot({ path: path.join(runtimeDir, 'review-approve-smoke.png'), fullPage: true })

  if (browserErrors.length) {
    throw new Error(`Browser errors: ${browserErrors.join(' | ')}`)
  }
  console.log('REVIEW_FLOW_UI_SMOKE_OK')
} finally {
  await browser.close()
}
