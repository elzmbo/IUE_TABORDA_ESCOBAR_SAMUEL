package monedas.api.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import monedas.api.dominio.Pais;

@Repository
public interface PaisRepository extends JpaRepository<Pais, Integer> {

}
