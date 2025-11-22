package monedas.api.dominio.dtos;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class CambioMonedaPeriodoDto {

    @Id
    private int idmoneda;

    private String moneda;
    private String sigla;
    private String simbolo;
    private String emisor;

    private String fecha;
    private double valor;

    public CambioMonedaPeriodoDto() {
    }

    public CambioMonedaPeriodoDto(int idmoneda, String moneda, String sigla, String simbolo, String emisor,
                                  String fecha, double valor) {
        this.idmoneda = idmoneda;
        this.moneda = moneda;
        this.sigla = sigla;
        this.simbolo = simbolo;
        this.emisor = emisor;
        this.fecha = fecha;
        this.valor = valor;
    }

    public int getIdmoneda() {
        return idmoneda;
    }

    public void setIdmoneda(int idmoneda) {
        this.idmoneda = idmoneda;
    }

    public String getMoneda() {
        return moneda;
    }

    public void setMoneda(String moneda) {
        this.moneda = moneda;
    }

    public String getSigla() {
        return sigla;
    }

    public void setSigla(String sigla) {
        this.sigla = sigla;
    }

    public String getSimbolo() {
        return simbolo;
    }

    public void setSimbolo(String simbolo) {
        this.simbolo = simbolo;
    }

    public String getEmisor() {
        return emisor;
    }

    public void setEmisor(String emisor) {
        this.emisor = emisor;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

}
