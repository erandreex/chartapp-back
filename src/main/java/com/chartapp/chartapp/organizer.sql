BEGIN

	IF (i_tipo = 'Q') THEN

		SET @w_contador = 0;

		if(i_intervalo_tiempo = 'minutes') THEN
			SET @w_fecha_fin = (SELECT DATE_FORMAT(i_fecha, '%Y-%m-%d %H:%i:00'));
			SET @w_fecha_ini = (SELECT DATE_SUB(@w_fecha_fin, INTERVAL i_intervalo_valor MINUTE));
		END IF;
		
		if(i_intervalo_tiempo = 'hours') THEN
			SET @w_fecha_fin = (SELECT DATE_FORMAT(DATE_ADD(i_fecha, INTERVAL 1 HOUR), '%Y-%m-%d %H:00:00'));
			SET @w_fecha_ini = (SELECT DATE_SUB(@w_fecha_fin, INTERVAL i_intervalo_valor HOUR));
		END IF;
		
		if(i_intervalo_tiempo = 'days') THEN
			SET @w_fecha_fin = (SELECT DATE_FORMAT(i_fecha, '%Y-%m-%d 23:59:59'););
			SET @w_fecha_ini = (SELECT DATE_FORMAT(DATE_SUB(@w_fecha_fin, INTERVAL (i_intervalo_valor - 1) DAY), '%Y-%m-%d 00:00:00'));
		END IF;

		if(i_intervalo_tiempo = 'weeks') THEN
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

					IF(i_intervalo_tiempo = 'minutes') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor MINUTE));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor MINUTE));
					END IF;

					IF(i_intervalo_tiempo = 'hours') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor HOUR));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor HOUR));
					END IF;

					IF(i_intervalo_tiempo = 'days') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor DAY));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor DAY));
					END IF;

					IF(i_intervalo_tiempo = 'weeks') THEN
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

					IF(i_intervalo_tiempo = 'minutes') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor MINUTE));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor MINUTE));
					END IF;

					IF(i_intervalo_tiempo = 'hours') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor HOUR));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor HOUR));
					END IF;

					IF(i_intervalo_tiempo = 'days') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor DAY));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor DAY));
					END IF;

					IF(i_intervalo_tiempo = 'weeks') THEN
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

					IF(i_intervalo_tiempo = 'minutes') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor MINUTE));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor MINUTE));
					END IF;

					IF(i_intervalo_tiempo = 'hours') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor HOUR));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor HOUR));
					END IF;

					IF(i_intervalo_tiempo = 'days') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor DAY));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor DAY));
					END IF;

					IF(i_intervalo_tiempo = 'weeks') THEN
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

					IF(i_intervalo_tiempo = 'minutes') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor MINUTE));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor MINUTE));
					END IF;

					IF(i_intervalo_tiempo = 'hours') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor HOUR));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor HOUR));
					END IF;

					IF(i_intervalo_tiempo = 'days') THEN
						SET @w_fecha_fin_calc = (SELECT DATE_SUB(@w_fecha_fin_calc, INTERVAL i_intervalo_valor DAY));
						SET @w_fecha_ini_calc = (SELECT DATE_SUB(@w_fecha_ini_calc, INTERVAL i_intervalo_valor DAY));
					END IF;

					IF(i_intervalo_tiempo = 'weeks') THEN
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

	END IF;

END



			

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


CALL admin_bitacora.sp_admin_bitacora_cons_grafica_new(i_tipo,i_operacion,i_rutina,i_fecha,i_cant_registros,i_intervalo_operacion,i_intervalo_tiempo,i_intervalo_valor);