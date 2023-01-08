#!/usr/bin/bash

dunst_waiting=$(dunstctl 'count' 'waiting')
dunst_displayed=$(dunstctl 'count' 'displayed')

waiting_symbol="%{T4}祥 %{T-}"
displayed_symbol="%{T4} %{T-}"

# notifications=$((dunst_waiting + dunst_displayed))

# if ["$dunst_displayed" -ne 0 ]; then
#   echo "$waiting_symbol $dunst_waiting $displayed_symbol $dunst_displayed"
# fi

# echo " Hi "
echo $dunst_displayed
