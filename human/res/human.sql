CREATE SCHEMA IF NOT EXISTS `humandb` DEFAULT CHARACTER SET utf8 ;
USE `humandb` ;

CREATE TABLE IF NOT EXISTS `humandb`.`human_table` (
  `name` VARCHAR(16) NOT NULL,
  `age` INT NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


INSERT INTO human_table (name, age)
VALUES('김기현', 26);
INSERT INTO human_table (name, age)
VALUES('서민규', 46);
INSERT INTO human_table (name, age)
VALUES('아이유', 29);
INSERT INTO human_table (name, age)
VALUES('슬기', 28);

update human_table
set age = 25
where name = '김기현';

select * from human_table;

select name, age
from human_table
where name like '%기%';


commit;