# APPS="hrms insights"
APPS=""

if [ ! -d "sites/$SITE_NAME" ]; then
  echo "INFO: creating site $SITE_NAME"
  bench new-site \
    --mariadb-root-password $MYSQL_ROOT_PASSWORD \
    --admin-password $FRAPPE_ADMIN_PASSWORD \
    --mariadb-user-host-login-scope='%' \
    --install-app erpnext \
    --set-default $SITE_NAME
  
  if [ -n "$APPS" ]; then
    echo "INFO: installing extra apps"

    for app in $APPS; do
      app=$(echo "$app" | xargs)
      echo "INFO: installing $app..."
      bench --site $SITE_NAME install-app $app || true
    done
    bench --site $SITE_NAME clear-website-cache
    bench --site $SITE_NAME clear-cache
  else
    echo "INFO: no extra apps to install"
  fi

  chown -R 1000:1000 sites/assets
  bench --site $SITE_NAME enable-scheduler
else
  echo "INFO: site $SITE_NAME already exists"
fi

if [ "$INSTALL_APPS" = "true" ]; then
  if [ -n "$APPS" ]; then
    echo "INFO: installing extra apps"

    for app in $APPS; do
      app=$(echo "$app" | xargs)
      echo "INFO: installing $app..."
      bench --site $SITE_NAME install-app $app || true
      bench build --app $app
    done
    bench --site $SITE_NAME clear-website-cache
    bench --site $SITE_NAME clear-cache
  else
    echo "INFO: no extra apps to install"
  fi

fi

bench --site $SITE_NAME migrate;
