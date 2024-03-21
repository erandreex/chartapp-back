package com.chartapp.chartapp.Excepciones;

public class HandlerAllException extends RuntimeException {

    private ModeloErrorGeneral errorGeneral;
    private ModeloErrorControlador errorControlador;
    private String message;
    private Throwable error;

    public HandlerAllException(String message, ModeloErrorGeneral errorGeneral, ModeloErrorControlador errorControlador,
            Throwable cause) {
        super(message, cause);
        this.errorGeneral = errorGeneral;
        this.errorControlador = errorControlador;

    }

    public ModeloErrorGeneral getErrorGeneral() {
        return errorGeneral;
    }

    public void setErrorGeneral(ModeloErrorGeneral errorGeneral) {
        this.errorGeneral = errorGeneral;
    }

    public ModeloErrorControlador getErrorControlador() {
        return errorControlador;
    }

    public void setErrorControlador(ModeloErrorControlador errorControlador) {
        this.errorControlador = errorControlador;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Throwable getError() {
        return error;
    }

    public void setError(Throwable error) {
        this.error = error;
    }

}
