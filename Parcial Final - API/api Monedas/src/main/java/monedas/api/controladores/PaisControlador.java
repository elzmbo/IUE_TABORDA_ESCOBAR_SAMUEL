package monedas.api.controladores;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import monedas.api.dominio.Pais;
import monedas.api.repositorio.PaisRepository;

@RestController
@RequestMapping("/api/paises")
public class PaisControlador {

    @Autowired
    private PaisRepository repositorio;

    @RequestMapping(value = "/listar", method = RequestMethod.GET)
    public List<Pais> listar() {
        return repositorio.findAll();
    }

    @RequestMapping(value = "/agregar", method = RequestMethod.POST)
    public Pais agregar(@RequestBody Pais pais) {
        pais.setId(0);
        return repositorio.save(pais);
    }

    @RequestMapping(value = "/modificar", method = RequestMethod.PUT)
    public Pais modificar(@RequestBody Pais pais) {
        Optional<Pais> encontrado = repositorio.findById(pais.getId());
        if (encontrado.isPresent()) {
            return repositorio.save(pais);
        } else {
            return null;
        }
    }

    @RequestMapping(value = "/eliminar/{id}", method = RequestMethod.DELETE)
    public boolean eliminar(@PathVariable int id) {
        try {
            repositorio.deleteById(id);
            return true;
        } catch (Exception ex) {
            return false;
        }
    }
}
