

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
#
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
#
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';
#
CREATE SCHEMA IF NOT EXISTS `imdb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
#


USE `imdb` ;
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
use imdb;

LOAD DATA LOCAL INFILE 'C:/Users/Matt/Documents/FYP/Programing/all_movie.txt' IGNORE INTO TABLE movie
  FIELDS TERMINATED BY '/|/';



LOAD DATA LOCAL INFILE 'C:/Users/Matt/Documents/FYP/Programing/all_genre.txt' IGNORE INTO TABLE genre
  FIELDS TERMINATED BY '/|/';



LOAD DATA LOCAL INFILE 'C:/Users/Matt/Documents/FYP/Programing/all_director.txt' IGNORE INTO TABLE director
  FIELDS TERMINATED BY '/|/';



LOAD DATA LOCAL INFILE 'C:/Users/Matt/Documents/FYP/Programing/all_actressinfo.txt' 
IGNORE INTO TABLE actressinfo
  FIELDS TERMINATED BY '/|/';



LOAD DATA LOCAL INFILE 'C:/Users/Matt/Documents/FYP/Programing/all_actorinfo.txt' 
IGNORE INTO TABLE actorinfo
  FIELDS TERMINATED BY '/|/' ;

