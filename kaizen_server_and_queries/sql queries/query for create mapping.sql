SELECT contents_id,contents_name
FROM tbl_contents
WHERE school_id = (SELECT school_id FROM tbl_admin WHERE admin_id = 2) AND enable = 1;