package monedas.api.dominio;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import jakarta.persistence.Table;

@Entity
@Table(name = "Moneda")
public class Moneda {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private int id;

    @Column(name = "Moneda", length = 100, unique = true)
    private String nombre;

    @Column(name = "Sigla", length = 5)
    private String sigla;

    @Column(name = "Simbolo", length = 5)
    private String simbolo;

    @Column(name = "Emisor", length = 100)
    private String emisor;

    @Lob
    @Column(name = "Imagen")
    private byte[] imagen;

    public Moneda() {
    }

    public Moneda(String nombre, String sigla, String simbolo) {
        this.nombre = nombre;
        this.sigla = sigla;
        this.simbolo = simbolo;
    }

    public Moneda(int id, String nombre, String sigla, String simbolo, String emisor, byte[] imagen) {
        this.id = id;
        this.nombre = nombre;
        this.sigla = sigla;
        this.simbolo = simbolo;
        this.emisor = emisor;
        this.imagen = imagen;
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

    public byte[] getImagen() {
        return imagen;
    }

    public void setImagen(byte[] imagen) {
        this.imagen = imagen;
    }
}