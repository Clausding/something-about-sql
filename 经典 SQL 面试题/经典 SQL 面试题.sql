1、查询“001”课程比“002”课程成绩高的所有学生的学号; 
SELECT a.sid FROM
  (SELECT sid, score FROM t_score WHERE cid = '001') a,
  (SELECT sid, score FROM t_score WHERE cid = '002') b
WHERE a.score > b.score AND a.sid = b.sid;

2、查询平均成绩大于60分的同学的学号和平均成绩; 
SELECT sid, AVG(score)
FROM t_score
GROUP BY sid 
HAVING AVG(score) > 60;

3、查询所有同学的学号、姓名、选课数、总成绩; 
SELECT a.sid, a.sName, COUNT(b.cid), SUM(b.score)
FROM t_student a LEFT OUTER JOIN t_score b 
ON a.sid = b.sid
GROUP BY a.sid;

4、查询姓“李”的老师的个数; 
SELECT COUNT(*)
FROM t_teacher
WHERE tName LIKE '李%';

5、查询没学过“叶平”老师课的同学的学号、姓名; 
SELECT sid, sName
FROM t_student
WHERE sid NOT IN (SELECT DISTINCT a.sid
                  FROM t_score a INNER JOIN t_course b INNER JOIN t_teacher c
                  ON a.cid = b.cid AND b.tid = c.tid
                  WHERE c.tName = '叶平');

6、查询学过“001”并且也学过编号“002”课程的同学的学号、姓名; 
SELECT a.sid, a.sName
FROM t_student a INNER JOIN t_score b ON a.sid = b.sid
WHERE b.cid = '001' 
AND EXISTS (
  SELECT * FROM t_score b2 WHERE b.sid = b2.sid AND b2.cid = '002');

7、查询学过“叶平”老师所教的所有课的同学的学号、姓名;
SELECT sid, sName
FROM t_student
WHERE sid IN (SELECT a.sid
              FROM t_score a INNER JOIN t_course b INNER JOIN t_teacher c
              ON a.cid = b.cid AND b.tid = c.tid
              WHERE c.tName = '叶平'
              GROUP BY a.sid
              HAVING COUNT(*) = ( SELECT COUNT(*) 
                                  FROM t_course a INNER JOIN t_teacher b
                                  ON a.tid = b.tid
                                  WHERE tName = '叶平'));

8、查询课程编号“002”的成绩比课程编号“001”课程低的所有同学的学号、姓名; 
SELECT sid, sName 
FROM t_student
WHERE sid IN( SELECT a.sid
              FROM t_score a INNER JOIN t_score b
              ON a.sid = b.sid AND a.cid = '001' AND b.cid = '002' AND a.score > b.score);

9、查询所有课程成绩小于60分的同学的学号、姓名; 
SELECT sid, sName 
FROM t_student
WHERE sid NOT IN( SELECT DISTINCT sid 
                  FROM t_score
                  WHERE score >= 60);

10、查询没有学全所有课的同学的学号、姓名; 
SELECT sid, sName 
FROM t_student
WHERE sid NOT IN( SELECT sid 
                  FROM t_score
                  GROUP BY sid
                  HAVING COUNT(*) = ( SELECT COUNT(*)
                                      FROM t_course));

11、查询至少有一门课与学号为“1”的同学所学相同的同学的学号和姓名; 
SELECT sid, sName 
FROM t_student
WHERE sid IN( SELECT b.sid
              FROM t_score a INNER JOIN t_score b
              ON a.sid = '1' AND a.cid = b.cid AND b.sid != '1');

13、把“t_score”表中“叶平”老师教的课的成绩都更改为此课程的平均成绩; 
UPDATE t_score a, ( SELECT b.cid, AVG(a.score) avg
                      FROM t_score a INNER JOIN t_course b INNER JOIN t_teacher c
                      ON a.cid = b.cid AND b.tid = c.tid AND c.tName = '叶平'
                      GROUP BY b.cid
                      ) b
SET a.score = b.avg
WHERE a.cid = b.cid;

14、查询和“1002”号的同学学习的课程完全相同的其他同学学号和姓名; 
SELECT sid, sName 
FROM t_student
WHERE sid IN(
  SELECT b.sid
  FROM t_score a INNER JOIN t_score b
  ON a.sid = '2' AND a.cid = b.cid AND b.sid !='2'
  GROUP BY b.sid
  HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM t_score
    WHERE sid = '2'
  )
);

15、删除学习“叶平”老师课的SC表记录; 
DELETE FROM t_score
WHERE cid IN(
  SELECT cid 
  FROM t_course a INNER JOIN t_teacher b
  ON b.tName = '叶平' AND a.tid = b.tid
);

17、按平均成绩从高到低显示所有学生的“数据库”、“企业管理”、“英语”三门的课程成绩，按如下形式显示： 学生ID,数据库,企业管理,英语,有效课程数,有效平均分 
SELECT sid AS 学生ID,
  (SELECT score FROM t_score WHERE sid = a.sid AND cid = '004') AS 数据库,
  (SELECT score FROM t_score WHERE sid = a.sid AND cid = '001') AS 企业管理,
  (SELECT score FROM t_score WHERE sid = a.sid AND cid = '005') AS 英语,
  COUNT(*) AS 有效课程数,
  AVG(a.score) AS 有效平均分
FROM t_score a
GROUP BY sid
ORDER BY AVG(score);

18、查询各科成绩最高和最低的分：以如下形式显示。
课程ID，最高分，最低分。
SELECT cid AS 课程ID,
  MAX(score) AS 最高分,
  MIN(score) AS 最低分
FROM t_score
GROUP BY cid

19、查询各科平均成绩和及格率，以如下形式显示，并按照合格率从低到高排序。
课程ID，课程名称，平均成绩，合格率。
SELECT a.cid AS 课程ID,
  a.cName AS 课程名称,
  AVG(b.score) AS 平均成绩,
  100*SUM(CASE WHEN b.score >= 60 THEN 1 ELSE 0 END) /COUNT(*) AS 合格率
FROM t_course a INNER JOIN t_score b
ON a.cid = b.cid
GROUP BY a.cid
ORDER BY 100*SUM(CASE WHEN b.score >= 60 THEN 1 ELSE 0 END) /COUNT(*) DESC;

20、查询如下课程平均成绩和及格率，并在一行内显示。
企业管理（001），马克思（002），OO&UML （003），数据库（004）。
SELECT SUM(CASE WHEN cid = '001' THEN score ELSE 0 END) / SUM(CASE WHEN cid = '001' THEN 1 ELSE 0 END) AS 企业管理平均成绩,
  SUM(CASE WHEN cid = '001' AND score>=60 THEN 1 ELSE 0 END) /SUM(CASE WHEN cid = '001' THEN 1 ELSE 0 END) AS 企业管理及格率,
  SUM(CASE WHEN cid = '002' THEN score ELSE 0 END) / SUM(CASE WHEN cid = '002' THEN 1 ELSE 0 END) AS 马克思平均成绩,
  SUM(CASE WHEN cid = '002' AND score>=60 THEN 1 ELSE 0 END) /SUM(CASE WHEN cid = '002' THEN 1 ELSE 0 END) AS 马克思及格率,
  SUM(CASE WHEN cid = '003' THEN score ELSE 0 END) / SUM(CASE WHEN cid = '003' THEN 1 ELSE 0 END) AS UML平均成绩,
  SUM(CASE WHEN cid = '003' AND score>=60 THEN 1 ELSE 0 END) /SUM(CASE WHEN cid = '003' THEN 1 ELSE 0 END) AS UML及格率,
  SUM(CASE WHEN cid = '004' THEN score ELSE 0 END) / SUM(CASE WHEN cid = '004' THEN 1 ELSE 0 END) AS 数据库平均成绩,
  SUM(CASE WHEN cid = '004' AND score>=60 THEN 1 ELSE 0 END) /SUM(CASE WHEN cid = '004' THEN 1 ELSE 0 END) AS 数据库及格率
FROM t_score;

21、查询下列项目，并按照平均分从高到低排列。
教师ID，教师名称，课程ID，课程名称，平均分。
SELECT a.tid AS 教师ID,
a.tName AS 教师名称,
b.cid AS 课程ID,
b.cName AS 课程名称,
AVG(c.score) 平均分
FROM t_teacher a INNER JOIN t_course b INNER JOIN t_score c
ON a.tid = b.tid AND b.cid = c.cid
GROUP BY b.cid
ORDER BY AVG(c.score) DESC;

23、按照分数段统计各科成绩，格式如下：
课程ID,课程名称,[100-85],[85-70],[70-60],[ <60]。
SELECT a.cid AS 课程ID,
a.cName AS 课程名称,
SUM(CASE WHEN b.score BETWEEN 85 AND 100 THEN 1 ELSE 0 END) AS '[100-85]',
SUM(CASE WHEN b.score BETWEEN 70 AND 85 THEN 1 ELSE 0 END) AS '[85-70]',
SUM(CASE WHEN b.score BETWEEN 60 AND 70 THEN 1 ELSE 0 END) AS '[70-60]',
SUM(CASE WHEN b.score BETWEEN 0 AND 60 THEN 1 ELSE 0 END) AS '[ <60]'
FROM t_course a INNER JOIN t_score b
ON a.cid = b.cid
GROUP BY a.cid;

26、查询每门课程被选修的学生数 
SELECT cid, COUNT(*)
FROM t_score
GROUP BY cid;

27、查询出每个学生的选课数量，格式如下：
学生ID, 学生姓名，选课数量。
SELECT a.sid AS '学生ID', 
  a.sName  AS '学生姓名', 
  COUNT(*) AS '选课数量'
FROM t_student a INNER JOIN t_score b
ON a.sid = b.sid
GROUP BY a.sid;

28、查询男生人数
SELECT COUNT(*) AS '男生人数'
FROM t_student
GROUP BY sSex
HAVING sSex = '男';

29、查询姓“张”的学生名单 
SELECT sName AS '姓张的学生名单'
FROM t_student
WHERE sName LIKE '张%';

30、查询同名同性学生名单，并统计同名人数 
SELECT sName AS '姓名',
  COUNT(*) AS '人数'
FROM t_student
GROUP BY sName,sSex
HAVING COUNT(*) > 1;

31、1981年出生的学生名单(注：Student表中Sage列的类型是datetime)
SELECT sName,YEAR(sAge) as age 
FROM t_student
WHERE YEAR(sAge) = '1981';

32、查询每门课程的平均成绩，结果按平均成绩升序排列，平均成绩相同时，按课程号降序排列
SELECT cid, AVG(score)
FROM t_score
GROUP BY cid
ORDER BY AVG(score),cid DESC;

33、查询每个学生的平均成绩，格式如下。
学号，姓名，平均成绩
SELECT a.sid AS '学号',
  a.sName AS '姓名',
  AVG(b.score) AS '平均成绩'
FROM t_student a INNER JOIN t_score b
ON a.sid = b.sid
GROUP BY a.sid;

34、查询课程名称为“马克思”，且分数低于60的学生姓名和分数
SELECT a.sName AS '学生姓名',
  b.score AS '分数'
FROM t_student a INNER JOIN t_score b INNER JOIN t_course c
ON a.sid = b.sid AND b.cid = c.cid AND c.cName = '马克思'
WHERE b.score < 60;

35、查询所有学生的选课情况; 
SELECT a.sid AS '学生ID',
  a.sName AS '学生姓名',
  c.cid AS '课程ID',
  c.cName AS '课程名称'
FROM t_student a INNER JOIN t_score b INNER JOIN t_course c
ON a.sid = b.sid AND b.cid = c.cid
ORDER BY a.sName;

37、查询有不及格的学生ID，并按学生ID从大到小排列
SELECT DISTINCT sid
FROM t_score
WHERE score < 60
ORDER BY sid DESC;

38、查询课程编号为003且课程成绩在60分以上的学生的学号和姓名
SELECT a.sid AS '学号',
  a.sName AS '姓名'
FROM t_student a INNER JOIN t_score b
ON a.sid = b.sid AND b.cid = '003' AND b.score > 60;

39、求选了课程的学生人数
SELECT COUNT(DISTINCT sid)
FROM t_score;

40、查询“叶平”老师所授各课程中，成绩最好的学生，格式如下。
课程ID，课程名称，学生ID,姓名,成绩。
SELECT b.cid AS '课程ID',
  c.cName AS '课程名称',
  a.sid AS '学生ID',
  a.sName AS '学生姓名',
  b.score AS '成绩'
FROM t_student a INNER JOIN t_score b INNER JOIN t_course c INNER JOIN t_teacher d
ON a.sid = b.sid AND b.cid = c.cid AND c.tid = d.tid AND d.tName = '叶平' AND b.score = (
  SELECT MAX(score)
  FROM t_score
  WHERE cid = c.cid
);

41、查询各个课程及相应的选修人数
SELECT cid AS '课程编号',
  COUNT(*) AS '课程人数'
FROM t_score
GROUP BY cid;

42、查询不同课程成绩相同的学生的学号、课程号、学生成绩
SELECT DISTINCT a.sid AS '学号',
  a.cid AS '课程号',
  a.score AS '学生成绩'
FROM t_score a INNER JOIN t_score b
ON a.score = b.score AND a.sid <> b.sid;

43、查询每门功课成绩最好的前两名
SELECT *
FROM t_score a
WHERE (
  SELECT COUNT(*)
  FROM t_score b
  WHERE a.cid = b.cid AND b.score >= a.score
) <= 2
ORDER BY a.cid;

44、统计每门课程的学生选修人数（超过2人的课程才统计）。要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列 
SELECT cid AS '课程ID',
  COUNT(*) AS '选修人数'
FROM t_score 
GROUP BY cid 
HAVING COUNT(*) > 2
ORDER BY COUNT(*) DESC,cid;

45、检索至少选修两门课程的学生学号
SELECT sid AS '学号'
FROM t_score
GROUP BY sid
HAVING COUNT(*) > 2;

46、查询全部学生都选修的课程的课程号和课程名 
SELECT a.cid AS '课程号',
  b.cName AS '课程名'
FROM t_score a INNER JOIN t_course b
ON a.cid = b.cid
GROUP BY a.cid
HAVING COUNT(*) = (
  SELECT COUNT(*)
  FROM t_student
);


47、查询没学过“叶平”老师讲授的任一门课程的学生姓名
SELECT sName AS '学生姓名'
FROM t_student
WHERE sid NOT IN(
  SELECT sid
  FROM t_score a INNER JOIN t_course b INNER JOIN t_teacher c 
  ON a.cid = b.cid AND b.tid = c.tid
  WHERE c.tName = '叶平'
);

48、查询两门及以上不及格课程的同学的学号及其平均成绩
SELECT sid AS '学号',
  AVG(IFNULL(score, 0)) AS '平均成绩'
FROM t_score
WHERE sid IN (
  SELECT sid
  FROM t_score
  WHERE score < 60
  GROUP BY sid
  HAVING COUNT(*) > 1)
GROUP BY sid;

49、检索“004”课程分数小于60的学生学号，按分数降序排列。
SELECT sid AS '学生学号'
FROM t_score
WHERE cid = '004' AND score < 60
ORDER BY score DESC;

50、删除“1”同学的“003”课程的成绩 
DELETE
FROM t_score
WHERE sid = '1' AND cid = '003';