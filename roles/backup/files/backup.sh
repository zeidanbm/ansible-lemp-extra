#!/bin/bash

# MYSQL Parameters
MYSQL_UNAME=root
MYSQL_PWORD=$(echo MYSQL_PASS)
IGNORE_DB="(^mysql|_schema$)"

# Other Constants
TIMESTAMP=$(date +%F)
APP_DIR=("/var/www/wordpress-site")
BACKUP_DIR=/tmp
# include mysql and mysqldump binaries for cron bash user
PATH=$PATH:/usr/local/mysql/bin

#==============================================================================
# METHODS
#==============================================================================

function remove_old_files()
{
  find $1 -mtime $2 -exec rm -rf {} \;
  echo "Old files removed.\n\n"
}

function compress_files()
{
  tar --exclude='/var/www/wordpress-site/wp-content/cache' -cf "/tmp/$1.tar" "$2"
  echo "Files compressed.\n\n"
}

function copy_to_backup_folder()
{
  cp -r $1 "/backup/$2"
  echo "Files copied to drive.\n\n"
}

function delete_tmp_backups()
{
  echo "Deleting $BACKUP_DIR/$1"
  find $BACKUP_DIR -type f -name $1 -exec rm {} \;
}

function mysql_login() {
  local mysql_login="-u $MYSQL_UNAME"
  if [ -n "$MYSQL_PWORD" ]; then
    local mysql_login+=" -p$MYSQL_PWORD"
  fi
  echo $mysql_login
}

function database_list()
{
  local show_databases_sql="SHOW DATABASES WHERE \`Database\` NOT REGEXP '$IGNORE_DB'"
  echo $(mysql $(mysql_login) -e "$show_databases_sql"|awk -F " " '{if (NR!=1) print $1}')
}

function echo_status()
{
  printf '\r';
  printf ' %0.s' {0..100}
  printf '\r';
  printf "$1"'\r'
}

function backup_database()
{
    backup_file="$BACKUP_DIR/$TIMESTAMP.$database.sql.gz"
    output+="$database => $backup_file\n"
    echo_status "...backing up $count of $total databases: $database"
    $(mysqldump $(mysql_login) $database | gzip -9 > $backup_file)
}

function backup_databases()
{
  local databases=$(database_list)
  local total=$(echo $databases | wc -w | xargs)
  local output=""
  local count=1
  for database in $databases; do
    backup_database
    local count=$((count+1))
  done
  echo -ne $output | column -t
}

function hr(){
  printf '=%.0s' {1..100}
  printf "\n"
}

#==============================================================================
# RUN SCRIPT
#==============================================================================
compress_files $TIMESTAMP $APP_DIR
hr
copy_to_backup_folder "$BACKUP_DIR/$TIMESTAMP.tar" "app"
hr
delete_tmp_backups "*.tar"
hr
printf "App Backup finished successfully!"
hr
hr
backup_databases
hr
copy_to_backup_folder "$BACKUP_DIR/*.sql.gz" "database"
hr
delete_tmp_backups "*.sql.gz"
hr
printf "Database Backup finished successfully!"
hr
hr
remove_old_files "/backup/app" 10
remove_old_files "/backup/database" 30
printf "Removed old backup files successfully!\n\n"