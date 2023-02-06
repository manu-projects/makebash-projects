import {Usuario} from "./model/usuario"
import {Observable, interval, from, range} from "rxjs"

let usuario1 = new Usuario();
usuario1.idUsuario = 1
usuario1.nombre = "Jean Luc"

let usuario2 = new Usuario();
usuario2.idUsuario = 2
usuario2.nombre = "William"

// operador create: crea un sujeto observable a partir de la función pasada por parámetro,
// (la función pasada por parámetro define como se va a emitir los valores el Sujeto Observable)
const saludo = Observable.create(function(observer){
    observer.next('bienvenido');
    observer.next('a la fiesta');
    observer.complete();
})

const visitanteObservador = saludo.subscribe(x => console.log(x))

// operador range: crea un Sujeto Observable que emite un números enteros entre un rango de valores
const televidenteObservador = range(1,5).subscribe(x => console.log('número de la loteria:', x))

// operador from: convierte una colección objetos ó una colección de estructuras de datos en un Sujeto Observable
const listadoEntrevistadosObservable = from([usuario1, usuario2])
const entrevistadorObservador = listadoEntrevistadosObservable.subscribe(x => console.log('entrevisté a ', x))

const listadoNumerosDeLaSuerteObservable = from([10,20,39])
const estudianteObservador = listadoNumerosDeLaSuerteObservable.subscribe(x => console.log('memorizando numero de la suerte ', x))

// operador interval: Crea un observable que emite valores cada cierto intervalo de tiempo (en este caso cada 1 segundo)
const observador5 = interval(1000).subscribe(x => console.log(x))
