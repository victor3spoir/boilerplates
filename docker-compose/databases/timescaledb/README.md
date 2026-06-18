# Production-Ready TimescaleDB Cluster

This setup provides a production-ready TimescaleDB cluster with high availability, automated backups, and optimized configurations.

## Architecture

- **timescaledb-primary**: The primary TimescaleDB server
- **timescaledb-replica**: Replica in streaming replication mode
- **backup**: Service for scheduled backups

## Features

- TimescaleDB-HA with PostgreSQL 17
- High Availability with streaming replication
- Automated backup scheduling
- Performance-optimized configurations
- Resource constraints and monitoring
- Health checks for all services

## Prerequisites

Before deploying this setup, you need to:

1. Create a `.env` file with your environment variables (see below)
2. Ensure the `db-net` network exists (`docker network create db-net`)
3. Set up proper file permissions for the scripts

## Environment Variables

Create a `.env` file in the same directory as your `compose.yml` with the following variables:

```env
POSTGRES_DB=your_database_name
POSTGRES_USER=your_username
POSTGRES_PASSWORD=your_secure_password
REPLICATION_USER=replicator
REPLICATION_PASSWORD=secure_replication_password
```

## Deployment

```bash
# Create the required network if not already existing
docker network create db-net

# Make the backup script executable
chmod +x scripts/backup.sh

# Start the services
docker compose up -d
```

## Backup and Recovery

Backups are automatically performed by the backup service and stored in the `timescaledb-backup` volume. The retention period is set to 7 days by default.

To restore from a backup:

```bash
# List available backups
docker exec -it timescaledb-backup ls -la /backups

# Restore a specific backup
docker exec -it timescaledb-backup sh -c "pg_restore -h timescaledb-primary -U \$POSTGRES_USER -d \$POSTGRES_DB /backups/your_backup_file.sql.gz"
```

## Production Recommendations

1. **Secure Password Management**:
   - Use a proper secrets management solution like Docker Secrets or HashiCorp Vault
   - Never hardcode passwords in the configuration files

2. **Automated Failover**:
   - Consider using Patroni or pg_auto_failover for automated failover
   - Set up proper monitoring to detect failures

3. **Monitoring and Alerting**:
   - Deploy Prometheus and Grafana for monitoring
   - Set up alerting for critical metrics (CPU, memory, disk usage, connection count)

4. **Data Compression and Retention**:
   - Enable TimescaleDB compression for older data
   - Set up appropriate retention policies

5. **Continuous Aggregates**:
   - Use continuous aggregates for efficient querying of time-series data

6. **Scaling Considerations**:
   - Add more read replicas for read-heavy workloads
   - Consider vertical scaling for the primary instance

7. **Backup Strategy**:
   - Verify backups regularly
   - Store backups off-site or in a cloud storage service
   - Test the restore process periodically

8. **Performance Tuning**:
   - Adjust PostgreSQL and TimescaleDB parameters based on workload
   - Use `timescaledb-tune` for automated parameter optimization

9. **Security**:
   - Limit network access to database servers
   - Use TLS for client connections
   - Implement proper firewall rules

10. **Maintenance Window**:
    - Schedule regular maintenance windows for upgrades
    - Use connection pooling to minimize impact during maintenance

## TimescaleDB Specific Optimizations

1. **Chunk Time Interval**:
   - Adjust the chunk time interval based on your data ingestion rate
   - Aim for chunks between 25MB and 1GB in size

2. **Compression**:

   ```sql
   ALTER TABLE your_hypertable SET (
     timescaledb.compress,
     timescaledb.compress_orderby='time DESC',
     timescaledb.compress_segmentby='device_id'
   );
   SELECT add_compression_policy('your_hypertable', INTERVAL '7 days');
   ```

3. **Continuous Aggregates**:

   ```sql
   CREATE MATERIALIZED VIEW daily_summary
   WITH (timescaledb.continuous) AS
   SELECT time_bucket('1 day', time) AS day,
          device_id,
          avg(value) AS avg_value,
          max(value) AS max_value,
          min(value) AS min_value
   FROM measurements
   GROUP BY day, device_id;

   SELECT add_continuous_aggregate_policy('daily_summary',
     start_offset => INTERVAL '3 days',
     end_offset => INTERVAL '1 hour',
     schedule_interval => INTERVAL '1 day');
   ```

4. **Retention Policy**:

   ```sql
   SELECT add_retention_policy('your_hypertable', INTERVAL '6 months');
   ```

5. **Job Management**:

   ```sql
   -- Check status of background jobs
   SELECT * FROM timescaledb_information.jobs;
   ```

## Troubleshooting

1. **Check replication status**:

   ```bash
   docker exec -it timescaledb-primary psql -U postgres -c "SELECT * FROM pg_stat_replication;"
   ```

2. **View logs**:

   ```bash
   docker compose logs -f timescaledb-primary
   docker compose logs -f timescaledb-replica
   docker compose logs -f backup
   ```

3. **Manually trigger a backup**:

   ```bash
   docker exec -it backup /scripts/backup.sh
   ```

4. **Check disk usage**:

   ```bash
   docker exec -it timescaledb-primary df -h
   ```

5. **Monitor connections**:

   ```bash
   docker exec -it timescaledb-primary psql -U postgres -c "SELECT count(*) FROM pg_stat_activity;"
   ```