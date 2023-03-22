#!/bin/sh

find /data \
    -name WifiConfigStore.xml \
    -print0 |
xargs -0 awk '

  /"SSID/ { s = 1 }
  /PreShared/ { p = 1 }

  s || p {
    gsub(/[<][^>]+[>]/, "")
    sub(/^[&]quot;/, "")
    sub(/[&]quot;$/, "")
    gsub(/[&]quot;/, "\"")
    gsub(/[&]amp;/, "\\&")
    gsub(/[&]lt;/, "<")
    gsub(/[&]gt;/, ">")
  }

  s { s = 0; printf "%-32.32s ", $0 }
  p { p = 0; print }

' | sort -f
