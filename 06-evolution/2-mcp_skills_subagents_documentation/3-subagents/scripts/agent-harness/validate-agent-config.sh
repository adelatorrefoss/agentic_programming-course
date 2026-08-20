#!/usr/bin/env bash
set -euo pipefail

AGENT_DIR="${1:-.agents/agents}"
allowed_tools="read search edit execute todo"
agent_count=0
failure_count=0
declare -A agent_names=()

if [[ ! -d "$AGENT_DIR" ]]; then
	echo "Agent directory not found: ${AGENT_DIR}" >&2
	exit 1
fi

has_frontmatter_key() {
	local frontmatter="$1"
	local key="$2"

	printf '%s\n' "$frontmatter" | grep -Eq "^${key}:[[:space:]]*[^[:space:]].*$"
}

validate_tools() {
	local frontmatter="$1"
	local tools_line
	local tools
	local tool

	tools_line="$(printf '%s\n' "$frontmatter" | grep -E '^tools:[[:space:]]*\[[^]]*\][[:space:]]*$' || true)"
	if [[ -z "$tools_line" ]]; then
		return 1
	fi

	tools="${tools_line#*[}"
	tools="${tools%]*}"
	IFS=',' read -r -a declared_tools <<< "$tools"

	if [[ "${#declared_tools[@]}" -eq 0 ]]; then
		return 1
	fi

	for tool in "${declared_tools[@]}"; do
		tool="${tool//[[:space:]]/}"
		if [[ -z "$tool" || ! " $allowed_tools " == *" $tool "* ]]; then
			echo "    unsupported tool: ${tool:-<empty>}" >&2
			return 1
		fi
	done
}

for file in "$AGENT_DIR"/*.md; do
	[[ -f "$file" ]] || continue
	agent_count=$((agent_count + 1))
	file_error=false
	first_line="$(sed -n '1p' "$file")"
	closing_line="$(awk 'NR > 1 && $0 == "---" { print NR; exit }' "$file")"

	if [[ "$first_line" != "---" || -z "$closing_line" ]]; then
		echo "${file}: invalid frontmatter delimiters" >&2
		failure_count=$((failure_count + 1))
		continue
	fi

	frontmatter="$(sed -n "2,$((closing_line - 1))p" "$file")"
	body="$(tail -n +"$((closing_line + 1))" "$file")"

	for key in name description tools; do
		if ! has_frontmatter_key "$frontmatter" "$key"; then
			echo "${file}: missing frontmatter key '${key}'" >&2
			file_error=true
		fi
	done

	if ! validate_tools "$frontmatter"; then
		echo "${file}: invalid tools declaration (allowed: ${allowed_tools})" >&2
		file_error=true
	fi

	name="$(printf '%s\n' "$frontmatter" | sed -n 's/^name:[[:space:]]*//p' | head -n 1)"
	if [[ -n "${agent_names[$name]:-}" ]]; then
		echo "${file}: duplicate agent name '${name}'" >&2
		file_error=true
	else
		agent_names["$name"]="$file"
	fi

	if ! printf '%s\n' "$body" | grep -Eq '^#[[:space:]]+[^[:space:]].*$'; then
		echo "${file}: missing role title heading" >&2
		file_error=true
	fi

	if ! printf '%s\n' "$body" | grep -Eq '^##[[:space:]]+[^[:space:]].*$'; then
		echo "${file}: missing role documentation section" >&2
		file_error=true
	fi

	if [[ "$file_error" == true ]]; then
		failure_count=$((failure_count + 1))
	fi
done

if [[ "$agent_count" -eq 0 ]]; then
	echo "No agent definitions found in ${AGENT_DIR}." >&2
	exit 1
fi

if [[ "$failure_count" -gt 0 ]]; then
	echo "Agent configuration validation failed: ${failure_count} file(s)." >&2
	exit 1
fi

echo "Agent configuration valid: ${agent_count} definition(s)."
