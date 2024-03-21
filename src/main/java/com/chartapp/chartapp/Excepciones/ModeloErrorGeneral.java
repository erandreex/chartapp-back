package com.chartapp.chartapp.Excepciones;

import java.util.Date;

import org.springframework.http.HttpStatus;

public class ModeloErrorGeneral {

    private String id;
    private Date date;
    private String messageInt;
    private String messageExt;
    private HttpStatus status;
    private int code;
    private String tipo;
    private String clase;
    private String metodo;
    private Throwable error;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getMessageInt() {
        return messageInt;
    }

    public void setMessageInt(String messageInt) {
        this.messageInt = messageInt;
    }

    public String getMessageExt() {
        return messageExt;
    }

    public void setMessageExt(String messageExt) {
        this.messageExt = messageExt;
    }

    public HttpStatus getStatus() {
        return status;
    }

    public void setStatus(HttpStatus status) {
        this.status = status;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getClase() {
        return clase;
    }

    public void setClase(String clase) {
        this.clase = clase;
    }

    public String getMetodo() {
        return metodo;
    }

    public void setMetodo(String metodo) {
        this.metodo = metodo;
    }

    public Throwable getError() {
        return error;
    }

    public void setError(Throwable error) {
        this.error = error;
    }

}
