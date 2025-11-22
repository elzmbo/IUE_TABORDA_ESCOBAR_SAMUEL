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
    @Temporal(TemporalType.DATE)
    private Date fecha;

    @Column(name = "Cambio")
    private float cambio;

    public CambioMoneda() {
    }

    public CambioMoneda(Date fecha, float cambio, Moneda moneda) {
        this.fecha = fecha;
        this.cambio = cambio;
        this.moneda = moneda;
    }

    public CambioMoneda(int id, Date fecha, float cambio, Moneda moneda) {
        this.id = id;
        this.fecha = fecha;
        this.cambio = cambio;
        this.moneda = moneda;
    }

    
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