#!/bin/bash
# tokens.sh - Token estimation and context window awareness
# Source this file: source lib/tokens.sh

TOKEN_LOG="${TOKEN_LOG:-$HOME/ralph-tokens.log}"
MAX_CONTEXT_TOKENS="${MAX_CONTEXT_TOKENS:-176000}"

# Estimate tokens (rough: ~4 chars per token for code)
estimate_tokens() {
    local text="$1"
    local chars=$(echo "$text" | wc -c | tr -d ' ')
    echo $((chars / 4))
}

# Log token usage
log_tokens() {
    local context="$1"
    local tokens="$2"
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $tokens tokens | $context" >> "$TOKEN_LOG"
}

# Check if we're approaching context limit
check_context_usage() {
    local current_tokens=$1
    local max_tokens=${2:-$MAX_CONTEXT_TOKENS}
    local usage_percent=$((current_tokens * 100 / max_tokens))

    if [ $usage_percent -gt 80 ]; then
        echo "[tokens] ⚠️ Context usage: ${usage_percent}% ($current_tokens/$max_tokens)"
        return 1
    elif [ $usage_percent -gt 50 ]; then
        echo "[tokens] Context usage: ${usage_percent}%"
    fi

    return 0
}

# Get total tokens used this session
get_session_tokens() {
    local today=$(date '+%Y-%m-%d')
    grep "$today" "$TOKEN_LOG" 2>/dev/null | awk -F'|' '{sum += $2} END {print sum+0}'
}

# Estimate spec complexity (for parallel scheduling)
estimate_spec_complexity() {
    local spec="$1"
    local tokens=$(estimate_tokens "$(cat "$spec")")

    if [ $tokens -lt 200 ]; then
        echo "small"
    elif [ $tokens -lt 500 ]; then
        echo "medium"
    else
        echo "large"
    fi
}
