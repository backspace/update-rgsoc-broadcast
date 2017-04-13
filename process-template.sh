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

export REPLACEMENT_STRING="in ${END_DAYS_FROM_NOW} day${PLURAL_DAYS}"

if [ $END_DAYS_FROM_NOW == 0 ]; then
  export REPLACEMENT_STRING="today"
fi

if [ $END_DAYS_FROM_NOW == -1 ]; then
  heroku pg:psql -a travis-production < expire-org.sql

  sed "s/3547/4106/" expire-org.sql > expire-com.sql
  heroku pg:psql -a travis-pro-production < expire-com.sql
fi

sed "s/REPLACE/$REPLACEMENT_STRING/" template.sql > update-org.sql
sed "s/3547/4106/" update-org.sql > update-com.sql
