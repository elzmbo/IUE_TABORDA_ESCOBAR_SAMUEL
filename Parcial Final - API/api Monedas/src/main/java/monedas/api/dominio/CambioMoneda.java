package monedas.api.dominio;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.util.Date;

@Entity
@Table(name = "CambioMoneda")
public class CambioMoneda {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private int id;

    @ManyToOne
    @JoinColumn(name = "IdMoneda", referencedColumnName = "Id")
    private Moneda moneda;

    @Column(name = "Fecha")
    private Date fecha;

    @Column(name = "Cambio")
    private float cambio;

    public CambioMoneda() {
    }

    public CambioMoneda(int id, Moneda moneda, Date fecha, float cambio) {
        this.id = id;
        this.moneda = moneda;
        this.fecha = fecha;
        this.cambio = cambio;
    }

    // GETTERS Y SETTERS

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Moneda getMoneda() {
        return moneda;
    }

    public void setMoneda(Moneda moneda) {
        this.moneda = moneda;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public float getCambio() {
        return cambio;
    }

    public void setCambio(float cambio) {
        this.cambio = cambio;
    }
}
