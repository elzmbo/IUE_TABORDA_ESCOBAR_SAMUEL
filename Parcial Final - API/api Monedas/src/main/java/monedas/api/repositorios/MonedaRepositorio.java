package monedas.api.repositorios;

import monedas.api.dominio.Moneda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MonedaRepositorio extends JpaRepository<Moneda, Integer> {

    Moneda findBySigla(String sigla);

}
