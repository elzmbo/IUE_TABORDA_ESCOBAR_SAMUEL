package monedas.api.repositorios;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import monedas.api.dominio.Pais;

@Repository
public interface PaisRepositorio extends JpaRepository<Pais, Integer> {

}
