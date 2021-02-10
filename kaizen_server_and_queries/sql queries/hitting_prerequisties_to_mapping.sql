SELECT quiz_id,query_id
FROM tbl_quiz_answer_query 
WHERE answer_id IN (SELECT t1.answer_id FROM (SELECT m1.* FROM (SELECT * FROM tbl_quiz_answer WHERE student_id = 4) m1 left JOIN (SELECT * FROM tbl_quiz_answer WHERE student_id = 4) m2
ON m1.quiz_id=m2.quiz_id AND m1.register_datetime < m2.register_datetime
WHERE m2.register_datetime IS NULL) t1 INNER JOIN tbl_quiz t2 
ON ( t1.quiz_id=t2.quiz_id AND t2.enable=1)) AND flg_right = 0;