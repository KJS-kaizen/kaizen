<?php
require_once '../config.php';

class GetAdminMessageListModel extends PdoBase
{
    public function getMessageListCount($data)
    {
        $sql = "SELECT count(DISTINCT a.message_id) as count
                  FROM tbl_message as a
             LEFT JOIN tbl_message_detail as b
                    ON a.message_id = b.message_id
                   AND b.enable = 1
             LEFT JOIN tbl_message_target as c
                    ON b.message_detail_id = c.message_detail_id
             LEFT JOIN tbl_message_check as d
                    ON a.message_id = d.message_id
                   AND d.user_level_id = 1
                   AND d.user_id = :admin_id
                 WHERE (
                           -- ユーザがメッセージ作成者なら表示
                           (a.auther_user_level_id = 1 AND a.auther_user_id = :admin_id) OR
                           (b.send_user_level_id = 1 AND b.send_user_id = :admin_id)
                       OR
                           -- ユーザがメッセージ表示対象なら一覧に表示(本人が対象 or 所属するコースが対象)
                           (
                               -- ユーザIDによる抽出
                               (c.grade_id = 0 ) AND
                               (c.course_id = 0 ) AND
                               (c.classroom_id = 0 )AND

                               (c.receive_user_level_id = 1 OR c.receive_user_level_id = 0 )

                           )
                       )
                   AND a.enable = 1
                   AND a.school_id = :school_id
        ";

        return $this->fetch($sql, array(
            ':school_id' => $data['school_id']
          , ':admin_id' => $data['admin_id']
        ));
    }

    public function getMessageListOffset($data)
    {
        $sql = "SELECT a.message_id
                     , a.auther_user_level_id as auther_user_level_id
                     , (a.auther_user_id = :admin_id AND a.auther_user_level_id = 1) as auther_flag
                     , a.title as title
                     , a.enable as enable
                     , a.type as type
                     , MAX(b.register_datetime) as last_sending_date
                     , MAX(b.register_datetime) < d.check_date AND d.check_date IS NOT NULL as check_flag
                     , CASE
                           WHEN b.send_user_level_id = 1 THEN
                               (SELECT admin_name
                                  FROM tbl_admin
                                 WHERE admin_id = b.send_user_id
                               )
                           WHEN b.send_user_level_id = 2 THEN
                               (SELECT teacher_name
                                  FROM tbl_teacher
                                 WHERE teacher_id = b.send_user_id
                               )
                           WHEN b.send_user_level_id = 3 THEN
                               (SELECT student_name
                                  FROM tbl_student
                                 WHERE student_id = b.send_user_id
                               )
                       END AS last_sender
                     , CASE
                           WHEN a.type = 0 THEN
                               (SELECT COUNT(DISTINCT message_detail_id) as total_message
                                  FROM tbl_message_detail
                                 WHERE message_id = a.message_id
                                   AND enable = 1
                               )
                           WHEN a.type = 1 THEN
                               (SELECT COUNT(DISTINCT message_detail_id) as total_message
                                  FROM tbl_message_detail
                                 WHERE message_id = a.message_id
                                   AND enable = 1
                               )
                           WHEN a.type = 2 THEN
                               (SELECT COUNT(DISTINCT message_detail_id) as total_message
                                  FROM tbl_message_detail
                                 WHERE message_id = a.message_id
                                   AND enable = 1
                               )
                       END as total_message
                  FROM tbl_message as a
             LEFT JOIN tbl_message_detail as b
                    ON a.message_id = b.message_id
                   AND b.enable = 1
             LEFT JOIN tbl_message_target as c
                    ON b.message_detail_id = c.message_detail_id
             LEFT JOIN tbl_message_check as d
                    ON a.message_id = d.message_id
                   AND d.user_level_id = 1
                   AND d.user_id = :admin_id
                 WHERE (
                           -- ユーザがメッセージ作成者なら表示
                           (a.auther_user_level_id = 1 AND a.auther_user_id = :admin_id) OR
                           (b.send_user_level_id = 1 AND b.send_user_id = :admin_id)
                       OR
                           -- ユーザがメッセージ表示対象なら一覧に表示(本人が対象 or 所属するコースが対象)
                           (
                               -- ユーザIDによる抽出
                               (c.grade_id = 0 ) AND
                               (c.course_id = 0 ) AND
                               (c.classroom_id = 0 )AND

                               (c.receive_user_level_id = 1 OR c.receive_user_level_id = 0 )

                           )
                       )
                   AND a.enable = 1
                   AND a.school_id = :school_id
              GROUP BY a.message_id
              ORDER BY check_flag
                     , last_sending_date DESC
                 LIMIT " . $data['limit'] . "
                OFFSET " . $data['offset'] . "
        ";

        return $this->fetchAll($sql, array(
            ':school_id' => $data['school_id']
          , ':admin_id' => $data['admin_id']
        ));
    }

    public function getNoticeListCount($data)
    {
        $sql = "SELECT count(DISTINCT a.message_id) as count
                  FROM tbl_message as a
             LEFT JOIN tbl_message_detail as b
                    ON a.message_id = b.message_id
                   AND b.enable = 1
             LEFT JOIN tbl_message_target as c
                    ON b.message_detail_id = c.message_detail_id
             LEFT JOIN tbl_message_check as d
                    ON a.message_id = d.message_id
                   AND d.user_level_id = 1
                   AND d.user_id = :admin_id
                 WHERE (
                           -- ユーザがメッセージ作成者なら表示
                           (a.auther_user_level_id = 1 AND a.auther_user_id = :admin_id) OR
                           (b.send_user_level_id = 1 AND b.send_user_id = :admin_id)
                       OR
                           -- ユーザがメッセージ表示対象なら一覧に表示(本人が対象 or 所属するコースが対象)
                           (
                               -- ユーザIDによる抽出
                               (c.grade_id = 0 ) AND
                               (c.course_id = 0 ) AND
                               (c.classroom_id = 0 )AND

                               (c.receive_user_level_id = 1 OR c.receive_user_level_id = 0 )

                           )
                       )
                   AND a.enable = 1
                   AND a.school_id = :school_id
                   AND a.type = 0
        ";

        return $this->fetch($sql, array(
            ':school_id' => $data['school_id']
          , ':admin_id' => $data['admin_id']
        ));
    }

    public function getNoticeListOffset($data)
    {
        $sql = "SELECT a.message_id
                     , a.auther_user_level_id as auther_user_level_id
                     , (a.auther_user_id = :admin_id AND a.auther_user_level_id = 1) as auther_flag
                     , a.title as title
                     , a.enable as enable
                     , a.type as type
                     , MAX(b.register_datetime) as last_sending_date
                     , MAX(b.register_datetime) < d.check_date AND d.check_date IS NOT NULL as check_flag
                     , CASE
                           WHEN b.send_user_level_id = 1 THEN
                               (SELECT admin_name
                                  FROM tbl_admin
                                 WHERE admin_id = b.send_user_id
                               )
                           WHEN b.send_user_level_id = 2 THEN
                               (SELECT teacher_name
                                  FROM tbl_teacher
                                 WHERE teacher_id = b.send_user_id
                               )
                           WHEN b.send_user_level_id = 3 THEN
                               (SELECT student_name
                                  FROM tbl_student
                                 WHERE student_id = b.send_user_id
                               )
                       END AS last_sender
                     , CASE
                           WHEN a.type = 0 THEN
                               (SELECT COUNT(DISTINCT message_detail_id) as total_message
                                  FROM tbl_message_detail
                                 WHERE message_id = a.message_id
                                   AND enable = 1
                               )
                           WHEN a.type = 1 THEN
                               (SELECT COUNT(DISTINCT message_detail_id) as total_message
                                  FROM tbl_message_detail
                                 WHERE message_id = a.message_id
                                   AND enable = 1
                               )
                           WHEN a.type = 2 THEN
                               (SELECT COUNT(DISTINCT message_detail_id) as total_message
                                  FROM tbl_message_detail
                                 WHERE message_id = a.message_id
                                   AND enable = 1
                               )
                       END as total_message
                  FROM tbl_message as a
             LEFT JOIN tbl_message_detail as b
                    ON a.message_id = b.message_id
                   AND b.enable = 1
             LEFT JOIN tbl_message_target as c
                    ON b.message_detail_id = c.message_detail_id
             LEFT JOIN tbl_message_check as d
                    ON a.message_id = d.message_id
                   AND d.user_level_id = 1
                   AND d.user_id = :admin_id
                 WHERE (
                           -- ユーザがメッセージ作成者なら表示
                           (a.auther_user_level_id = 1 AND a.auther_user_id = :admin_id) OR
                           (b.send_user_level_id = 1 AND b.send_user_id = :admin_id)
                       OR
                           -- ユーザがメッセージ表示対象なら一覧に表示(本人が対象 or 所属するコースが対象)
                           (
                               -- ユーザIDによる抽出
                               (c.grade_id = 0 ) AND
                               (c.course_id = 0 ) AND
                               (c.classroom_id = 0 )AND

                               (c.receive_user_level_id = 1 OR c.receive_user_level_id = 0 )

                           )
                       )
                   AND a.enable = 1
                   AND a.school_id = :school_id
                   AND a.type = 0
              GROUP BY a.message_id
              ORDER BY check_flag
                     , message_level ASC
                     , last_sending_date DESC
                 LIMIT " . $data['limit'] . "
                OFFSET " . $data['offset'] . "
        ";

        return $this->fetchAll($sql, array(
            ':school_id' => $data['school_id']
          , ':admin_id' => $data['admin_id']
        ));
    }

    public function setMessageListDelete($data)
    {
        $sql = "UPDATE tbl_message
                   SET enable = 0
                 WHERE message_id = :message_id
        ";

        return $this->execute($sql, array(
            ':message_id' => $data['message_id']
        ));
    }
}
