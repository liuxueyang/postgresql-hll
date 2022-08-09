CREATE EXTENSION hll VERSION '2.16';

-- Using random distribution policy by default when creating tables
ALTER database contrib_regression
  SET gp_create_table_random_default_distribution TO 'on';

-- We only need the latest sql file when release. So there is no need to test
-- the upgrade SQL file

-- ALTER EXTENSION hll UPDATE TO '2.11';
-- ALTER EXTENSION hll UPDATE TO '2.12';
-- ALTER EXTENSION hll UPDATE TO '2.13';
-- ALTER EXTENSION hll UPDATE TO '2.14';
-- ALTER EXTENSION hll UPDATE TO '2.15';
-- ALTER EXTENSION hll UPDATE TO '2.16';
