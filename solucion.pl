% Solución en Prolog
vive(juan, almagro, casa(120)).
vive(nico, almagro, departamento(3, 2)).
vive(alf, almagro, departamento(3, 1)).
vive(julian, almagro, loft(2000)).
vive(vale, flores, departamento(4, 1)).
vive(fer, flores, casa(110)).

esCopado(casa(Metros)):-
    Metros > 100.

esCopado(departamento(Ambientes,_)):-
    Ambientes > 3.

esCopado(departamento(_, Banos)):-
    Banos > 1.

esCopado(loft(Anio)):-
    Anio > 2015.

barrioCopado(Barrio):-
    vive(_, Barrio,_),
    forall(vive(_, Barrio, Propiedad), esCopado(Propiedad)).

seriaBarato(loft(Anio)):-
    Anio < 2005.

seriaBarato(casa(Metros)):-
    Metros < 90.

seriaBarato(departamento(Ambientes,_)):-
    between(1, 2, Ambientes).

esBarato(Propiedad):-
    vive(_,_, Propiedad),
    seriaBarato(Propiedad).

barrioCaro(Barrio):-
    vive(_, Barrio,_),
    not((vive(_, Barrio, Propiedad), esBarato(Propiedad))).

sublista([], []).

sublista([_|Cola], Sublista):-
    sublista(Cola, Sublista).

sublista([Cabeza|Cola], [Cabeza|Sublista]):-
    sublista(Cola, Sublista).

cuantoPago(juan, 150000).
cuantoPago(nico, 80000).
cuantoPago(alf, 75000).
cuantoPago(julian, 140000).
cuantoPago(vale, 95000).
cuantoPago(fer, 60000).

cuantoPagoCadaUno([Propietario], [Precio]):-
    cuantoPago(Propietario, Precio).

cuantoPagoCadaUno([Propietario|Propietarios], [Precio|Precios]):-
    cuantoPago(Propietario, Precio),
    cuantoPagoCadaUno(Propietarios, Precios).

cuantoPagaron(Propietarios, Precio):-
    cuantoPagoCadaUno(Propietarios, ListaPrecios),
    sumlist(ListaPrecios, Precio).

todosLosPropietarios(Propietarios):-
    findall(Propietario, vive(Propietario,_,_), Propietarios).

seLesPuedeComprar(Presupuesto, Propietarios, Restante):-
    todosLosPropietarios(PosiblesProp),
    sublista(PosiblesProp, Propietarios),
    cuantoPagaron(Propietarios, Precio),
    Presupuesto >= Precio,
    Restante is Presupuesto - Precio.
