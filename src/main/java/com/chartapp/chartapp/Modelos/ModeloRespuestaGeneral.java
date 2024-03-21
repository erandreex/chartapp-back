package com.chartapp.chartapp.Modelos;

import java.util.Map;

import org.springframework.http.HttpStatus;

import com.chartapp.chartapp.Excepciones.ModeloErrorCliente;

public class ModeloRespuestaGeneral {

    private boolean ok;
    private int code;
    private HttpStatus status;
    private String message;
    private Map<String, Object> response;
    private ModeloErrorCliente error;

    public boolean isOk() {
        return ok;
    }

    public void setOk(boolean ok) {
        this.ok = ok;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public HttpStatus getStatus() {
        return status;
    }

    public void setStatus(HttpStatus status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Map<String, Object> getResponse() {
        return response;
    }

    public void setResponse(Map<String, Object> response) {
        this.response = response;
    }

    public ModeloErrorCliente getError() {
        return error;
    }

    public void setError(ModeloErrorCliente error) {
        this.error = error;
    }

}
