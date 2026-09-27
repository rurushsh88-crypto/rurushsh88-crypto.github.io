#!/usr/bin/env bash
# 클라우드(웹) 세션에서만: "이 세션은 대장님 PC와 연결되어 있지 않다"를 대장님 화면과 Claude 컨텍스트 양쪽에 강제 주입.
[ "$CLAUDE_CODE_REMOTE" = "true" ] || exit 0
cat <<'JSON'
{
  "systemMessage": "⚠️⚠️ 이 세션은 대장님 PC와 연결되어 있지 않습니다 (클라우드 세션). PC의 ~/ms-trit, 로컬 스킬, CLAUDE.md, Docker에 접근할 수 없습니다. PC 작업은 폰 목록의 'MS-TRIT 메인'(ms-trit PC 세션)에서 하세요.",
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "[강제 규칙 — 클라우드 세션 경고] 지금 세션은 Anthropic 클라우드 컨테이너이며 대장님 PC(~/ms-trit)와 연결되어 있지 않다. 반드시: (1) 첫 응답 맨 앞에 굵게 '⚠️ 이 세션은 대장님 PC와 연결되어 있지 않습니다 (클라우드 세션)'을 쓰고, 할 수 있는 것(GitHub 블로그 저장소, 웹 조사, 컨트롤 타워 아티팩트 db, 드라이브 읽기)과 못 하는 것(PC 파일·로컬 스킬·CLAUDE.md·Docker·tmux·PC 켜기/끄기)을 한 줄씩 밝힌다. (2) 대화 중 PC 파일·스킬·로컬 작업이 필요한 요청이 오면 작업 전에 같은 경고를 다시 하고, PC 세션('MS-TRIT 메인', ms-trit 폴더)으로 옮기라고 안내한다. 추측으로 PC 상태를 말하지 않는다. (3) 이 경고를 생략하거나 약하게 줄이지 않는다. 근거: 2026-09-27 대장님이 폰 '새로 생성'으로 클라우드 세션을 열어 PC 세션으로 착각한 사고."
  }
}
JSON
