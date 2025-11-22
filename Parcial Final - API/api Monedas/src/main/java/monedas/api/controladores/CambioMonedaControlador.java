package monedas.api.controladores;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import monedas.api.dominio.CambioMoneda;
import monedas.api.repositorio.CambioMonedaRepositorio;

@RestController
@RequestMapping("/api/cambios")
public class CambioMonedaControlador {

    @Autowired
    private CambioMonedaRepositorio repositorio;

    @RequestMapping(value = "/listar", method = RequestMethod.GET)
    public List<CambioMoneda> listar() {
        return repositorio.findAll();
    }

    @RequestMapping(value = "/agregar", method = RequestMethod.POST)
    public CambioMoneda agregar(@RequestBody CambioMoneda cambio) {
        cambio.setId(0);
        return repositorio.save(cambio);
    }

    @RequestMapping(value = "/modificar", method = RequestMethod.PUT)
    public CambioMoneda modificar(@RequestBody CambioMoneda cambio) {
        Optional<CambioMoneda> encontrado = repositorio.findById(cambio.getId());
        if (encontrado.isPresent()) {
            return repositorio.save(cambio);
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
