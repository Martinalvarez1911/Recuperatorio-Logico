%viveEn(Persona, Lugar)
%casa(MetrosCuadrados)
%departamento(ambientes, baños)
%loft(año)

viveEn(juan, casa(120)).
viveEn(nico, departamento(3, 2)).
viveEn(alf, departamento(3, 1)).
viveEn(julian, loft(2000)).
viveEn(vale, departamento(4, 1)).
viveEn(fer, casa(110)).

%barrio(NombreDeBarrio)

barrio(alf, almagro).
barrio(juan, almagro).
barrio(nico, almagro).
barrio(julian, almagro).
barrio(vale, flores).
barrio(fer, flores).

%2

esBarrio(Barrio):-
    barrio(_, Barrio).

barrioCopado(Barrio):-
    esBarrio(Barrio),
    forall(barrio(Persona, Barrio), viveEnPropiedadCopada(Persona)).

viveEnPropiedadCopada(Persona):-
    viveEn(Persona, Propiedad),
    esCopada(Propiedad).

esCopada(casa(MetrosCuadrados)):-
    MetrosCuadrados > 100.

esCopada(departamento(Ambientes, _)):-
    Ambientes > 3.

esCopada(departamento(_, Banios)):-
    Banios > 1.

esCopada(loft(Anio)):-
    Anio > 2015.

%3

barrioCaro(Barrio):-
    esBarrio(Barrio),
    forall(barrio(Persona, Barrio), not(viveEnPropiedadBarata(Persona, _))).

viveEnPropiedadBarata(Persona, Propiedad):-
    viveEn(Persona, Propiedad),
    esBarata(Propiedad).

esBarata(loft(Anio)):-
    Anio < 2005.

esBarata(casa(MetrosCuadrados)):-
    MetrosCuadrados < 90.

esBarata(departamento(Ambientes, _)):-
    between(1, 2, Ambientes).

%4
%tasacion(Persona, Precio)
%Entiendo que el precio es propia de la casa de la persona y no que
%todas las casas como del tipo de juan tiene ese precio

tasacion(casaDeJuan, 150000).
tasacion(casaDeNico, 80000).
tasacion(casaDeAlf, 75000).
tasacion(casaDeJulian, 140000).
tasacion(casaDeVale, 95000).
tasacion(casaDeFer, 60000).

puedeComprar(DineroDisponible, PropiedadesComprables, DineroRestante):-
    findall(Propiedad, tasacion(Propiedad, _), ListaPropiedades),
    sublista(ListaPropiedades, PropiedadesComprables),
    PropiedadesComprables \= [],
    costoTotal(PropiedadesComprables, CostoTotal),
    DineroDisponible >= CostoTotal,
    DineroRestante is DineroDisponible - CostoTotal.

costoTotal([], 0).
costoTotal([Propiedad|Propiedades], CostoTotal):-
    tasacion(Propiedad, Precio),
    costoTotal(Propiedades, CostoParcial),
    CostoTotal is Precio + CostoParcial.


sublista([], []).
sublista([_|Cola], Sublista):-
    sublista(Cola, Sublista).
sublista([Cabeza | Cola], [Cabeza | Sublista]):-
    sublista(Cola, Sublista).

    

    
