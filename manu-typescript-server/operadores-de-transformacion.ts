import {Usuario} from "./model/usuario"
import {map, from} from "rxjs"

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

// operador pipe: cada vez que usaremos otro operador aparte del from
// operador map: transforma los elementos emitidos por un sujeto Observable, aplicando una función a cada elemento
const suscripcionPersonajesEvolucionados = listadoPersonajesObservables
    .pipe(map(usuario => usuario.velocidad * 2))
    .subscribe(dobleDeVelocidad => console.log('Velocidad doble: ', dobleDeVelocidad))
