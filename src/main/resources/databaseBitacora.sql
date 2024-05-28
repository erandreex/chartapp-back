-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.6.10-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para admin_bitacora
DROP DATABASE IF EXISTS `admin_bitacora`;
CREATE DATABASE IF NOT EXISTS `admin_bitacora` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `admin_bitacora`;

-- Volcando estructura para tabla admin_bitacora.bitacora_cpu
DROP TABLE IF EXISTS `bitacora_cpu`;
CREATE TABLE IF NOT EXISTS `bitacora_cpu` (
  `cpu_servidor` varchar(50) DEFAULT NULL,
  `cpu_fecha` datetime DEFAULT NULL,
  `cpu_valor` int(11) DEFAULT NULL,
  KEY `indice_1` (`cpu_servidor`,`cpu_fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para evento admin_bitacora.evento1
DROP EVENT IF EXISTS `evento1`;
DELIMITER //
CREATE EVENT `evento1` ON SCHEDULE EVERY 1 MINUTE STARTS '2024-03-12 18:40:29' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
	 
	CALL admin_bitacora.sp_admin_bitacora_cpu('I', 'INR', 'servidor1', NOW(), ROUND(RAND() * 100));
	CALL admin_bitacora.sp_admin_bitacora_cpu('I', 'INR', 'servidor2', NOW(), ROUND(RAND() * 100));
	CALL admin_bitacora.sp_admin_bitacora_cpu('I', 'INR', 'servidor3', NOW(), ROUND(RAND() * 100));
	CALL admin_bitacora.sp_admin_bitacora_cpu('I', 'INR', 'servidor4', NOW(), ROUND(RAND() * 100));
	CALL admin_bitacora.sp_admin_bitacora_cpu('I', 'INR', 'servidor5', NOW(), ROUND(RAND() * 100));
	CALL admin_bitacora.sp_admin_bitacora_cpu('I', 'INR', 'servidor6', NOW(), ROUND(RAND() * 100));
	CALL admin_bitacora.sp_admin_bitacora_cpu('I', 'INR', 'servidor7', NOW(), ROUND(RAND() * 100));
	CALL admin_bitacora.sp_admin_bitacora_cpu('I', 'INR', 'servidor8', NOW(), ROUND(RAND() * 100));
	CALL admin_bitacora.sp_admin_bitacora_cpu('I', 'INR', 'servidor9', NOW(), ROUND(RAND() * 100));
	CALL admin_bitacora.sp_admin_bitacora_cpu('I', 'INR', 'servidor10', NOW(), ROUND(RAND() * 100));
	CALL admin_bitacora.sp_admin_bitacora_cpu('I', 'INR', 'servidor11', NOW(), ROUND(RAND() * 100));
	CALL admin_bitacora.sp_admin_bitacora_cpu('I', 'INR', 'servidor12', NOW(), ROUND(RAND() * 100));

END//
DELIMITER ;

-- Volcando estructura para procedimiento admin_bitacora.sp_admin_bitacora_cons_grafica
DROP PROCEDURE IF EXISTS `sp_admin_bitacora_cons_grafica`;
DELIMITER //
CREATE PROCEDURE `sp_admin_bitacora_cons_grafica`(
	IN `i_tipo` CHAR(5),
	IN `i_operacion` CHAR(5),
	IN `i_rutina` VARCHAR(100),
	IN `i_fecha` DATETIME,
	IN `i_cant_registros` INT
)
BEGIN

	IF (i_tipo = 'Q') THEN
	
		IF (i_operacion = 'QP') THEN
			
			SET @w_contador = 0;

			CREATE TEMPORARY TABLE IF NOT EXISTS devuelveDatosTMP AS (SELECT cpu_servidor, cpu_fecha, cpu_valor from admin_bitacora.bitacora_cpu where 1=0);
			
			SET @w_fecha_fin = (SELECT DATE_FORMAT(i_fecha, '%Y-%m-%d %H:%i:00'));
			SET @w_fecha_ini = (SELECT DATE_SUB(@w_fecha_fin, INTERVAL 1 MINUTE));
			
			SET @w_fecha_fin_calc = @w_fecha_fin;
			SET @w_fecha_ini_calc = @w_fecha_ini;
			
			WHILE @w_contador < CAST(i_cant_registros as unsigned) Do 
			
				IF EXISTS (SELECT 1 FROM admin_bitacora.bitacora_cpu WHERE cpu_servidor = i_rutina AND cpu_fecha BETWEEN @w_fecha_ini_calc AND @w_fecha_fin_calc) THEN
			
					INSERT INTO devuelveDatosTMP
					SELECT  cpu_servidor, @w_fecha_fin_calc, cpu_valor
					FROM  	admin_bitacora.bitacora_cpu
					WHERE 	cpu_servidor = i_rutina 
					AND 	cpu_fecha BETWEEN @w_fecha_ini_calc AND @w_fecha_fin_calc
					ORDER BY cpu_fecha DESC
					LIMIT 1;
				ELSE 
					INSERT INTO devuelveDatosTMP
					VALUES(i_rutina, @w_fecha_fin_calc, 0);
				END if;
			
				SET @w_contador = @w_contador + 1;
				SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL 1 MINUTE));
				SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL 1 MINUTE));
			
			END WHILE;
			
			SELECT * FROM devuelveDatosTMP
			order by cpu_fecha;
			
			DROP TEMPORARY TABLE IF EXISTS  devuelveDatosTMP;
			
		END IF;

	END IF;

END//
DELIMITER ;

-- Volcando estructura para procedimiento admin_bitacora.sp_admin_bitacora_cons_grafica_new
DROP PROCEDURE IF EXISTS `sp_admin_bitacora_cons_grafica_new`;
DELIMITER //
CREATE PROCEDURE `sp_admin_bitacora_cons_grafica_new`(
	IN `i_tipo` CHAR(5),
	IN `i_operacion` CHAR(5),
	IN `i_rutina` VARCHAR(100),
	IN `i_fecha` DATETIME,
	IN `i_cant_registros` INT,
	IN `i_intervalo_operacion` VARCHAR(50),
	IN `i_intervalo_tiempo` VARCHAR(50),
	IN `i_intervalo_valor` INT
)
BEGIN


	IF (i_tipo = 'Q') THEN

		SET @w_contador = 0;
		SET @w_fecha_fin = NOW();
		SET @w_fecha_ini = NOW();

		if(i_intervalo_tiempo = 'minute') THEN
			SET @w_fecha_fin = (SELECT DATE_FORMAT(i_fecha, '%Y-%m-%d %H:%i:00'));
			SET @w_fecha_ini = (SELECT DATE_SUB(@w_fecha_fin, INTERVAL i_intervalo_valor MINUTE));
		END IF;
		
		if(i_intervalo_tiempo = 'hour') THEN
			SET @w_fecha_fin = (SELECT DATE_FORMAT(DATE_ADD(i_fecha, INTERVAL 1 HOUR), '%Y-%m-%d %H:00:00'));
			SET @w_fecha_ini = (SELECT DATE_SUB(@w_fecha_fin, INTERVAL i_intervalo_valor HOUR));
		END IF;
		
		if(i_intervalo_tiempo = 'day') THEN
			SET @w_fecha_fin = (SELECT DATE_FORMAT(i_fecha, '%Y-%m-%d 23:59:59'));
			SET @w_fecha_ini = (SELECT DATE_FORMAT(DATE_SUB(@w_fecha_fin, INTERVAL (i_intervalo_valor - 1) DAY), '%Y-%m-%d 00:00:00'));
		END IF;

		if(i_intervalo_tiempo = 'week') THEN
			SET @w_fecha_fin = (SELECT DATE_FORMAT(DATE_ADD(i_fecha,INTERVAL (7 - DAYOFWEEK(i_fecha)) + 1 DAY),'%Y-%m-%d 23:59:59'));
			SET @w_fecha_ini = (SELECT DATE_FORMAT(DATE_ADD(DATE_SUB(@w_fecha_fin, INTERVAL i_intervalo_valor WEEK), INTERVAL -DAYOFWEEK(@w_fecha_fin) + 2 DAY),'%Y-%m-%d 00:00:00'));
		END IF;

		if(i_intervalo_tiempo = 'month') THEN
			SET @w_fecha_fin = (SELECT DATE_FORMAT(LAST_DAY(i_fecha),'%Y-%m-%d 23:59:59'));
			SET @w_fecha_ini = (SELECT DATE_FORMAT(DATE_SUB(DATE_FORMAT(@w_fecha_fin, '%Y-%m-01 00:00:00'), INTERVAL (i_intervalo_valor - 1) MONTH),'%Y-%m-01 00:00:00'));
		END IF;

		if(i_intervalo_tiempo = 'year') THEN
			SET @w_fecha_fin = (SELECT DATE_FORMAT(i_fecha, '%Y-12-31 23:59:59'));
			SET @w_fecha_ini = (SELECT DATE_FORMAT(DATE_SUB(DATE_FORMAT(@w_fecha_fin, '%Y-01-01 00:00:00'), INTERVAL (i_intervalo_valor - 1) YEAR), '%Y-01-01 00:00:00'));
		END IF;

		SET @w_fecha_fin_calc = @w_fecha_fin;
		SET @w_fecha_ini_calc = @w_fecha_ini;
		
	END IF;
	
	
		IF (i_operacion = 'QPP') THEN
			
			IF(i_intervalo_operacion = 'unit') THEN
					
				CREATE TEMPORARY TABLE IF NOT EXISTS devuelveDatosTMP AS (SELECT cpu_servidor, cpu_fecha, cpu_valor from admin_bitacora.bitacora_cpu where 1=0);
			
				WHILE @w_contador < CAST(i_cant_registros as unsigned) Do 
				
					IF EXISTS (SELECT 1 FROM admin_bitacora.bitacora_cpu WHERE cpu_servidor = i_rutina AND cpu_fecha BETWEEN @w_fecha_ini_calc AND @w_fecha_fin_calc) THEN
				
						INSERT INTO devuelveDatosTMP
						SELECT  cpu_servidor, @w_fecha_fin_calc, cpu_valor
						FROM  	admin_bitacora.bitacora_cpu
						WHERE 	cpu_servidor = i_rutina 
						AND 	cpu_fecha BETWEEN @w_fecha_ini_calc AND @w_fecha_fin_calc
						ORDER BY cpu_fecha DESC
						LIMIT 1;
					ELSE 
						INSERT INTO devuelveDatosTMP
						VALUES(i_rutina, @w_fecha_fin_calc, 0);
					END if;
				
					SET @w_contador = @w_contador + 1;

					IF(i_intervalo_tiempo = 'minute') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor MINUTE));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor MINUTE));
					END IF;

					IF(i_intervalo_tiempo = 'hour') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor HOUR));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor HOUR));
					END IF;

					IF(i_intervalo_tiempo = 'day') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor DAY));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor DAY));
					END IF;

					IF(i_intervalo_tiempo = 'week') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor WEEK));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor WEEK));
					END IF;

					IF(i_intervalo_tiempo = 'month') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor MONTH));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor MONTH));
					END IF;

					IF(i_intervalo_tiempo = 'year') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor YEAR));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor YEAR));
					END IF;

				END WHILE;
				
				SELECT * FROM devuelveDatosTMP
				ORDER BY cpu_fecha;
				
				DROP TEMPORARY TABLE IF EXISTS  devuelveDatosTMP;

			END IF;

			IF(i_intervalo_operacion = 'average') THEN

				CREATE TEMPORARY TABLE IF NOT EXISTS devuelveDatosTMP AS (SELECT cpu_servidor, cpu_fecha, cpu_valor from admin_bitacora.bitacora_cpu where 1=0);
			
				WHILE @w_contador < CAST(i_cant_registros as unsigned) Do 
				
					IF EXISTS (SELECT 1 FROM admin_bitacora.bitacora_cpu WHERE cpu_servidor = i_rutina AND cpu_fecha BETWEEN @w_fecha_ini_calc AND @w_fecha_fin_calc) THEN
				
						INSERT INTO devuelveDatosTMP
						SELECT  cpu_servidor, @w_fecha_fin_calc, CAST(AVG(cpu_valor) as dec(10,0))
						FROM  	admin_bitacora.bitacora_cpu
						WHERE 	cpu_servidor = i_rutina
						AND 	cpu_fecha BETWEEN @w_fecha_ini_calc AND @w_fecha_fin_calc;

					ELSE 
						INSERT INTO devuelveDatosTMP
						VALUES(i_rutina, @w_fecha_fin_calc, 0);
					END if;
				
					SET @w_contador = @w_contador + 1;

					IF(i_intervalo_tiempo = 'minute') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor MINUTE));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor MINUTE));
					END IF;

					IF(i_intervalo_tiempo = 'hour') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor HOUR));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor HOUR));
					END IF;

					IF(i_intervalo_tiempo = 'day') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor DAY));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor DAY));
					END IF;

					IF(i_intervalo_tiempo = 'week') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor WEEK));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor WEEK));
					END IF;

					IF(i_intervalo_tiempo = 'month') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor MONTH));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor MONTH));
					END IF;

					IF(i_intervalo_tiempo = 'year') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor YEAR));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor YEAR));
					END IF;

				END WHILE;
				
				SELECT * FROM devuelveDatosTMP
				ORDER BY cpu_fecha;
				
				DROP TEMPORARY TABLE IF EXISTS  devuelveDatosTMP;
			END IF;

			IF(i_intervalo_operacion = 'count') THEN

				CREATE TEMPORARY TABLE IF NOT EXISTS devuelveDatosTMP AS (SELECT cpu_servidor, cpu_fecha, cpu_valor from admin_bitacora.bitacora_cpu where 1=0);
			
				WHILE @w_contador < CAST(i_cant_registros as unsigned) Do 
				
					IF EXISTS (SELECT 1 FROM admin_bitacora.bitacora_cpu WHERE cpu_servidor = i_rutina AND cpu_fecha BETWEEN @w_fecha_ini_calc AND @w_fecha_fin_calc) THEN
				
						INSERT INTO devuelveDatosTMP
						SELECT  cpu_servidor, @w_fecha_fin_calc, COUNT(*)
						FROM  	admin_bitacora.bitacora_cpu
						WHERE 	cpu_servidor = i_rutina
						AND 	cpu_fecha BETWEEN @w_fecha_ini_calc AND @w_fecha_fin_calc;
						
					ELSE 
						INSERT INTO devuelveDatosTMP
						VALUES(i_rutina, @w_fecha_fin_calc, 0);
					END if;
				
					SET @w_contador = @w_contador + 1;

					IF(i_intervalo_tiempo = 'minute') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor MINUTE));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor MINUTE));
					END IF;

					IF(i_intervalo_tiempo = 'hour') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor HOUR));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor HOUR));
					END IF;

					IF(i_intervalo_tiempo = 'day') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor DAY));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor DAY));
					END IF;

					IF(i_intervalo_tiempo = 'week') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor WEEK));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor WEEK));
					END IF;

					IF(i_intervalo_tiempo = 'month') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor MONTH));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor MONTH));
					END IF;

					IF(i_intervalo_tiempo = 'year') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor YEAR));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor YEAR));
					END IF;

				END WHILE;
				
				SELECT * FROM devuelveDatosTMP
				ORDER BY cpu_fecha;
				
				DROP TEMPORARY TABLE IF EXISTS  devuelveDatosTMP;

			END IF;
			
			IF(i_intervalo_operacion = 'total') THEN

				CREATE TEMPORARY TABLE IF NOT EXISTS devuelveDatosTMP AS (SELECT cpu_servidor, cpu_fecha, cpu_valor from admin_bitacora.bitacora_cpu where 1=0);
			
				WHILE @w_contador < CAST(i_cant_registros as unsigned) Do 
				
					IF EXISTS (SELECT 1 FROM admin_bitacora.bitacora_cpu WHERE cpu_servidor = i_rutina AND cpu_fecha BETWEEN @w_fecha_ini_calc AND @w_fecha_fin_calc) THEN
				
						INSERT INTO devuelveDatosTMP
						SELECT  cpu_servidor, @w_fecha_fin_calc, CAST(SUM(cpu_valor) AS DEC(10,0))
						FROM  	admin_bitacora.bitacora_cpu
						WHERE 	cpu_servidor = i_rutina
						AND 	cpu_fecha BETWEEN @w_fecha_ini_calc AND @w_fecha_fin_calc;
						
					ELSE 
						INSERT INTO devuelveDatosTMP
						VALUES(i_rutina, @w_fecha_fin_calc, 0);
					END if;
				
					SET @w_contador = @w_contador + 1;

					IF(i_intervalo_tiempo = 'minute') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor MINUTE));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor MINUTE));
					END IF;

					IF(i_intervalo_tiempo = 'hour') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor HOUR));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor HOUR));
					END IF;

					IF(i_intervalo_tiempo = 'day') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor DAY));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor DAY));
					END IF;

					IF(i_intervalo_tiempo = 'week') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor WEEK));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor WEEK));
					END IF;

					IF(i_intervalo_tiempo = 'month') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor MONTH));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor MONTH));
					END IF;

					IF(i_intervalo_tiempo = 'year') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor YEAR));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor YEAR));
					END IF;

				END WHILE;
				
				SELECT * FROM devuelveDatosTMP
				ORDER BY cpu_fecha;
				
				DROP TEMPORARY TABLE IF EXISTS  devuelveDatosTMP;

			END IF;

		END IF;

END//
DELIMITER ;

-- Volcando estructura para procedimiento admin_bitacora.sp_admin_bitacora_cpu
DROP PROCEDURE IF EXISTS `sp_admin_bitacora_cpu`;
DELIMITER //
CREATE PROCEDURE `sp_admin_bitacora_cpu`(
	IN `i_tipo` CHAR(5),
	IN `i_operacion` CHAR(5),
	IN `i_servidor` VARCHAR(50),
	IN `i_fecha` DATETIME,
	IN `i_valor` INT
)
BEGIN

	IF (i_tipo = 'I') THEN
	
		IF (i_operacion = 'INR') THEN
			
			INSERT INTO admin_bitacora.bitacora_cpu (cpu_servidor, cpu_fecha, cpu_valor)
			VALUES (i_servidor, i_fecha, i_valor);
			
		END IF;

	END IF;

END//
DELIMITER ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
