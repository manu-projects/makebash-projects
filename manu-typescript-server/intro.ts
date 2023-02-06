import {interval, take, map, filter, reduce, pipe, from} from "rxjs"

const unStream = from(['1','2','foo','3','4']);

unStream
    .subscribe(x => console.log('valor emitido por el observable', x));

unStream
    .pipe(map(x => parseInt(x)),
          filter(x => !isNaN(x)))
    .subscribe(x => console.log('entero emitido por el observable', x));

// podemos tomar valores de un array
const unArray = [1,2,3,4,5,6];

interval(1000)
    .pipe(
        take(5),
        filter(x => x < 5),
        map( x => unArray[x]))
    .subscribe(x => console.log('valor obtenido de un array luego de un segundo', x));
