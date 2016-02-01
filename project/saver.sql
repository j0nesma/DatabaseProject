


USE `imdb` ;

SELECT * INTO OUTFILE 
'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/all_genre.txt' 
  FIELDS TERMINATED BY 'þ'
  LINES TERMINATED BY '\n'
  FROM genre;
select "finished saving genre";

SELECT * INTO OUTFILE 
'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/all_director.txt' 
  FIELDS TERMINATED BY 'þ'
  LINES TERMINATED BY '\n'
  FROM director;
select "finished saving director";

SELECT * INTO OUTFILE 
'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/all_movie.txt' 
  FIELDS TERMINATED BY 'þ'
  LINES TERMINATED BY '\n'
  FROM movie;
select "finished saving movie";

SELECT * INTO OUTFILE 
'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/all_actorinfo.txt' 
  FIELDS TERMINATED BY 'þ'
  LINES TERMINATED BY '\n'
  FROM actorinfo;
select "finished saving actorinfo";

SELECT * INTO OUTFILE 
'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/all_actressinfo.txt' 
  FIELDS TERMINATED BY 'þ'
  LINES TERMINATED BY '\n'
  FROM actressinfo;
select "finished saving actressinfo";


quit

SELECT * INTO OUTFILE 
'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/all_genre.txt' 
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '''
  LINES TERMINATED BY '\n'
  FROM genre;
select "finished saving genre";

#
-- -----------------------------------------------------
-- Table `imdb`.`Movie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imdb`.`Movie` ;
#
CREATE  TABLE IF NOT EXISTS `imdb`.`Movie` (
  `movieId` INT NOT NULL ,
  `movieTitle` VARCHAR(200) NOT NULL ,
  `movieSubtitle` VARCHAR(200) NULL ,
  `movieYear` VARCHAR(10) NULL ,
  `isTV` TINYINT(1)  NOT NULL ,
  `isVG` TINYINT(1)  NOT NULL ,
  `isV` TINYINT(1)  NOT NULL ,
  `rating` FLOAT NULL ,
  PRIMARY KEY (`movieId`) )
ENGINE = InnoDB;
#
-- -----------------------------------------------------
-- Table `imdb`.`Genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imdb`.`Genre` ;
#
CREATE  TABLE IF NOT EXISTS `imdb`.`Genre` (
  `genreId` INT NOT NULL AUTO_INCREMENT ,
  `genre` VARCHAR(100) NOT NULL ,
  `description` VARCHAR(500) NULL ,
  `Movie_movieId` INT NOT NULL ,
  PRIMARY KEY (`genreId`) ,
  INDEX `fk_Genre_Movie` (`Movie_movieId` ASC) ,
  CONSTRAINT `fk_Genre_Movie`
    FOREIGN KEY (`Movie_movieId` )
    REFERENCES `imdb`.`Movie` (`movieId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
#
-- -----------------------------------------------------
-- Table `imdb`.`actorInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imdb`.`actorInfo` ;
#
CREATE  TABLE IF NOT EXISTS `imdb`.`actorInfo` (
  `actorId` INT NOT NULL AUTO_INCREMENT ,
  `firstName` VARCHAR(200) NOT NULL ,
  `surName` VARCHAR(200) NULL ,
  `description` VARCHAR(400) NULL ,
  `Movie_movieId` INT NOT NULL ,
  `charName` VARCHAR(200) NULL ,
  `billingNum` INT NULL ,
  PRIMARY KEY (`actorId`) ,
  INDEX `fk_Directors_Movie1` (`Movie_movieId` ASC) ,
  CONSTRAINT `fk_Directors_Movie1`
    FOREIGN KEY (`Movie_movieId` )
    REFERENCES `imdb`.`Movie` (`movieId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
#

#

#
-- -----------------------------------------------------
-- Table `imdb`.`Director`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imdb`.`Director` ;
#
CREATE  TABLE IF NOT EXISTS `imdb`.`Director` (
  `directorId` INT NOT NULL ,
  `firstName` VARCHAR(100) NOT NULL ,
  `surName` VARCHAR(100) NULL ,
  `Movie_movieId` INT NOT NULL ,
  PRIMARY KEY (`directorId`) ,
  INDEX `fk_Directors_Movie1` (`Movie_movieId` ASC) ,
  CONSTRAINT `fk_Directors_Movie100`
    FOREIGN KEY (`Movie_movieId` )
    REFERENCES `imdb`.`Movie` (`movieId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
#
-- -----------------------------------------------------
-- Table `imdb`.`actressInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imdb`.`actressInfo` ;
#
CREATE  TABLE IF NOT EXISTS `imdb`.`actressInfo` (
  `actressId` INT NOT NULL AUTO_INCREMENT ,
  `firstName` VARCHAR(200) NOT NULL ,
  `surName` VARCHAR(200) NULL ,
  `description` VARCHAR(400) NULL ,
  `Movie_movieId` INT NOT NULL ,
  `charName` VARCHAR(200) NULL ,
  `billingNum` INT NULL ,
  PRIMARY KEY (`actressId`) ,
  INDEX `fk_Directors_Movie1` (`Movie_movieId` ASC) ,
  CONSTRAINT `fk_Directors_Movie10`
    FOREIGN KEY (`Movie_movieId` )
    REFERENCES `imdb`.`Movie` (`movieId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
#


#
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
#
use imdb
SET SQL_MODE='TRADITIONAL';
SHOW VARIABLES LIKE 'SQL_MODE';

LOAD DATA INFILE IGNORE INTO TABLE movie
  FIELDS TERMINATED BY 'þ';


LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/movie(1).txt' IGNORE INTO TABLE movie
  FIELDS TERMINATED BY 'þ';
select "finished loading movie(1)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/movie(2).txt' IGNORE INTO TABLE movie
  FIELDS TERMINATED BY 'þ';
select "finished loading movie(2)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/movie(3).txt' IGNORE INTO TABLE movie
  FIELDS TERMINATED BY 'þ';
select "finished loading movie(3)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/movie(4).txt' IGNORE INTO TABLE movie
  FIELDS TERMINATED BY 'þ';
select "finished loading movie(4)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/movie(5).txt' IGNORE INTO TABLE movie
  FIELDS TERMINATED BY 'þ';
select "finished loading movie(5)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/movie(6).txt' IGNORE INTO TABLE movie
  FIELDS TERMINATED BY 'þ';
select "finished loading movie(6)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/genre.txt' IGNORE INTO TABLE genre
  FIELDS TERMINATED BY 'þ';
select "finished loading genre";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/genre(1).txt' IGNORE INTO TABLE genre
  FIELDS TERMINATED BY 'þ';
select "finished loading genre(1)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/genre(2).txt' IGNORE INTO TABLE genre
  FIELDS TERMINATED BY 'þ';
select "finished loading genre(2)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/genre(3).txt' IGNORE INTO TABLE genre
  FIELDS TERMINATED BY 'þ';
select "finished loading genre(3)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/director.txt' IGNORE INTO TABLE director
  FIELDS TERMINATED BY 'þ';
select "finished loading director";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/director(1).txt' IGNORE INTO TABLE director
  FIELDS TERMINATED BY 'þ';
select "finished loading director(1)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/director(2).txt' IGNORE INTO TABLE director
  FIELDS TERMINATED BY 'þ';
select "finished loading director(2)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/director(3).txt' IGNORE INTO TABLE director
  FIELDS TERMINATED BY 'þ';
select "finished loading director(3)";


LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actressinfo.txt' 
IGNORE INTO TABLE actressinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actressinfo";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actressinfo(1).txt' 
IGNORE INTO TABLE actressinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actressinfo(1)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actressinfo(2).txt' 
IGNORE INTO TABLE actressinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actressinfo(2)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actressinfo(3).txt' 
IGNORE INTO TABLE actressinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actressinfo(3)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actressinfo(4).txt' 
IGNORE INTO TABLE actressinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actressinfo(4)";


LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actressinfo(5).txt' 
IGNORE INTO TABLE actressinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actressinfo(5)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actressinfo(6).txt' 
IGNORE INTO TABLE actressinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actressinfo(6)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actressinfo(7).txt' 
IGNORE INTO TABLE actressinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actressinfo(7)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actressinfo(8).txt' 
IGNORE INTO TABLE actressinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actressinfo(8)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actressinfo(9).txt' 
IGNORE INTO TABLE actressinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actressinfo(9)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actressinfo(10).txt' 
IGNORE INTO TABLE actressinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actressinfo(10)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actressinfo(11).txt' 
IGNORE INTO TABLE actressinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actressinfo(11)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actressinfo(12).txt' 
IGNORE INTO TABLE actressinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actressinfo(12)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actressinfo(13).txt' 
IGNORE INTO TABLE actressinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actressinfo(13)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actressinfo(14).txt' 
IGNORE INTO TABLE actressinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actressinfo(14)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actressinfo(15).txt' 
IGNORE INTO TABLE actressinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actressinfo(15)";




LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo.txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(1).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(1)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(2).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(2)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(3).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(3)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(4).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(4)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(5).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(5)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(6).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(6)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(7).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(7)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(8).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(8)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(9).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(9)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(10).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(10)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(11).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(11)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(12).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(12)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(13).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(13)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(14).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(14)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(15).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(15)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(16).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(16)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(17).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(17)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(18).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(18)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(19).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(19)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(20).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(20)";

LOAD DATA INFILE 'C:/Documents and Settings/mariani/My Documents/02. My Software Folder/01. Current Software 2011-2012 Folder/load and save full imdb data/actorinfo(21).txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY 'þ';
select "finished loading actorinfo(21)";



SET SQL_MODE=@OLD_SQL_MODE;#
#
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
quit
