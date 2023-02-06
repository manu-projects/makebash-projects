import {Usuario} from "./model/usuario"
import {take, filter, from} from "rxjs"

let usuario1 = new Usuario();
usuario1.idUsuario = 1
usuario1.nombre = "Jean Luc"
usuario1.velocidad = 100

let usuario2 = new Usuario();
usuario2.idUsuario = 2
usuario2.nombre = "William"
usuario2.velocidad = 200

let usuario3 = new Usuario();
usuario3.idUsuario = 3
usuario3.nombre = "Data"
usuario3.velocidad = 900

const listadoPersonajesObservables = from([usuario1, usuario2, usuario3])

// pipe: cada vez que usaremos otro operador aparte del from
// operador filter: sólo emitirá los valores que cumplen la condición del predicado
const suscripcionPersonajesMasRapidos = listadoPersonajesObservables
    .pipe(filter(usuario => usuario.velocidad > 500))
    .subscribe(usuario => console.log('un personaje veloz es ', usuario.nombre))

const suscripcionPersonajesMasLentos = listadoPersonajesObservables
    .pipe(filter(usuario => usuario.velocidad < 500))
    .pipe(take(1))
    .subscribe(usuario => console.log('un personaje lento es ', usuario.nombre))
