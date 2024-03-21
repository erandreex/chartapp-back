package com.chartapp.chartapp.Controladores;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.chartapp.chartapp.Excepciones.CustomException;
import com.chartapp.chartapp.Excepciones.HandlerAllException;
import com.chartapp.chartapp.Excepciones.ModeloErrorControlador;
import com.chartapp.chartapp.Modelos.ModeloGraficaConfig;
import com.chartapp.chartapp.Modelos.ModeloGraficaConsulta;
import com.chartapp.chartapp.Modelos.ModeloGraficaDatasetConfig;
import com.chartapp.chartapp.Modelos.ModeloGraficaDatasetData;
import com.chartapp.chartapp.Modelos.ModeloRespuestaGeneral;
import com.chartapp.chartapp.Servicios.ServicioDashboard;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("api/v1/dashboard/")
@RequiredArgsConstructor
public class ControladorDashboard {

    private final ServicioDashboard servicioDashboard;

    private static final String tipo = "Controlador";
    private static final String clase = "ControladorAcceso";

    private static final String m_listar_cuadricula = "listar_cuadricula";

    @GetMapping("cuadricula/{dashboard}")
    public ResponseEntity<ModeloRespuestaGeneral> config(@PathVariable("dashboard") String dashboard) {
        ModeloRespuestaGeneral resp = new ModeloRespuestaGeneral();
        Map<String, Object> respuesta = new HashMap<>();

        List<String> parametros = new ArrayList<>();

        try {

            parametros.add("CHART_HEIGHT");
            parametros.add("SIZE_LARGE");
            parametros.add("SIZE_MEDIUN");
            parametros.add("SIZE_SMALL");
            parametros.add("SIZE_XLARGE");

            respuesta.put("grids", servicioDashboard.listar_cuadricula(dashboard));
            respuesta.put("parameters", servicioDashboard.listarParametros(parametros));

            resp.setOk(true);
            resp.setCode(HttpStatus.OK.value());
            resp.setStatus(HttpStatus.OK);
            resp.setMessage("Se han obtenido la lista de cuadriculas dashboard exitosamente!");
            resp.setResponse(respuesta);

        } catch (CustomException e) {

            ModeloErrorControlador errorControlador = new ModeloErrorControlador();

            errorControlador.setTipo(tipo);
            errorControlador.setClase(clase);
            errorControlador.setMetodo(m_listar_cuadricula);

            throw new HandlerAllException("error", e.getErrorGeneral(), errorControlador,
                    e);
        }

        return ResponseEntity.status(HttpStatus.OK).body(resp);

    }

    @PostMapping("consulta/grafica")
    public ResponseEntity<ModeloRespuestaGeneral> consultaDataGrafica(@RequestBody ModeloGraficaConsulta consulta) {
        List<ModeloGraficaDatasetConfig> listaDatasetConfig = new ArrayList<>();
        List<ModeloGraficaDatasetData> listaDatasetData = new ArrayList<>();
        ModeloGraficaConfig graficaConfig = new ModeloGraficaConfig();
        List<String> listaLabels = new ArrayList<>();

        ModeloRespuestaGeneral resp = new ModeloRespuestaGeneral();
        Map<String, Object> response = new HashMap<>();

        try {
            listaDatasetConfig = servicioDashboard.listarDatasetConfigGrafica(consulta.getIdGrafica());
            graficaConfig = servicioDashboard.listarConfigGrafica(consulta.getIdGrafica());
            listaDatasetData = servicioDashboard.listarDatasetsDataGrafica(consulta,
                    graficaConfig, listaDatasetConfig);
            listaLabels = servicioDashboard.obtenerLabels(listaDatasetData);

            response.put("datasetsConfig", listaDatasetConfig);
            response.put("graficaConfig", graficaConfig);
            response.put("datasetsData", listaDatasetData);
            response.put("datasetsLabels", listaLabels);

            resp.setOk(true);
            resp.setCode(HttpStatus.OK.value());
            resp.setStatus(HttpStatus.OK);
            resp.setMessage("The list of dashboard grids has been obtained successfully!");
            resp.setResponse(response);

        } catch (CustomException e) {

            ModeloErrorControlador errorControlador = new ModeloErrorControlador();

            errorControlador.setTipo(tipo);
            errorControlador.setClase(clase);
            errorControlador.setMetodo(m_listar_cuadricula);

            throw new HandlerAllException("error", e.getErrorGeneral(), errorControlador,
                    e);
        }

        return ResponseEntity.status(HttpStatus.OK).body(resp);

    }

}
