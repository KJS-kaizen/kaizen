SELECT cl2.contents_id ,cl1.answer_id
FROM (SELECT quiz_id,query_id,answer_id FROM tbl_quiz_answer_query WHERE answer_id IN (SELECT t1.answer_id FROM (SELECT m1.* FROM (SELECT * FROM tbl_quiz_answer WHERE student_id = "4") m1 left JOIN (SELECT * FROM tbl_quiz_answer WHERE student_id = "4") m2 ON m1.quiz_id=m2.quiz_id AND m1.register_datetime < m2.register_datetime WHERE m2.register_datetime IS NULL) t1 INNER JOIN tbl_quiz t2 ON ( t1.quiz_id=t2.quiz_id AND t2.enable=1)) AND flg_right = 0) cl1 

INNER JOIN tbl_quiz_contents_mapping cl2 
ON (cl1.quiz_id=cl2.quiz_id AND cl1.query_id= cl2.query_id) 
WHERE cl2.contents_id 
NOT IN 
(SELECT school_contents_id FROM log_contents_history_student AS ht INNER JOIN (SELECT register_datetime FROM tbl_quiz_answer WHERE answer_id IN (SELECT cl1.answer_id
FROM (SELECT quiz_id,query_id,answer_id FROM tbl_quiz_answer_query WHERE answer_id IN (SELECT t1.answer_id FROM (SELECT m1.* FROM (SELECT * FROM tbl_quiz_answer WHERE student_id = "4") m1 left JOIN (SELECT * FROM tbl_quiz_answer WHERE student_id = "4") m2 ON m1.quiz_id=m2.quiz_id AND m1.register_datetime < m2.register_datetime WHERE m2.register_datetime IS NULL) t1 INNER JOIN tbl_quiz t2 ON ( t1.quiz_id=t2.quiz_id AND t2.enable=1)) AND flg_right = 0) cl1 

INNER JOIN tbl_quiz_contents_mapping cl2 
ON (cl1.quiz_id=cl2.quiz_id AND cl1.query_id= cl2.query_id))) AS x1 ON ht.registered_datetime>x1.register_datetime AND ht.student_id=4 GROUP BY x1.register_datetime)