SELECT t_1_0.contents_id
FROM 
	(SELECT cl2.contents_id ,cl1.answer_id
	 FROM 
		(SELECT quiz_id,query_id,answer_id 
			FROM tbl_quiz_answer_query 
			WHERE answer_id IN 
			(SELECT t1.answer_id 
			 FROM (SELECT m1.* FROM (SELECT * FROM tbl_quiz_answer WHERE student_id = 13) m1 
					left JOIN 
					(SELECT * FROM tbl_quiz_answer WHERE student_id = 13) m2 
					ON m1.quiz_id=m2.quiz_id AND m1.register_datetime < m2.register_datetime WHERE m2.register_datetime IS NULL) t1 
						INNER JOIN 
					tbl_quiz t2 
					ON ( t1.quiz_id=t2.quiz_id AND t2.enable=1)) AND flg_right = 0) cl1 
	
		INNER JOIN 
			tbl_quiz_contents_mapping cl2 
	ON (cl1.quiz_id=cl2.quiz_id AND cl1.query_id= cl2.query_id AND cl2.enable=1)) AS t_1_0
INNER JOIN
	tbl_contents AS t_1_1
ON (t_1_0.contents_id = t_1_1.contents_id AND t_1_1.enable=1)

WHERE t_1_0.contents_id
NOT IN 
(
	SELECT t_2_0.contents_id
	FROM
		(SELECT ik1.contents_id
		 from
			(SELECT MAX(lt1.registered_datetime) AS contents_last_watch_time,lt1.school_contents_id AS contents_id,lt1.answer_id 
			from
				(SELECT ht.registered_datetime,ht.school_contents_id,sb.answer_id 
				FROM 
					(SELECT cl2.contents_id,cl1.answer_id
					FROM (SELECT quiz_id,query_id,answer_id FROM tbl_quiz_answer_query WHERE answer_id IN 
					(SELECT t1.answer_id FROM 
						(SELECT m1.* FROM (SELECT * FROM tbl_quiz_answer WHERE student_id = 13) m1 
						left JOIN 
						(SELECT * FROM tbl_quiz_answer WHERE student_id = 13) m2 
						ON m1.quiz_id=m2.quiz_id AND m1.register_datetime < m2.register_datetime WHERE m2.register_datetime IS NULL) t1 
					INNER JOIN tbl_quiz t2 ON ( t1.quiz_id=t2.quiz_id AND t2.enable=1)) AND flg_right = 0) cl1 
					
					INNER JOIN tbl_quiz_contents_mapping cl2 
					ON (cl1.quiz_id=cl2.quiz_id AND cl1.query_id= cl2.query_id AND cl2.enable=1)) as sb
						INNER JOIN
					log_contents_history_student AS ht
					ON sb.contents_id=ht.school_contents_id AND ht.student_id=13) lt1 
					
					GROUP BY lt1.school_contents_id) ik1
			
			INNER join
			
				tbl_quiz_answer ik2
			
			ON ik1.answer_id = ik2.answer_id AND ik2.register_datetime < ik1.contents_last_watch_time) AS t_2_0
		
		INNER join
		
		tbl_contents AS t_2_1
		
		ON t_2_1.enable=1 AND t_2_0.contents_id=t_2_1.contents_id
);