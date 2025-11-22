package monedas.api.controladores;

import monedas.api.dominio.Moneda;
import monedas.api.repositorios.MonedaRepositorio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/monedas")
public class MonedaControlador {

    @Autowired
    private MonedaRepositorio repositorio;

    // Listar todas las monedas
    @GetMapping
    public List<Moneda> listar() {
        return repo.findAll();
    }

    // Obtener una moneda por ID
    @GetMapping("/{id}")
    public Moneda obtener(@PathVariable int id) {
        return repo.findById(id).orElse(null);
    }

    // Crear una nueva moneda
    @PostMapping
    public Moneda crear(@RequestBody Moneda moneda) {
   
        moneda.setId(0);
        return repo.save(moneda);
    }

    // Actualizar una moneda existente
    @PutMapping("/{id}")
    public Moneda actualizar(@PathVariable int id, @RequestBody Moneda moneda) {
        Optional<Moneda> base = repo.findById(id);
        if (base.isPresent()) {
            Moneda monedaExistente = base.get();
            monedaExistente.setNombre(moneda.getNombre());
            monedaExistente.setSigla(moneda.getSigla());
            monedaExistente.setSimbolo(moneda.getSimbolo());
            return repo.save(monedaExistente);
        } else {
            return null; 
        }
    }

    // Eliminar una moneda por ID
    @DeleteMapping("/{id}")
    public boolean eliminar(@PathVariable int id) {
        try {
            repo.deleteById(id);
            return true;
        } catch (Exception ex) {
            return false; 
        }
    }
}
