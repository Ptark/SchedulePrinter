BEGIN {
  today = strftime("%Y%m%d", systime());
}

{
  if (today == $1 || "Datum" == $1) {
    printf "%s %s %s %s\n", $2, $3, $4, $5;
  }

}


