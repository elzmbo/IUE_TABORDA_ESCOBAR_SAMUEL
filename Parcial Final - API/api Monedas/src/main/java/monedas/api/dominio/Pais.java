package monedas.api.dominio;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "Pais")
public class Pais {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private int id;

    @Column(name = "Pais", length = 50, unique = true)
    private String nombre;

    @Column(name = "CodigoAlfa2", length = 5)
    private String codigoAlfa2;

    @Column(name = "CodigoAlfa3", length = 5)
    private String codigoAlfa3;

    @ManyToOne
    @JoinColumn(name = "IdMoneda", referencedColumnName = "Id")
    private Moneda moneda;

    @Lob
    @Column(name = "Mapa")
    private byte[] mapa;

    @Lob
    @Column(name = "Bandera")
    private byte[] bandera;

    public Pais() {
    }

    public Pais(int id, String nombre, String codigoAlfa2, String codigoAlfa3,
                Moneda moneda, byte[] mapa, byte[] bandera) {
        this.id = id;
        this.nombre = nombre;
        this.codigoAlfa2 = codigoAlfa2;
        this.codigoAlfa3 = codigoAlfa3;
        this.moneda = moneda;
        this.mapa = mapa;
        this.bandera = bandera;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCodigoAlfa2() {
        return codigoAlfa2;
    }

    public void setCodigoAlfa2(String codigoAlfa2) {
        this.codigoAlfa2 = codigoAlfa2;
    }

    public String getCodigoAlfa3() {
        return codigoAlfa3;
    }

    public void setCodigoAlfa3(String codigoAlfa3) {
        this.codigoAlfa3 = codigoAlfa3;
    }

    public Moneda getMoneda() {
        return moneda;
    }

    public void setMoneda(Moneda moneda) {
        this.moneda = moneda;
    }

    public byte[] getMapa() {
        return mapa;
    }

    public void setMapa(byte[] mapa) {
        this.mapa = mapa;
    }

    public byte[] getBandera() {
        return bandera;
    }

    public void setBandera(byte[] bandera) {
        this.bandera = bandera;
    }
}