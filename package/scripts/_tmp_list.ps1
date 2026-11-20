$ErrorActionPreference = 'Stop'
$path = 'E:\没用的的东西\2026下学期实训\文档\专业综合实践-课程设计报告-202301190144-袁文平.docx'
$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0
$doc = $word.Documents.Open($path, $false, $true)
$n = $doc.Paragraphs.Count
Write-Output "paragraphs=$n"
for ($i = 1; $i -le $n; $i++) {
    $p = $doc.Paragraphs.Item($i)
    $lt = $p.Range.ListFormat.ListType
    $t = $p.Range.Text
    if ($t.Length -gt 60) { $t = $t.Substring(0, 60) }
    $t = $t -replace "[\r\n\a]", ''
    if ($lt -ne 0) {
        Write-Output ("LIST i=$i type=$lt style=" + $p.Style.NameLocal + " text=" + $t)
    }
}
$doc.Close(0)
$word.Quit()
