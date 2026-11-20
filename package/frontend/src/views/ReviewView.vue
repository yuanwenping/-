<script setup>
import { onMounted, ref } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { CircleCheck, CloseBold, View } from '@element-plus/icons-vue'
import { useRouter } from 'vue-router'
import http from '../api/http'
import { roleLabels } from '../utils/roles'
import StatusTag from '../components/StatusTag.vue'

const router = useRouter()
const loading = ref(false)
const rows = ref([])
const detailVisible = ref(false)
const selected = ref(null)
const reviewComment = ref('')
const approving = ref(false)
const rejecting = ref(false)
const batchApproving = ref(false)
const selection = ref([])

async function load() {
  loading.value = true
  try {
    rows.value = await http.get('/reviews/pending')
  } finally {
    loading.value = false
  }
}

function showDetail(row) {
  selected.value = row
  reviewComment.value = ''
  detailVisible.value = true
}

async function approve() {
  const isRetry = selected.value.chainStatus === 'CHAIN_FAILED'
  try {
    await ElMessageBox.confirm(
      isRetry
        ? '系统会重新对齐当前批次哈希并再次写入 Fabric。确认重试吗？'
        : '审核通过后，该业务事件将正式写入 Fabric，并推进批次状态。确认通过吗？',
      isRetry ? '确认重新上链' : '确认审核',
      { confirmButtonText: isRetry ? '确认重试' : '确认通过', cancelButtonText: '取消', type: 'warning' },
    )
  } catch {
    return
  }
  approving.value = true
  try {
    if (isRetry) {
      await http.post(`/events/${selected.value.eventId}/retry`)
      ElMessage.success('上链重试成功')
    } else {
      await http.post(`/reviews/${selected.value.eventId}/approve`, {
        comment: reviewComment.value,
      })
      ElMessage.success('审核通过并完成上链')
    }
    detailVisible.value = false
    await load()
  } finally {
    approving.value = false
  }
}

async function reject() {
  if (!reviewComment.value.trim()) {
    ElMessage.warning('驳回时必须填写原因')
    return
  }
  rejecting.value = true
  try {
    await http.post(`/reviews/${selected.value.eventId}/reject`, {
      comment: reviewComment.value,
    })
    ElMessage.success('已驳回，等待员工修改后重新提交')
    detailVisible.value = false
    await load()
  } finally {
    rejecting.value = false
  }
}

async function batchApprove() {
  if (!selection.value.length) {
    ElMessage.warning('请先勾选需要审核的业务')
    return
  }
  let comment = ''
  try {
    const result = await ElMessageBox.prompt(
      `将按业务时间顺序统一审核 ${selection.value.length} 条业务，并逐条写入 Fabric。`,
      '统一审核',
      {
        confirmButtonText: '确认统一通过',
        cancelButtonText: '取消',
        inputPlaceholder: '统一审核意见，可留空',
        inputValue: '统一审核通过',
      },
    )
    comment = result.value || ''
  } catch {
    return
  }

  batchApproving.value = true
  try {
    const result = await http.post('/reviews/batch-approve', {
      eventIds: selection.value.map((row) => row.eventId),
      comment,
    })
    if (result.failed) {
      ElMessage.warning(`已成功处理 ${result.succeeded}/${result.requested} 条。${result.error || ''}`)
    } else {
      ElMessage.success(`统一审核完成，共上链 ${result.succeeded} 条业务`)
    }
    selection.value = []
    await load()
  } finally {
    batchApproving.value = false
  }
}

function formattedPayload(payload) {
  try {
    return JSON.stringify(JSON.parse(payload || '{}'), null, 2)
  } catch {
    return payload
  }
}

onMounted(load)
</script>

<template>
  <div>
    <div class="header-row">
      <div>
        <h1 class="page-title">业务审核中心</h1>
        <p class="page-subtitle">
          各岗位员工可先分别上传业务，管理员在下方统一勾选审核。系统会按业务时间顺序逐条上链。
          本人提交的数据不会显示在自己的待审核列表中。
        </p>
      </div>
      <div class="header-actions">
        <el-button
          type="primary"
          :icon="CircleCheck"
          :loading="batchApproving"
          :disabled="!selection.length"
          @click="batchApprove"
        >
          统一审核通过{{ selection.length ? `（${selection.length}）` : '' }}
        </el-button>
        <el-button @click="load">刷新</el-button>
      </div>
    </div>

    <el-card>
      <el-table v-loading="loading" :data="rows" @selection-change="selection = $event">
        <el-table-column type="selection" width="48" />
        <el-table-column prop="batchNo" label="批次号" min-width="155">
          <template #default="{ row }"><span class="mono">{{ row.batchNo }}</span></template>
        </el-table-column>
        <el-table-column prop="productName" label="产品" min-width="130" />
        <el-table-column prop="eventType" label="业务类型" width="130" />
        <el-table-column label="链上状态" width="110">
          <template #default="{ row }"><StatusTag :status="row.chainStatus" /></template>
        </el-table-column>
        <el-table-column prop="submittedByName" label="提交员工" width="120" />
        <el-table-column prop="submittedByPhone" label="员工手机号" width="140" />
        <el-table-column label="岗位" width="145">
          <template #default="{ row }">{{ roleLabels[row.submittedRole] || row.submittedRole }}</template>
        </el-table-column>
        <el-table-column prop="submittedAt" label="提交时间" min-width="170" />
        <el-table-column label="操作" width="150">
          <template #default="{ row }">
            <el-button link type="primary" :icon="View" @click="showDetail(row)">审核</el-button>
            <el-button link @click="router.push(`/batches/${row.batchId}`)">批次</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-empty v-if="!loading && !rows.length" description="当前没有待审核业务" />
    </el-card>

    <el-dialog v-model="detailVisible" title="审核员工提交" width="760px">
      <template v-if="selected">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="批次号">{{ selected.batchNo }}</el-descriptions-item>
          <el-descriptions-item label="业务类型">{{ selected.eventType }}</el-descriptions-item>
          <el-descriptions-item label="提交员工">
            {{ selected.submittedByName }}（{{ selected.submittedByPhone }}）
          </el-descriptions-item>
          <el-descriptions-item label="岗位">
            {{ roleLabels[selected.submittedRole] || selected.submittedRole }}
          </el-descriptions-item>
          <el-descriptions-item label="业务时间">{{ selected.businessTime }}</el-descriptions-item>
          <el-descriptions-item label="地点">{{ selected.locationCode || '-' }}</el-descriptions-item>
          <el-descriptions-item label="链上状态">
            <StatusTag :status="selected.chainStatus" />
          </el-descriptions-item>
          <el-descriptions-item label="内容哈希" :span="2">
            <span class="mono">{{ selected.contentHash }}</span>
          </el-descriptions-item>
        </el-descriptions>

        <el-alert
          v-if="selected.chainStatus === 'CHAIN_FAILED'"
          type="error"
          :closable="false"
          show-icon
          title="该业务审核后上链失败，尚未写入区块链"
          :description="selected.chainError || '请点击重新上链，系统会自动对齐当前批次哈希。'"
          class="chain-error"
        />

        <h4>员工填报内容</h4>
        <pre class="payload">{{ formattedPayload(selected.payloadJson) }}</pre>

        <el-form-item label="审核意见">
          <el-input
            v-model="reviewComment"
            type="textarea"
            :rows="3"
            placeholder="通过时可选，驳回时必须填写原因"
          />
        </el-form-item>
      </template>
      <template #footer>
        <el-button :icon="CloseBold" :loading="rejecting" @click="reject">驳回并退回修改</el-button>
        <el-button type="primary" :icon="CircleCheck" :loading="approving" @click="approve">
          {{ selected?.chainStatus === 'CHAIN_FAILED' ? '重新上链' : '审核通过并上链' }}
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<style scoped>
.header-row {
  display: flex;
  justify-content: space-between;
  gap: 16px;
}
.header-actions {
  display: flex;
  align-items: flex-start;
  gap: 10px;
}
h4 {
  margin: 22px 0 10px;
}
.payload {
  max-height: 280px;
  overflow: auto;
  padding: 16px;
  border-radius: 10px;
  color: #5d473a;
  background: #f7eee2;
  font-size: 11px;
  line-height: 1.7;
  white-space: pre-wrap;
  word-break: break-word;
}
.chain-error {
  margin-top: 18px;
}
</style>
