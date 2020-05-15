BEGIN {
  in_event = 0
  cnt = 1;
  today = strftime("%Y%m%d", systime());
}
{
  # check if in event
  if (in_event == 0) {
    if (match($0, "BEGIN:VEVENT")) {
      in_event = 1;
    }
} else {
    if (match($0, "END:VEVENT")) {
      in_event = !in_event;
      cnt++;
    } else if (match($0, "DTSTART")) {
      # get date from line and save in array
      date_idx = match($0, /[[:digit:]]+/) 
      date = substr($0, date_idx, 8);
      date_arr[cnt] = date;
      # get start time from line and save in array
      start_idx = match($0, /[[:digit:]]+Z/)
      start = substr($0, start_idx, 2) ":" substr($0, start_idx + 2, 2)
      start_arr[cnt] = start;
    } else if (match($0, "DTEND")) {
      # get end time from line and save in array
      end_idx = match($0, /[[:digit:]]+Z/)
      end = substr($0, end_idx, 2) ":" substr($0, end_idx + 2, 2)
      end_arr[cnt] = end;
    } else if (match($0, "LOCATION")) {
      # get location from line and save in array
      location_idx = match($0, /:/)
      location = substr($0, location_idx + 1)
      location_arr[cnt] = location;
    } else if (match($0, "SUMMARY")) {
      # get summary from line and save in array
      summary_idx = match($0, /:/)
      summary = substr($0, summary_idx + 1)
      summary_arr[cnt] = summary;
    }
  }
}

END {
  for (i = 1; i <= cnt; i++) {
    arr[i] = date_arr[i] " " start_arr[i] " " end_arr[i] " " summary_arr[i] " " location_arr[i];
  }
  asort(arr);
  arr[0] = "Datum Anfang Ende Termin Ort"
  for (key in arr) {
    print arr[key]
  }
}
