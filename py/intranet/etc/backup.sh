#!/bin/sh

cd /home/UCLM/francisco.moya/backup/
sqlite3 ../uclm-eii/py/intranet/eii.db .dump > eii.sql
git commit -m "Daily backup" -a 
git push

