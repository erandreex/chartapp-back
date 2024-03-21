-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.6.10-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para admin_dashboards
DROP DATABASE IF EXISTS `admin_dashboards`;
CREATE DATABASE IF NOT EXISTS `admin_dashboards` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `admin_dashboards`;

-- Volcando estructura para tabla admin_dashboards.admin_dashboards
DROP TABLE IF EXISTS `admin_dashboards`;
CREATE TABLE IF NOT EXISTS `admin_dashboards` (
  `ad_id` varchar(50) DEFAULT NULL,
  `ad_nombre` varchar(50) DEFAULT NULL,
  `ad_tipo` varchar(50) DEFAULT NULL,
  `ad_componente_id` varchar(50) DEFAULT NULL,
  `ad_orden` int(11) DEFAULT NULL,
  `ad_tamano_xlarge` varchar(50) DEFAULT NULL,
  `ad_tamano_large` varchar(50) DEFAULT NULL,
  `ad_tamano_medium` varchar(50) DEFAULT NULL,
  `ad_tamano_small` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla admin_dashboards.admin_dashboards: ~11 rows (aproximadamente)
DELETE FROM `admin_dashboards`;
INSERT INTO `admin_dashboards` (`ad_id`, `ad_nombre`, `ad_tipo`, `ad_componente_id`, `ad_orden`, `ad_tamano_xlarge`, `ad_tamano_large`, `ad_tamano_medium`, `ad_tamano_small`) VALUES
	('1', 'prueba', 'grafica', '1', 1, '2x6', '1x4', '1x4', '1x12'),
	('3', 'prueba', 'grafica', '3', 3, '1x3', '1x4', '1x4', '1x12'),
	('2', 'prueba', 'grafica', '2', 2, '1x3', '1x4', '1x4', '1x12'),
	('4', 'prueba', 'grafica', '4', 4, '1x3', '1x4', '1x6', '1x12'),
	('6', 'prueba', 'grafica', '6', 6, '1x3', '1x4', '1x4', '1x12'),
	('5', 'prueba', 'grafica', '5', 5, '1x3', '2x8', '1x6', '1x12'),
	('7', 'prueba', 'grafica', '7', 7, '1x3', '1x4', '1x4', '1x12'),
	('11', 'prueba', 'grafica', '11', 11, '1x12', '1x4', '1x12', '1x12'),
	('8', 'prueba', 'grafica', '8', 8, '2x6', '1x4', '1x4', '1x12'),
	('9', 'prueba', 'grafica', '9', 9, '1x3', '1x4', '1x6', '1x12'),
	('10', 'prueba', 'grafica', '10', 10, '1x3', '1x4', '1x6', '1x12');

-- Volcando estructura para tabla admin_dashboards.admin_dashboards_parametros
DROP TABLE IF EXISTS `admin_dashboards_parametros`;
CREATE TABLE IF NOT EXISTS `admin_dashboards_parametros` (
  `adp_parametro` varchar(100) NOT NULL,
  `adp_valor` varchar(100) NOT NULL,
  UNIQUE KEY `adp_parametro` (`adp_parametro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla admin_dashboards.admin_dashboards_parametros: ~5 rows (aproximadamente)
DELETE FROM `admin_dashboards_parametros`;
INSERT INTO `admin_dashboards_parametros` (`adp_parametro`, `adp_valor`) VALUES
	('CHART_HEIGHT', '200'),
	('SIZE_LARGE', '1200'),
	('SIZE_MEDIUN', '800'),
	('SIZE_SMALL', '400'),
	('SIZE_XLARGE', '1500');

-- Volcando estructura para tabla admin_dashboards.admin_graficas_config
DROP TABLE IF EXISTS `admin_graficas_config`;
CREATE TABLE IF NOT EXISTS `admin_graficas_config` (
  `agc_id` varchar(50) DEFAULT NULL,
  `agc_nombre` varchar(50) DEFAULT NULL,
  `agc_titulo` varchar(50) DEFAULT NULL,
  `agc_tipo_grafica` varchar(50) DEFAULT 'line',
  `agc_tipo_escala` varchar(50) DEFAULT 'time',
  `agc_cant_registros` int(11) DEFAULT NULL,
  `agc_intervalo_operacion` varchar(10) DEFAULT NULL,
  `agc_intervalo_tiempo` varchar(50) DEFAULT NULL,
  `agc_intervalo_valor` varchar(50) DEFAULT '1',
  `agc_stacked` varchar(5) DEFAULT 'false',
  `agc_observable` int(11) DEFAULT NULL,
  `agc_background_tipo` varchar(50) DEFAULT 'transparent',
  `agc_background_color` varchar(50) DEFAULT '#292E38',
  `agc_layout_padding` int(11) DEFAULT 20,
  `agc_y_label` varchar(50) DEFAULT NULL,
  `agc_y_color` varchar(50) DEFAULT NULL,
  `agc_y_sugg_max` int(11) DEFAULT NULL,
  `agc_y_sugg_min` int(11) DEFAULT NULL,
  `agc_y_begintAtZero` varchar(50) DEFAULT 'true',
  `agc_y_tick_limit` int(11) DEFAULT NULL,
  `agc_y_fontSize` int(11) DEFAULT 12,
  `agc_x_color` varchar(50) DEFAULT NULL,
  `agc_x_source` varchar(50) DEFAULT '12',
  `agc_x_fontSize` int(11) DEFAULT NULL,
  `agc_legend_boxSize` int(11) DEFAULT 30,
  `agc_legend_fontSize` int(11) DEFAULT 12,
  `agc_legend_color` varchar(50) DEFAULT '#FFFFFF',
  `agc_title_fontSize` int(11) DEFAULT 12,
  `agc_title_color` varchar(50) DEFAULT '#FFFFFF',
  `agc_tooltip_fontSize` int(11) DEFAULT 12,
  `agc_tooltip_color` varchar(50) DEFAULT '#FFFFFF'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla admin_dashboards.admin_graficas_config: ~11 rows (aproximadamente)
DELETE FROM `admin_graficas_config`;
INSERT INTO `admin_graficas_config` (`agc_id`, `agc_nombre`, `agc_titulo`, `agc_tipo_grafica`, `agc_tipo_escala`, `agc_cant_registros`, `agc_intervalo_operacion`, `agc_intervalo_tiempo`, `agc_intervalo_valor`, `agc_stacked`, `agc_observable`, `agc_background_tipo`, `agc_background_color`, `agc_layout_padding`, `agc_y_label`, `agc_y_color`, `agc_y_sugg_max`, `agc_y_sugg_min`, `agc_y_begintAtZero`, `agc_y_tick_limit`, `agc_y_fontSize`, `agc_x_color`, `agc_x_source`, `agc_x_fontSize`, `agc_legend_boxSize`, `agc_legend_fontSize`, `agc_legend_color`, `agc_title_fontSize`, `agc_title_color`, `agc_tooltip_fontSize`, `agc_tooltip_color`) VALUES
	('3', 'Chart CPU per Minutes', 'Chart CPU per Minutes', 'line', 'time', 15, 'unit', 'minute', '1', 'false', 60000, 'transparent', '#292E38', 15, 'Total CPU', '#FFFFFF', 100, 0, 'true', 11, 10, '#FFFFFF', 'data', 10, 30, 10, '#FFFFFF', 10, '#FFFFFF', 10, '#FFFFFF'),
	('2', 'Chart CPU per 5 Minutes', 'Chart CPU per 5 Minutes', 'line', 'time', 12, 'unit', 'minute', '5', 'false', 60000, 'transparent', '#292E38', 15, 'Total CPU', '#FFFFFF', 100, 0, 'true', 11, 10, '#FFFFFF', 'data', 10, 30, 10, '#FFFFFF', 10, '#FFFFFF', 10, '#FFFFFF'),
	('1', 'Chart CPU per 1 Minute', 'Chart CPU per 1 Minute', 'line', 'time', 30, 'unit', 'minute', '1', 'false', 60000, 'transparent', '#292E38', 15, 'Total CPU', '#FFFFFF', 100, 0, 'true', 4, 10, '#FFFFFF', 'data', 10, 30, 10, '#FFFFFF', 10, '#FFFFFF', 10, '#FFFFFF'),
	('4', 'Average CPU per hour', 'Average CPU per hour', 'bar', 'time', 12, 'average', 'hour', '1', 'false', 60000, 'transparent', '#292E38', 15, 'Total CPU', '#FFFFFF', 100, 0, 'true', 11, 10, '#FFFFFF', 'data', 10, 30, 10, '#FFFFFF', 10, '#FFFFFF', 10, '#FFFFFF'),
	('5', 'Total CPU per Hour', 'Total CPU per Hour', 'line', 'time', 10, 'total', 'hour', '1', 'true', 60000, 'transparent', '#292E38', 15, 'Total CPU', '#FFFFFF', 100, 0, 'true', 5, 10, '#FFFFFF', 'data', 10, 30, 10, '#FFFFFF', 10, '#FFFFFF', 10, '#FFFFFF'),
	('7', 'CPU Week count', 'CPU Week count', 'line', 'time', 5, 'count', 'week', '1', 'false', 60000, 'transparent', '#292E38', 15, 'Total CPU', '#FFFFFF', 100, 0, 'true', 11, 10, '#FFFFFF', 'data', 10, 30, 10, '#FFFFFF', 10, '#FFFFFF', 10, '#FFFFFF'),
	('6', 'Day Average CPU', 'Day Average CPU', 'bar', 'time', 10, 'average', 'day', '1', 'true', 60000, 'transparent', '#292E38', 15, 'Total CPU', '#FFFFFF', 100, 0, 'true', 11, 10, '#FFFFFF', 'data', 10, 30, 10, '#FFFFFF', 10, '#FFFFFF', 10, '#FFFFFF'),
	('8', 'Chart CPU Minutes 3', 'Chart CPU Minutes 3', 'line', 'time', 30, 'unit', 'minute', '1', 'false', 60000, 'transparent', '#292E38', 15, 'Total CPU', '#FFFFFF', 100, 0, 'true', 11, 10, '#FFFFFF', 'data', 10, 30, 10, '#FFFFFF', 10, '#FFFFFF', 10, '#FFFFFF'),
	('9', 'Average Hour CPU', 'Average Hour CPU', 'line', 'time', 12, 'average', 'hour', '1', 'false', 60000, 'transparent', '#292E38', 15, 'Total CPU', '#FFFFFF', 100, 0, 'true', 11, 10, '#FFFFFF', 'data', 10, 30, 10, '#FFFFFF', 10, '#FFFFFF', 10, '#FFFFFF'),
	('10', 'Average Year CPU', 'Average Year CPU', 'bar', 'time', 12, 'average', 'year', '1', 'false', 60000, 'transparent', '#292E38', 15, 'Total CPU', '#FFFFFF', 100, 0, 'true', 11, 10, '#FFFFFF', 'data', 10, 30, 10, '#FFFFFF', 10, '#FFFFFF', 10, '#FFFFFF'),
	('11', 'Average Month CPU', 'Average Month CPU', 'line', 'time', 12, 'average', 'month', '1', 'false', 60000, 'transparent', '#292E38', 15, 'Total CPU', '#FFFFFF', 100, 0, 'true', 11, 10, '#FFFFFF', 'data', 10, 30, 10, '#FFFFFF', 10, '#FFFFFF', 10, '#FFFFFF');

-- Volcando estructura para tabla admin_dashboards.admin_graficas_datasets
DROP TABLE IF EXISTS `admin_graficas_datasets`;
CREATE TABLE IF NOT EXISTS `admin_graficas_datasets` (
  `agd_grafica_id` varchar(50) DEFAULT NULL,
  `agd_dataset_id` varchar(50) DEFAULT NULL,
  `agd_dataset_posicion` int(11) DEFAULT NULL,
  `agd_proc_nombre` varchar(10) DEFAULT NULL,
  `agd_proc_tipo` varchar(100) DEFAULT NULL,
  `agd_proc_operacion` varchar(100) DEFAULT NULL,
  `agd_rutina` varchar(100) DEFAULT NULL,
  `agd_dataset_label` varchar(100) DEFAULT NULL,
  `agd_tipo` varchar(10) DEFAULT 'line',
  `agd_fondo_color` varchar(10) DEFAULT NULL,
  `agd_borde_color` varchar(10) DEFAULT NULL,
  `agd_borde_tamano` varchar(2) DEFAULT '3',
  `agd_punto_color_fondo` varchar(10) DEFAULT '#000000',
  `agd_punto_color_hover` varchar(10) DEFAULT '#000000',
  `agd_punto_color_borde` varchar(10) DEFAULT '#000000',
  `agd_punto_tamano` varchar(50) DEFAULT '2',
  `agd_stack` int(11) DEFAULT 0,
  `agd_fill` varchar(10) DEFAULT 'false'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla admin_dashboards.admin_graficas_datasets: ~21 rows (aproximadamente)
DELETE FROM `admin_graficas_datasets`;
INSERT INTO `admin_graficas_datasets` (`agd_grafica_id`, `agd_dataset_id`, `agd_dataset_posicion`, `agd_proc_nombre`, `agd_proc_tipo`, `agd_proc_operacion`, `agd_rutina`, `agd_dataset_label`, `agd_tipo`, `agd_fondo_color`, `agd_borde_color`, `agd_borde_tamano`, `agd_punto_color_fondo`, `agd_punto_color_hover`, `agd_punto_color_borde`, `agd_punto_tamano`, `agd_stack`, `agd_fill`) VALUES
	('1', '1', 1, 'CPU', 'Q', 'QPP', 'servidor1', 'server 1', 'line', '#ff4ac9', '#ff7dd8', '2', '#000000', '#000000', '#000000', '1', 0, 'false'),
	('1', '2', 2, 'CPU', 'Q', 'QPP', 'servidor2', 'server 2', 'line', '#FFFFFF', '#ffc300', '2', '#000000', '#000000', '#000000', '1', 0, 'false'),
	('1', '3', 3, 'CPU', 'Q', 'QPP', 'servidor3', 'server 3', 'line', '#1e6091', '#168aad', '2', '#000000', '#000000', '#000000', '1', 0, 'false'),
	('3', '7', 1, 'CPU', 'Q', 'QPP', 'servidor7', 'server 7', 'line', '#fa188a', '#ffa5a1', '2', '#000000', '#000000', '#000000', '1', 1, 'true'),
	('2', '5', 2, 'CPU', 'Q', 'QPP', 'servidor5', 'server 5', 'line', '#a2d729', '#a2d729', '2', '#000000', '#000000', '#000000', '1', 0, 'false'),
	('2', '6', 3, 'CPU', 'Q', 'QPP', 'servidor6', 'server 6', 'line', '#fa824c', '#fa824c', '2', '#000000', '#000000', '#000000', '1', 0, 'false'),
	('2', '4', 1, 'CPU', 'Q', 'QPP', 'servidor4', 'server 4', 'line', '#b3b300', '#7d7d00', '2', '#000000', '#000000', '#000000', '1', 0, 'false'),
	('3', '8', 2, 'CPU', 'Q', 'QPP', 'servidor8', 'server 8', 'line', '#2dffac', '#2dffac', '2', '#000000', '#000000', '#000000', '1', 1, 'true'),
	('3', '9', 3, 'CPU', 'Q', 'QPP', 'servidor9', 'server 9', 'line', '#1aa1b4', '#1aa1b4', '2', '#000000', '#000000', '#000000', '1', 1, 'true'),
	('4', '10', 1, 'CPU', 'Q', 'QPP', 'servidor10', 'server 10', 'bar', '#1aa1b4', '#1aa1b4', '2', '#000000', '#000000', '#000000', '1', 0, 'true'),
	('5', '11', 1, 'CPU', 'Q', 'QPP', 'servidor6', 'server 6', 'line', '#fa824c', '#fa824c', '2', '#000000', '#000000', '#000000', '1', 0, 'false'),
	('6', '13', 2, 'CPU', 'Q', 'QPP', 'servidor10', 'server 10', 'bar', '#1e6091', '#1e6091', '0', '#000000', '#000000', '#000000', '1', 1, 'false'),
	('5', '12', 2, 'CPU', 'Q', 'QPP', 'servidor5', 'server 5', 'bar', '#00bfed', '#0072c7', '2', '#000000', '#000000', '#000000', '1', 1, 'false'),
	('8', '16', 1, 'CPU', 'Q', 'QPP', 'servidor12', 'server 12', 'line', '#a2d729', '#a2d729', '3', '#000000', '#000000', '#000000', '1', 0, 'false'),
	('6', '14', 1, 'CPU', 'Q', 'QPP', 'servidor9', 'server 9', 'bar', '#fa188a', '#fa188a', '0', '#000000', '#000000', '#000000', '1', 1, 'false'),
	('7', '15', 1, 'CPU', 'Q', 'QPP', 'servidor12', 'server 12', 'bar', '#a2d729', '#a2d729', '2', '#000000', '#000000', '#000000', '1', 0, 'false'),
	('8', '17', 2, 'CPU', 'Q', 'QPP', 'servidor6', 'server 6', 'line', '#ffea00', '#ffea00', '3', '#000000', '#000000', '#000000', '1', 0, 'false'),
	('9', '18', 1, 'CPU', 'Q', 'QPP', 'servidor3', 'server 3', 'line', '#fa824c', '#fa824c', '3', '#000000', '#000000', '#000000', '1', 0, 'false'),
	('10', '19', 1, 'CPU', 'Q', 'QPP', 'servidor1', 'server 1', 'line', '#fa188a', '#fa188a', '3', '#000000', '#000000', '#000000', '1', 0, 'false'),
	('10', '20', 2, 'CPU', 'Q', 'QPP', 'servidor2', 'server 2', 'line', '#fa824c', '#fa824c', '3', '#000000', '#000000', '#000000', '1', 0, 'false'),
	('11', '21', 1, 'CPU', 'Q', 'QPP', 'servidor3', 'server 3', 'line', '#a2d729', '#a2d729', '3', '#000000', '#000000', '#000000', '1', 0, 'false');

-- Volcando estructura para tabla admin_dashboards.admin_graficas_procedimientos
DROP TABLE IF EXISTS `admin_graficas_procedimientos`;
CREATE TABLE IF NOT EXISTS `admin_graficas_procedimientos` (
  `agp_proc_nombre` varchar(50) NOT NULL,
  `agp_proc_almacenado` text NOT NULL,
  UNIQUE KEY `agp_proc_nombre` (`agp_proc_nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla admin_dashboards.admin_graficas_procedimientos: ~1 rows (aproximadamente)
DELETE FROM `admin_graficas_procedimientos`;
INSERT INTO `admin_graficas_procedimientos` (`agp_proc_nombre`, `agp_proc_almacenado`) VALUES
	('CPU', 'CALL admin_bitacora.sp_admin_bitacora_cons_grafica_new(i_tipo,i_operacion,i_rutina,i_fecha,i_cant_registros,i_intervalo_operacion,i_intervalo_tiempo,i_intervalo_valor)');

-- Volcando estructura para procedimiento admin_dashboards.sp_admin_dashboards_consultas
DROP PROCEDURE IF EXISTS `sp_admin_dashboards_consultas`;
DELIMITER //
CREATE PROCEDURE `sp_admin_dashboards_consultas`(
	IN `i_tipo` CHAR(5),
	IN `i_operacion` CHAR(5),
	IN `i_variable_1` VARCHAR(50)
)
BEGIN

	IF (i_tipo = 'Q') THEN
	
		IF (i_operacion = 'QLCC') THEN
			
			SELECT 	ad_id, ad_nombre, ad_tipo, ad_componente_id, ad_orden, ad_tamano_xlarge, ad_tamano_large, ad_tamano_medium, ad_tamano_small  FROM admin_dashboards.admin_dashboards
			WHERE 	ad_nombre = i_variable_1
			ORDER BY ad_orden ASC;
			
		END IF;

	END IF;

END//
DELIMITER ;

-- Volcando estructura para procedimiento admin_dashboards.sp_admin_dashboards_parametros
DROP PROCEDURE IF EXISTS `sp_admin_dashboards_parametros`;
DELIMITER //
CREATE PROCEDURE `sp_admin_dashboards_parametros`(
	IN `i_tipo` CHAR(50),
	IN `i_operacion` CHAR(50),
	IN `i_parametro` VARCHAR(100)
)
BEGIN

	IF (i_tipo = 'Q') THEN
		
		IF(i_operacion = 'QDPU') THEN
			
			SELECT adp_parametro, adp_valor FROM admin_dashboards.admin_dashboards_parametros
			WHERE adp_parametro = i_parametro;
		
		END IF;
		
	END IF;

END//
DELIMITER ;

-- Volcando estructura para procedimiento admin_dashboards.sp_admin_graficas_consultas
DROP PROCEDURE IF EXISTS `sp_admin_graficas_consultas`;
DELIMITER //
CREATE PROCEDURE `sp_admin_graficas_consultas`(
	IN `i_tipo` CHAR(5),
	IN `i_operacion` CHAR(5),
	IN `i_variable_1` VARCHAR(50)
)
BEGIN

	IF (i_tipo = 'Q') THEN
	
		IF (i_operacion = 'QGDID') THEN
			
			SELECT 
				agd_grafica_id,
				agd_dataset_id,
				agd_dataset_posicion,
				agd_proc_nombre,
				agd_proc_tipo,
				agd_proc_operacion,
				agd_rutina,
				agd_dataset_label,
				agd_tipo,
				agd_fondo_color,
				agd_borde_color,
				agd_borde_tamano,
				agd_punto_color_fondo,
				agd_punto_color_hover,
				agd_punto_color_borde,
				agd_punto_tamano,
				agd_stack,
				agd_fill
			FROM admin_dashboards.admin_graficas_datasets
			WHERE agd_grafica_id = i_variable_1;
			
		END IF;
		
		IF (i_operacion = 'QGCID') THEN
			
			SELECT 
				agc_id,
				agc_nombre,
				agc_titulo,
				agc_tipo_grafica,
				agc_tipo_escala,
				agc_cant_registros,
				agc_intervalo_operacion,
				agc_intervalo_tiempo,
				agc_intervalo_valor,
				agc_y_label,
				agc_y_color,
				agc_y_sugg_max,
				agc_y_sugg_min,
				agc_y_begintAtZero,
				agc_y_tick_limit,
				agc_y_fontSize,
				agc_x_color,
				agc_x_source,
				agc_x_fontSize,
				agc_stacked,
				agc_background_tipo,
				agc_background_color,
				agc_observable,
				agc_legend_boxSize,
				agc_legend_fontSize,
				agc_legend_color,
				agc_title_fontSize,
				agc_title_color,
				agc_tooltip_fontSize,
				agc_tooltip_color,
				agc_layout_padding
			FROM admin_dashboards.admin_graficas_config
			WHERE agc_id = i_variable_1;
			
		END IF;
		
	END IF;

END//
DELIMITER ;

-- Volcando estructura para procedimiento admin_dashboards.sp_admin_graficas_procedimientos
DROP PROCEDURE IF EXISTS `sp_admin_graficas_procedimientos`;
DELIMITER //
CREATE PROCEDURE `sp_admin_graficas_procedimientos`(
	IN `i_proc_nombre` VARCHAR(50),
	IN `i_tipo` TEXT,
	IN `i_operacion` TEXT,
	IN `i_rutina` TEXT,
	IN `i_fecha` DATETIME,
	IN `i_cant_registros` INT,
	IN `i_intervalo_operacion` TEXT,
	IN `i_intervalo_tiempo` TEXT,
	IN `i_intervalo_valor` TEXT
)
BEGIN

	SET @proc_almacenado = '';

	SELECT 
		agp_proc_almacenado
	INTO
		@proc_almacenado
	FROM admin_dashboards.admin_graficas_procedimientos
	WHERE agp_proc_nombre = i_proc_nombre;


	IF(SELECT IF(@proc_almacenado LIKE '%i_tipo%', TRUE, FALSE) = TRUE) THEN

		SET @proc_almacenado = (SELECT REPLACE(@proc_almacenado, 'i_tipo', CONCAT("'", i_tipo, "'")));

	END IF;

	IF(SELECT IF(@proc_almacenado LIKE '%i_operacion%', TRUE, FALSE) = TRUE) THEN

		SET @proc_almacenado = (SELECT REPLACE(@proc_almacenado, 'i_operacion', CONCAT("'", i_operacion, "'")));

	END IF;

	IF(SELECT IF(@proc_almacenado LIKE '%i_rutina%', TRUE, FALSE) = TRUE) THEN

		SET @proc_almacenado = (SELECT REPLACE(@proc_almacenado, 'i_rutina', CONCAT("'", i_rutina, "'")));

	END IF;

	IF(SELECT IF(@proc_almacenado LIKE '%i_fecha%', TRUE, FALSE) = TRUE) THEN

		SET @proc_almacenado = (SELECT REPLACE(@proc_almacenado, 'i_fecha', CONCAT("'", i_fecha, "'")));

	END IF;

	IF(SELECT IF(@proc_almacenado LIKE '%i_cant_registros%', TRUE, FALSE) = TRUE) THEN

		SET @proc_almacenado = (SELECT REPLACE(@proc_almacenado, 'i_cant_registros', CONCAT("'", i_cant_registros, "'")));

	END IF;
	
	IF(SELECT IF(@proc_almacenado LIKE '%i_intervalo_operacion%', TRUE, FALSE) = TRUE) THEN

		SET @proc_almacenado = (SELECT REPLACE(@proc_almacenado, 'i_intervalo_operacion', CONCAT("'", i_intervalo_operacion, "'")));

	END IF;
	
	IF(SELECT IF(@proc_almacenado LIKE '%i_intervalo_tiempo%', TRUE, FALSE) = TRUE) THEN

		SET @proc_almacenado = (SELECT REPLACE(@proc_almacenado, 'i_intervalo_tiempo', CONCAT("'", i_intervalo_tiempo, "'")));

	END IF;
	
	IF(SELECT IF(@proc_almacenado LIKE '%i_intervalo_valor%', TRUE, FALSE) = TRUE) THEN

		SET @proc_almacenado = (SELECT REPLACE(@proc_almacenado, 'i_intervalo_valor', CONCAT("'", i_intervalo_valor, "'")));

	END IF;

	PREPARE statment FROM @proc_almacenado;
	EXECUTE statment;
	DEALLOCATE PREPARE statment; 

END//
DELIMITER ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
