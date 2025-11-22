package monedas.api.repositorios;

import monedas.api.dominio.CambioMoneda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface CambioMonedaRepositorio extends JpaRepository<CambioMoneda, Integer> {

    @Query("SELECT c FROM CambioMoneda c " +
           "WHERE c.moneda.sigla = :sigla " +
           "AND c.fecha BETWEEN :desde AND :hasta")
    List<CambioMoneda> listarPorPeriodo(LocalDate desde, LocalDate hasta, String sigla);

}
