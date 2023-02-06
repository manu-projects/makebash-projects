import {Usuario} from "./model/usuario"
import {of, merge} from "rxjs"

let usuario1 = new Usuario();
usuario1.idUsuario = 1
usuario1.nombre = "Jean Luc"

let usuario2 = new Usuario();
usuario2.idUsuario = 2
usuario2.nombre = "William"

let usuario3 = new Usuario();
usuario3.idUsuario = 3
usuario3.nombre = "William"

// of: es un operador de creación, convierte un elemento en un sujeto observable
let obs1 = of(usuario1)
let obs2 = of(usuario2)
let obs3 = of(usuario3)

// merge es un operador de combinación
const listadoPersonajesObservados = merge(obs1, obs2, obs3).subscribe(x => console.log('datos del personaje ', x))
