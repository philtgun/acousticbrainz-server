BEGIN;

CREATE EXTENSION IF NOT EXISTS "cube";

CREATE TABLE similarity (
  id INTEGER -- PK, FK to lowlevel
);

ALTER TABLE similarity ADD CONSTRAINT similarity_pkey PRIMARY KEY (id);

ALTER TABLE similarity
  ADD CONSTRAINT similarity_fk_lowlevel
  FOREIGN KEY (id)
  REFERENCES lowlevel (id);

CREATE TABLE similarity_metrics (
  metric TEXT, -- PK
  is_hybrid BOOLEAN,
  description TEXT,
  category TEXT,
  visible BOOLEAN
);

ALTER TABLE similarity_metrics ADD CONSTRAINT similarity_metrics_pkey PRIMARY KEY (metric);


CREATE TABLE similarity_stats (
  metric TEXT,  -- FK to metric
  means DOUBLE PRECISION[],
  stddevs DOUBLE PRECISION[]
);

ALTER TABLE similarity_stats ADD CONSTRAINT similarity_stats_pkey PRIMARY KEY (metric);

ALTER TABLE similarity_stats
  ADD CONSTRAINT similarity_stats_fk_metric
  FOREIGN KEY (metric)
  REFERENCES similarity_metrics (metric);


CREATE TABLE similarity_eval (
  user_id INTEGER, -- FK to user
  query_mbid UUID,
  result_mbids UUID[],
  metric TEXT, -- FK to metric
  rating SMALLINT,
  suggestion TEXT
);

ALTER TABLE similarity_eval
  ADD CONSTRAINT similarity_eval_fk_user
  FOREIGN KEY (user_id)
  REFERENCES "user" (id);

ALTER TABLE similarity_eval
  ADD CONSTRAINT similarity_eval_fk_metric
  FOREIGN KEY (metric)
  REFERENCES similarity_metrics (metric);

COMMIT;
