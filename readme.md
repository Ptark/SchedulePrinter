# Schedule printer
This is a small repository for awk scripts which search for .iCal and .ics files in ~/Library/Calendars and print your schedule to the terminal.

extract_schedule extracts all meetings and prints them sorted by date-start-end

print_todays_schedule filters for meeting with todays date and prints them.

For easy use add the following aliases to your .bashrc:

alias today='find ~/Library/Calendars/ \( -name "*.ics" -o -name "*.iCal" \) -exec awk -f ~/repositories/SchedulePrinter/extract_schedule.awk {} \; | awk -f ~/repositories/SchedulePrinter/print_todays_schedule.awk | column -t'
