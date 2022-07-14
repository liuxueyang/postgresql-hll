-- ----------------------------------------------------------------
-- Type Modifier Signature
-- ----------------------------------------------------------------

SELECT hll_set_output_version(1);

DROP TABLE IF EXISTS test_qiundgkm;

-- Using all defaults.
CREATE TABLE test_qiundgkm (v1 hll) DISTRIBUTED RANDOMLY;
\d test_qiundgkm
DROP TABLE test_qiundgkm;

-- Partial defaults.
CREATE TABLE test_qiundgkm (v1 hll(10)) DISTRIBUTED RANDOMLY;
\d test_qiundgkm
DROP TABLE test_qiundgkm;

CREATE TABLE test_qiundgkm (v1 hll(10, 4)) DISTRIBUTED RANDOMLY;
\d test_qiundgkm
DROP TABLE test_qiundgkm;

CREATE TABLE test_qiundgkm (v1 hll(10, 4, 64)) DISTRIBUTED RANDOMLY;
\d test_qiundgkm
DROP TABLE test_qiundgkm;

CREATE TABLE test_qiundgkm (v1 hll(10, 4, 64, 0)) DISTRIBUTED RANDOMLY;
\d test_qiundgkm
DROP TABLE test_qiundgkm;

-- ERROR:  invalid number of type modifiers
CREATE TABLE test_qiundgkm (v1 hll(10, 4, 64, 0, 42)) DISTRIBUTED RANDOMLY;

-- ----------------------------------------------------------------
-- Range Check log2nregs
-- ----------------------------------------------------------------

-- ERROR:  log2m modifier must be between 0 and 17
CREATE TABLE test_qiundgkm (v1 hll(-1)) DISTRIBUTED RANDOMLY;

CREATE TABLE test_qiundgkm (v1 hll(0)) DISTRIBUTED RANDOMLY;
\d test_qiundgkm
DROP TABLE test_qiundgkm;

CREATE TABLE test_qiundgkm (v1 hll(31)) DISTRIBUTED RANDOMLY;
\d test_qiundgkm
DROP TABLE test_qiundgkm;

-- ERROR:  log2m modifier must be between 0 and 17
CREATE TABLE test_qiundgkm (v1 hll(32)) DISTRIBUTED RANDOMLY;

-- ----------------------------------------------------------------
-- Range Check regwidth
-- ----------------------------------------------------------------

-- ERROR:  regwidth modifier must be between 0 and 7
CREATE TABLE test_qiundgkm (v1 hll(11, -1)) DISTRIBUTED RANDOMLY;

CREATE TABLE test_qiundgkm (v1 hll(11, 0)) DISTRIBUTED RANDOMLY;
\d test_qiundgkm
DROP TABLE test_qiundgkm;

CREATE TABLE test_qiundgkm (v1 hll(11, 7)) DISTRIBUTED RANDOMLY;
\d test_qiundgkm
DROP TABLE test_qiundgkm;

-- ERROR:  regwidth modifier must be between 0 and 7
CREATE TABLE test_qiundgkm (v1 hll(11, 8)) DISTRIBUTED RANDOMLY;

-- ----------------------------------------------------------------
-- Range Check expthresh
-- ----------------------------------------------------------------

-- ERROR:  expthresh modifier must be between -1 and 16383
CREATE TABLE test_qiundgkm (v1 hll(11, 5, -2)) DISTRIBUTED RANDOMLY;

CREATE TABLE test_qiundgkm (v1 hll(11, 5, -1)) DISTRIBUTED RANDOMLY;
\d test_qiundgkm
DROP TABLE test_qiundgkm;

CREATE TABLE test_qiundgkm (v1 hll(11, 5, 0)) DISTRIBUTED RANDOMLY;
\d test_qiundgkm
DROP TABLE test_qiundgkm;

CREATE TABLE test_qiundgkm (v1 hll(11, 5, 128)) DISTRIBUTED RANDOMLY;
\d test_qiundgkm
DROP TABLE test_qiundgkm;

CREATE TABLE test_qiundgkm (v1 hll(11, 5, 4294967296)) DISTRIBUTED RANDOMLY;
\d test_qiundgkm
DROP TABLE test_qiundgkm;

-- ERROR:  expthresh modifier must be between -1 and 16383
CREATE TABLE test_qiundgkm (v1 hll(11, 5, 8589934592)) DISTRIBUTED RANDOMLY;

-- ----------------------------------------------------------------
-- Range Check nosparse
-- ----------------------------------------------------------------

-- ERROR:  nosparse modifier must be 0 or 1
CREATE TABLE test_qiundgkm (v1 hll(11, 5, 128, -1)) DISTRIBUTED RANDOMLY;

CREATE TABLE test_qiundgkm (v1 hll(11, 5, 128, 0)) DISTRIBUTED RANDOMLY;
\d test_qiundgkm
DROP TABLE test_qiundgkm;

CREATE TABLE test_qiundgkm (v1 hll(11, 5, 128, 1)) DISTRIBUTED RANDOMLY;
\d test_qiundgkm
DROP TABLE test_qiundgkm;

-- ERROR:  nosparse modifier must be 0 or 1
CREATE TABLE test_qiundgkm (v1 hll(11, 5, 128, 2)) DISTRIBUTED RANDOMLY;
