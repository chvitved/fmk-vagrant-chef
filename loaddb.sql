CREATE DATABASE mkt CHARACTER SET 'utf8' COLLATE 'utf8_danish_ci';
CREATE DATABASE sdmmkt CHARACTER SET 'utf8' COLLATE 'utf8_danish_ci';

CREATE USER mkt IDENTIFIED BY 'mkt';
GRANT ALL ON mkt.* TO 'mkt';
GRANT ALL ON sdmmkt.* TO 'mkt';
CREATE USER 'mkt'@'*' IDENTIFIED BY 'mkt';

