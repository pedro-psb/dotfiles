#!/bin/bash

# Read JSON input
input=$(cat)

# Extract values
model=$(echo "$input" | jq -r '.model.display_name')
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0')

# Calculate session cost (Claude pricing as of 2025)
# Sonnet: $3/MTok input, $15/MTok output
# Opus: $15/MTok input, $75/MTok output
if [[ "$model" == *"Opus"* ]]; then
    input_rate=15
    output_rate=75
else
    input_rate=3
    output_rate=15
fi

# Calculate cost in dollars
input_cost=$(echo "scale=4; $total_input * $input_rate / 1000000" | bc)
output_cost=$(echo "scale=4; $total_output * $output_rate / 1000000" | bc)
total_cost=$(echo "scale=4; $input_cost + $output_cost" | bc)

# Format cost with leading zero if needed
if (( $(echo "$total_cost < 1" | bc -l) )); then
    cost_str=$(printf "\$%.4f" "$total_cost")
else
    cost_str=$(printf "\$%.2f" "$total_cost")
fi

# Create progress bar (20 characters wide)
bar_width=20
filled=$(printf "%.0f" $(echo "$used_pct * $bar_width / 100" | bc -l))
empty=$((bar_width - filled))

bar=""
for ((i=0; i<filled; i++)); do bar+="█"; done
for ((i=0; i<empty; i++)); do bar+="░"; done

# Output status line
printf "%s | %s | Context: [%s] %.1f%%" "$model" "$cost_str" "$bar" "$used_pct"
