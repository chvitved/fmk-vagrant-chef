DROP DATABASE IF EXISTS mkt;
DROP DATABASE IF EXISTS sdmmkt;

-- delete anonymous user. on some versions of mysql they introduce problems for other users (mkt)
-- DELETE from mysql.user where WHERE User = '';

-- DROP USER '';
DELETE FROM mysql.user WHERE user='';

DROP USER 'mkt';
DROP USER 'mkt'@'localhost';
