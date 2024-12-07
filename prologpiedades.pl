/*
Punto 1: Hablar con propiedad

Se pide que agregue a la base de conocimientos la siguiente información:
    -Juan vive en una casa de 120 metros cuadrados
    -Nico vive en un 3 ambientes con 2 baños, al igual que alf pero alf tiene un baño solo
    -Julian vive en un loft construido en el año 2000
    -Vale vive en un 4 ambientes con 1 baño
    -Fer vive en una casa de 110 metros cuadrados
    -No sabemos donde vive Felipe
    -Rocio se quiere mudar a una casa de 90 metros cuadrados
    -Alf, Juan, Nico y Julian viven en almagro
    -Vale y Fer viven en flores
*/

% viveEn(Persona, casa(MetrosCuadrados)).
% viveEn(Persona, departamento(Ambientes, Baños)).
% viveEn(Persona, loft(AñoDeConstruccion)).

% viveEnBarrio(Persona, Barrio).

viveEn(juan, casa(120)).
viveEn(nico, departamento(3, 2)).
viveEn(alf, departamento(3, 1)).
viveEn(julian, loft(2000)).
viveEn(vale, departamento(4, 1)).
viveEn(fer, casa(110)).
% A felipe y a ro no los modelo porque se modela por principio de universo cerrado.

% barrio(Barrio).
barrio(almagro).
barrio(flores).

% viveEnBarrio(Persona, Barrio).
viveEnBarrio(alf, almagro).
viveEnBarrio(juan, almagro).
viveEnBarrio(nico, almagro).
viveEnBarrio(julian, almagro).
viveEnBarrio(vale, flores).
viveEnBarrio(fer, flores).



/*
Punto 2: Barrio copado, infierno chico.
Queremos saber si en un barrio todas las personas viven en propiedades copadas.
    -Una casa de mas de 100 metros cuadrados es copada
    -Un departamento de mas de 3 ambientes es copado
    -Un departamento de mas de 1 baño es copado
    -Un loft construido despues del 2015 es copado

El predicado debe ser inversible. Un barrio copado es flores, porque fer vive en una casa de 110 metros cuadrados (>100) y vale vive en
un departamento de 4 ambientes > 3.
*/

% esCopada(Propiedad).
esCopada(casa(MetrosCuadrados)):-
    MetrosCuadrados > 100.

esCopada(departamento(Ambientes, _)):-
    Ambientes > 3.

esCopada(departamento(_, Banios)):-
    Banios > 1.

esCopada(loft(AnioDeConstruccion)):-
    AnioDeConstruccion > 2015.

barrioCopadoInfiernoChico(Barrio):-
    barrio(Barrio),
    forall(viveEnBarrio(Persona, Barrio),(viveEn(Persona, Propiedad), esCopada(Propiedad))).

/*
Punto 3: Barrio (caro) tal vez
Ahora necesitamos conocer si hay un barrio caro, en el que no hay una propiedad que sea barata.
    -los loft construidos antes del 2005 son baratos
    -las casas de menos de 90 metros son baratas
    -los departamentos que tienen 1 o 2 ambientes son baratos

    El predicado debe ser inversible. En el ejemplo del punto 1, flores es un barrio caro
    porque la casa donde vive Fer tiene mas de 90 metros cuadrados y el departamento de vale tiene mas de 2 ambientes
*/

% esBarata(Propiedad).

esBarata(loft(AnioDeConstruccion)):-
    AnioDeConstruccion < 2005.

esBarata(casa(MetrosCuadrados)):-
    MetrosCuadrados < 90.

esBarata(departamento(Ambientes, _)):-
    between(1, 2, Ambientes).

esBarrioCaro(Barrio):-
    barrio(Barrio),
    forall(viveEnBarrio(Persona, Barrio), (viveEn(Persona, Propiedad), not(esBarata(Propiedad)))).

/*
Punto 4: Tasa, tasa, tasación de la casa.

Tenemos ahora las tasciones de cada inmueble (eso no invalida el punto 3, la definicion de propiedad no varía):
La propiedad de juan vale 150000 usd
La propiedad de nico vale 80000 usd
La propiedad de alf vale 75000 usd
la propiedad de julian vale 140000 usd
la propiedad de vale vale 95000 usd
la propiedad de fer vale 60000 usd
*/

% valorPropiedad(Propietario, Valor).
valorPropiedad(juan, 150000).
valorPropiedad(nico, 80000).
valorPropiedad(alf, 75000).
valorPropiedad(julian, 140000).
valorPropiedad(vale, 95000).
valorPropiedad(fer, 60000).

sublista([],[]).
sublista([_|Cola], Sublista):-
    sublista(Cola, Sublista).
sublista([Cabeza|Cola],[Cabeza|Sublista]):-
    sublista(Cola, Sublista).

puedeComprar(PresupuestoInicial, PresupuestoFinal, CombinacionesDeCasas):-
    findall(valorPropiedad(Propietario, Valor), (valorPropiedad(Propietario, Valor), Valor < PresupuestoInicial), PropiedadesDisponibles),
    sublista(PropiedadesDisponibles, CombinacionesDeCasas).




