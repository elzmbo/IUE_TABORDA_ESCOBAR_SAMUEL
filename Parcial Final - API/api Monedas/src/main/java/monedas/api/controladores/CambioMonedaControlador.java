package monedas.api.controladores;

import monedas.api.dominio.CambioMoneda;
import monedas.api.dominio.dtos.CambioMonedaPeriodoDto;
import monedas.api.repositorios.CambioMonedaRepositorio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/cambios")
public class CambioMonedaControlador {

    @Autowired
    private CambioMonedaRepositorio repositorio;

    // Listar todos los cambios de moneda
    @GetMapping
    public List<CambioMoneda> listar() {
        return repo.findAll();
    }

    // Obtener un cambio de moneda por ID
    @GetMapping("/{id}")
    public CambioMoneda obtener(@PathVariable int id) {
        return repo.findById(id).orElse(null);
    }

    // Crear un nuevo cambio de moneda
    @PostMapping
    public CambioMoneda crear(@RequestBody CambioMoneda cambio) {
        cambio.setId(0);
        return repo.save(cambio);
    }

    // Actualizar un cambio de moneda existente
    @PutMapping("/{id}")
    public CambioMoneda actualizar(@PathVariable int id, @RequestBody CambioMoneda cambio) {
        Optional<CambioMoneda> base = repo.findById(id);
        if (base.isPresent()) {
            CambioMoneda cambioExistente = base.get();
            cambioExistente.setFecha(cambio.getFecha());
            cambioExistente.setValor(cambio.getValor());
            cambioExistente.setMoneda(cambio.getMoneda());
            return repo.save(cambioExistente);
        } else {
            return null; 
        }
    }

    // Eliminar un cambio de moneda por ID
    @DeleteMapping("/{id}")
    public boolean eliminar(@PathVariable int id) {
        try {
            repo.deleteById(id);
            return true;
        } catch (Exception ex) {
            return false; 
        }
    }

    // Consulta por periodo
    @PostMapping("/listarporperiodo")
    public List<CambioMoneda> listarPorPeriodo(@RequestBody CambioMonedaPeriodoDto dto) {
        return repo.listarPorPeriodo(dto.getDesde(), dto.getHasta(), dto.getSigla());
    }
}
