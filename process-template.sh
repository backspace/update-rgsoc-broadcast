#!/usr/bin/env bash

export END_DATE_STRING="23:59 Apr 14 2017"
export END_DATE_EPOCH=$(date -d "$END_DATE_STRING" +%s)
export NOW_DATE_EPOCH=$(date -d "now" +%s)

export END_DAYS_FROM_NOW=$(( ($END_DATE_EPOCH - $NOW_DATE_EPOCH) / 86400))

if [ $END_DAYS_FROM_NOW == 1 ]; then
  export PLURAL_DAYS=""
else
  export PLURAL_DAYS="s"
fi

export REPLACEMENT_STRING="${END_DAYS_FROM_NOW} day${PLURAL_DAYS}"

sed "s/REPLACE/$REPLACEMENT_STRING/" template.sql > update.sql
