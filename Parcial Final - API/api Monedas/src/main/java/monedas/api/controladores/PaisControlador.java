package monedas.api.controladores;

import monedas.api.dominio.Pais;
import monedas.api.repositorios.PaisRepositorio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/paises")
public class PaisControlador {

    @Autowired
    private PaisRepositorio repositorio;

    // Listar todos los países
    @GetMapping
    public List<Pais> listar() {
        return repo.findAll();
    }

    // Obtener un país por ID
    @GetMapping("/{id}")
    public Pais obtener(@PathVariable int id) {
        return repo.findById(id).orElse(null);
    }

    // Crear un nuevo país
    @PostMapping
    public Pais crear(@RequestBody Pais pais) {
        pais.setId(0); 
        return repo.save(pais);
    }

    // Actualizar un pais existente
    @PutMapping("/{id}")
    public Pais actualizar(@PathVariable int id, @RequestBody Pais pais) {
        Optional<Pais> base = repo.findById(id);
        if (base.isPresent()) {
            Pais paisExistente = base.get();
            paisExistente.setNombre(pais.getNombre());
            paisExistente.setCodigoIso(pais.getCodigoIso());
            paisExistente.setMoneda(pais.getMoneda());
            return repo.save(paisExistente);
        } else {
            return null; 
        }
    }

    // Eliminar un pais por ID
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
