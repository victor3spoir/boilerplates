# Dockerlab

## How backup your volume

### backup & restore local volumes data

- Backup

```bash
  docker run --rm --mount source=<volume_name>,target=<volume_path_inside_target_container> \
    -v $(pwd):<path_inside_busybox_container> \
    busybox \
    tar -czvf <path_inside_busybox_container/backup_name.tar.gz> <volume_path_inside_target_container>
```

- Restore

```bash
 docker run --rm \ 
    --mount source=<volume_name>,target=<volume_path_inside_target_container> \
    -v $(pwd):<path_inside_busybox_container> \
    busybox \
    tar -xzvf <path_inside_busybox_container/backup_name.tar.gz> -C /
```

- Example

```bash
  docker run --rm --mount source=uptime_kuma_storage,target=/app/data \
    -v $(pwd):/backups \
    busybox \
    tar -cvzf /backups/uptime_kuma_storage.tar.gz /app/data
```

```bash
  docker run --rm --mount source=uptime_kuma_storage,target=/app/data \
    -v $(pwd):/backups \
    busybox \
    tar -xvzf /backups/uptime_kuma_storage.tar.gz /
```


