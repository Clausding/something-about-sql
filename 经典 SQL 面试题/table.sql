CREATE TABLE t_student (
  sid varchar(10) NOT NULL,
  sName varchar(20) DEFAULT NULL,
  sAge datetime DEFAULT '1980-10-12 23:12:36',
  sSex varchar(10) DEFAULT NULL,
  PRIMARY KEY (sid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE t_course (
  cid varchar(10) NOT NULL,
  cName varchar(10) DEFAULT NULL,
  tid int(20) DEFAULT NULL,
  PRIMARY KEY (cid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE t_score (
  sid varchar(10) DEFAULT NULL,
  cid varchar(10) DEFAULT NULL,
  score int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE t_teacher (
  tid int(10) DEFAULT NULL,
  tName varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;