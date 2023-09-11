ALTER VIEW view_app_kri_control_riesgos AS
SELECT CR.Id_ctrl,
      CR.id_ctrl_riesgos,
      CR.id_quien_resp,
	  R.[responsable],
	  AR.area_resp,
      CR.id_comm_bi,
	  CASE
		WHEN COMM.comentario IS NULL THEN 'Sin Comentarios.'
		ELSE COMM.comentario
	   END AS comentario,
      CR.id_riesgos,
	  TR.tipo__desc,
      CR.id_tolerancia,
	  T.tolerancia,
	  T.monto,
	  T.anio AS anio_tolerancia,
	  T.mes AS mes_tolerancia,
      CR.id_kri,
	  KRI.kri_nombre,
      CR.id_alerta,
	  ALRT.kri_alerta,
	  ALRT.alerta_ponderacion,
      CR.id_accion,
      CR.umbral,
      CR.umbral_porcentaje,
      CR.umbral_calc,
      CR.segment1,
      CR.segment2,
      CR.segment3,
      CR.segment_date1,
      CR.segment_date2,
      CR.fk_id_usuario_registra,
	  U.nombre,
      CR.anio,
      CR.mes,
	  CASE 
          WHEN CR.mes = 1 THEN 'Enero'
          WHEN CR.mes = 2 THEN 'Febrero'
		  WHEN CR.mes = 3 THEN 'Marzo'
		  WHEN CR.mes = 4 THEN 'Abril'
		  WHEN CR.mes = 5 THEN 'Mayo'
		  WHEN CR.mes = 6 THEN 'Junio'
		  WHEN CR.mes = 7 THEN 'Julio'
		  WHEN CR.mes = 8 THEN 'Agosto'
		  WHEN CR.mes = 9 THEN 'Septiembre'
		  WHEN CR.mes = 10 THEN 'Octubre'
		  WHEN CR.mes = 11 THEN 'Noviembre'
		  WHEN CR.mes = 12 THEN 'Diciembre'
          ELSE 'NA'
       END AS mes_desc,
      CR.active,
      CR.cifrado,
	  CASE
		  WHEN ALRT.alerta_ponderacion > CR.umbral_porcentaje THEN 1
		  WHEN ALRT.alerta_ponderacion = CR.umbral_porcentaje THEN 2
		  WHEN ALRT.alerta_ponderacion < CR.umbral_porcentaje THEN 3
		  ELSE 99
	  END AS Semaforo_a1
		  
FROM app_kri.ctrl_riesgos as CR
LEFT JOIN app_kri.dim_responsables AS R ON (CR.id_quien_resp = R.id_responsable)
LEFT JOIN app_kri.quien_reporta AS QR ON (CR.id_responsable = QR.Id_qu_rep)
LEFT JOIN app_kri.dim_areas_responsables AS AR ON (CR.id_area_resp = AR.id_area_resp)
LEFT JOIN app_kri.comentarios AS COMM ON (CR.id_comm_bi = COMM.Id_comm_bi)
LEFT JOIN app_kri.dim_tipo_riesgos AS TR ON (TR.id_tipo_riesgo = CR.id_riesgos)
LEFT JOIN app_kri.dim_tolerancias AS T ON (T.id_tolerancia = CR.id_tolerancia)
LEFT JOIN app_kri.dim_kri_indicadores AS KRI ON (KRI.id_kri = CR.id_kri)
LEFT JOIN app_kri.dim_kri_alertas AS ALRT ON (ALRT.id_alerta = CR.id_alerta)
LEFT JOIN app_kri.usuarios AS U ON (U.Id_usuario = CR.fk_id_usuario_registra);
/********************************************************************************************************************/