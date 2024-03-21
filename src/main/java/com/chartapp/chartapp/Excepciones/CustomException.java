package com.chartapp.chartapp.Excepciones;

public class CustomException extends Exception {

    private String message;
    private ModeloErrorGeneral errorGeneral;
    private Throwable error;

    public CustomException(String message, ModeloErrorGeneral errorGeneral, Throwable error) {
        super(message);
        this.errorGeneral = errorGeneral;
        this.error = error;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public ModeloErrorGeneral getErrorGeneral() {
        return errorGeneral;
    }

    public void setErrorGeneral(ModeloErrorGeneral errorGeneral) {
        this.errorGeneral = errorGeneral;
    }

    public Throwable getError() {
        return error;
    }

    public void setError(Throwable error) {
        this.error = error;
    }

}
