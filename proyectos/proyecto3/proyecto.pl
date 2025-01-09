sintoma(dengue, fiebre).
sintoma(dengue, dolor_muscular).
sintoma(dengue, fatiga).

sintoma(fiebre_amarilla, fiebre).
sintoma(fiebre_amarilla, dolor_cabeza).
sintoma(fiebre_amarilla, nauseas).

sintoma(malaria, fiebre).
sintoma(malaria, escalofrios).
sintoma(malaria, sudoracion).

sintoma(leishmaniasis, ulceras_piel).
sintoma(leishmaniasis, fiebre).
sintoma(leishmaniasis, perdidad_peso).

sintoma(covid19, fiebre).
sintoma(covid19, tos_seca).
sintoma(covid19, dificultad_respiratoria).

sintoma(gripe, fiebre).
sintoma(gripe, dolor_garganta).
sintoma(gripe, congestion_nasal).

sintoma(hepatitis, ictericia).
sintoma(hepatitis, fatiga).
sintoma(hepatitis, dolor_abdominal).

sintoma(tifoidea, fiebre).
sintoma(tifoidea, dolor_abdominal).
sintoma(tifoidea, diarrea).

sintoma(tuberculosis, fiebre).
sintoma(tuberculosis, sudoracion_nocturna).
sintoma(tuberculosis, perdida_peso).

sintoma(zika, fiebre).
sintoma(zika, dolor_articulaciones).
sintoma(zika, sarpullido).

sintoma(chikungunya, fiebre).
sintoma(chikungunya, dolor_articulaciones).
sintoma(chikungunya, dolor_cabeza).

sintoma(ebola, fiebre).
sintoma(ebola, sangrado).
sintoma(ebola, debilidad_extrema).

criterio(dengue, Edad, Sexo) :- Edad>=10, Edad=<60, member(Sexo, [m, f]).
criterio(fiebre_amarilla, Edad, Sexo) :- Edad>=15, Edad=<50, Sexo= m.
criterio(malaria, Edad, Sexo) :- Edad>=5,Edad=<70, member(Sexo, [m, f]).
criterio(leishmaniasis, Edad, Sexo) :- Edad>=20, Edad=<40, Sexo = f.
criterio(covid19, Edad, Sexo) :- Edad >= 0, member(Sexo, [m, f]).
criterio(gripe, Edad, Sexo) :- Edad >= 0, member(Sexo, [m, f]).
criterio(hepatitis, Edad, Sexo) :- Edad >= 20, member(Sexo, [m, f]).
criterio(tifoidea, Edad, Sexo) :- Edad >= 10, Edad =< 60, member(Sexo, [m, f]).
criterio(tuberculosis, Edad, Sexo) :- Edad >= 15, Edad =< 60, member(Sexo, [m, f]).
criterio(zika, Edad, Sexo) :- Edad >= 0, member(Sexo, [m, f]).
criterio(chikungunya, Edad, Sexo) :- Edad >= 0, member(Sexo, [m, f]).
criterio(ebola, Edad, Sexo) :- Edad >= 20, member(Sexo, [m, f]).

:- dynamic paciente/3.
:- dynamic tiene_sintoma/2.

leer_lineas(Stream) :-
    at_end_of_stream(Stream), !.
leer_lineas(Stream) :-
    read_line_to_string(Stream, Line),
    writeln("Linea leida: "), writeln(Line),
    leer_lineas(Stream).

cargar_datos(Archivo) :-
    writeln("Intentando abrir el archivo: "), writeln(Archivo),
    open(Archivo, read, Stream),
    writeln("Archivo abierto correctamente."),
    cargar_lineas(Stream),
    close(Stream),
    writeln("Carga completada.").

cargar_lineas(Stream) :-
    at_end_of_stream(Stream), !,
    writeln("Fin del archivo alcanzado.").

cargar_lineas(Stream) :-
    read_line_to_string(Stream, Line),
    writeln("Leyendo linea: "), writeln(Line),
    ( Line \= "" ->
    procesar_linea(Line),
      writeln("Linea procesada correctamente.")
    ;
    writeln("Linea vacia, ignorando.")
    ),
    cargar_lineas(Stream).


agregar_sintomas(_, []).
agregar_sintomas(Nombre, [Sintoma|Resto]) :-
    atom_string(SintomaAtom, Sintoma),
    writeln("Agregando sintoma: "), writeln(SintomaAtom),
    assertz(tiene_sintoma(Nombre, SintomaAtom)),
    agregar_sintomas(Nombre, Resto).

cumple_criterios(Paciente, Enfermedad) :-
    paciente(Paciente, Edad, Sexo),
    criterio(Enfermedad, Edad, Sexo).

procesar_linea(Line) :-
    writeln("Procesando línea: "),
    writeln(Line),
    % Limpia la línea para eliminar espacios extra
    normalize_space(string(Limpia), Line), % Quita espacios extra en la línea
    writeln("Línea limpia: "), writeln(Limpia),
    % Divide la línea en partes
    ( split_string(Limpia, ", ", "", Partes)
    -> writeln("Línea dividida correctamente."),
       writeln("Partes: "), writeln(Partes),
       % Filtra partes vacías y valida que haya 4 elementos
       exclude(==( ""), Partes, PartesFiltradas), % Elimina partes vacías
       ( PartesFiltradas = [NombreStr, EdadStr, SexoStr, SintomasStr]
       -> writeln("Partes asignadas correctamente."),
          % Procesa cada parte
          split_string(NombreStr, ": ", "", [_, Nombre]),
          split_string(EdadStr, ": ", "", [_, EdadTexto]), number_string(Edad, EdadTexto),
          split_string(SexoStr, ": ", "", [_, SexoTemp]),
          string_lower(SexoTemp, Sexo),  % Convierte Sexo a minúsculas
          split_string(SintomasStr, ": ", "", [_, SintomasTexto]),
          split_string(SintomasTexto, "\",\"", "\"[", Sintomas),
          maplist(remove_quotes, Sintomas, SintomasLimpios),
          writeln("Datos procesados: "), writeln([Nombre, Edad, Sexo, SintomasLimpios]),
          assertz(paciente(Nombre, Edad, Sexo)),
          agregar_sintomas(Nombre, SintomasLimpios)
       ; writeln("Error asignando las partes.")
       )
    ; writeln("Error dividiendo la línea principal.")
    ).

remove_quotes(Sintoma, SintomaLimpio) :-
    string_replace(Sintoma, "\"", "", SintomaLimpio).

tiene_enfermedad(Paciente, Enfermedad) :-
    cumple_criterios(Paciente, Enfermedad),
    sintoma(Enfermedad, Sintoma1),
    sintoma(Enfermedad, Sintoma2),
    sintoma(Enfermedad, Sintoma3),
    tiene_sintoma(Paciente, Sintoma1),
    tiene_sintoma(Paciente, Sintoma2),
    tiene_sintoma(Paciente, Sintoma3).

diagnosticar(Paciente) :-
    paciente(Paciente, Edad, Sexo),
    writeln("Diagnostico para el paciente:"),
    writeln("Nombre: "), writeln(Paciente),
    writeln("Edad: "), writeln(Edad),
    writeln("Sexo: "), writeln(Sexo),
    findall(Enfermedad, tiene_enfermedad(Paciente, Enfermedad), Enfermedades),
    ( Enfermedades = [] ->
    writeln('No se encontraron coincidencias para el diagnostico.');
    writeln('Posibles diagnoticos:'), writeln(Enfermedades)
    ).

limpiar_datos :-
    retractall(paciente(_, _, -)),
    retractall(tiene_sintoma(_, _)).


