import 'package:intl/intl.dart';

final dateFormat = new DateFormat("yyyy-MM-dd HH:mm");
class ItemValue{
  String toString();
}

class UserApp{
  final String userName;
  final String rol;
  final String password;

  UserApp({
    this.userName = "",
    this.rol = "",
    this.password = "",
  });

  factory UserApp.fromJson(Map<String, dynamic> json) {
    return UserApp(
      userName: json['user_name'],
      rol: json['rol'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
    'user_name': userName,
    'rol': rol,
    'password': password,
  };
}

class LigaDTO extends ItemValue{
  int idLiga;
  String cuit;
  String domicilio;
  String mailContacto;
  String nombre;
  String nombreContacto;
  String telefono;
  String telefonoContacto;
  bool deleteSelected;

  LigaDTO(
      {this.cuit,
        this.domicilio,
        this.idLiga,
        this.mailContacto,
        this.nombre,
        this.nombreContacto,
        this.telefono,
        this.telefonoContacto});

  LigaDTO.fromJson(Map<String, dynamic> json) {
    cuit = json['cuit'];
    domicilio = json['domicilio'];
    idLiga = json['idLiga'];
    mailContacto = json['mailContacto'];
    nombre = json['nombre'];
    nombreContacto = json['nombreContacto'];
    telefono = json['telefono'];
    telefonoContacto = json['telefonoContacto'];
    deleteSelected = false;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cuit'] = this.cuit;
    data['domicilio'] = this.domicilio;
    data['idLiga'] = this.idLiga;
    data['mailContacto'] = this.mailContacto;
    data['nombre'] = this.nombre;
    data['nombreContacto'] = this.nombreContacto;
    data['telefono'] = this.telefono;
    data['telefonoContacto'] = this.telefonoContacto;
    return data;
  }

  @override
  String toString() {
    return nombre;
  }
}

class CampeonatoDTO extends ItemValue{
  int idCampeonato;
  int idLiga;
  LigaDTO ligaDTO;
  String idModelo;
  String descripcion;
  DateTime fechaInicio;
  DateTime fechaFin;
  bool genFixture;

  CampeonatoDTO(
      {this.idCampeonato,
        this.idLiga,
        this.idModelo,
        this.descripcion,
        this.fechaInicio,
        this.fechaFin,
        this.genFixture
      });

  CampeonatoDTO.fromJson(Map<String, dynamic> json) {
    idCampeonato = json['id_campeonato'];
    idLiga = json['id_liga'];
    idModelo = json['id_modelo'];
    descripcion = json['descripcion'];
    fechaInicio = DateTime.parse(json['fecha_inicio']);
    fechaFin = DateTime.parse(json['fecha_fin']);
    genFixture = json['gen_fixture'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_campeonato'] = this.idCampeonato;
    data['id_liga'] = this.idLiga;
    data['id_modelo'] = this.idModelo;
    data['descripcion'] = this.descripcion;
    data['fecha_inicio'] = this.fechaInicio.toIso8601String().contains("Z") ? this.fechaInicio.toIso8601String(): this.fechaInicio.toIso8601String() + "Z";
    data['fecha_fin'] = this.fechaFin.toIso8601String().contains("Z") ? this.fechaFin.toIso8601String(): this.fechaFin.toIso8601String() + "Z";
    data['gen_fixture'] = this.genFixture;
    return data;
  }
  @override
  String toString() {
    return this.descripcion;
  }
}

class CampeonatosGoleadoresDTO {
  int idJugador;
  String equipo;
  String nombre;
  String apellido;
  int goles;

  CampeonatosGoleadoresDTO({
    this.idJugador,
    this.equipo,
    this.nombre,
    this.apellido,
    this.goles
  });

  CampeonatosGoleadoresDTO.fromJson(Map<String, dynamic> json) {
    idJugador = json['id_jugador'];
    equipo = json['equipo'];
    nombre = json['nombre'];
    apellido = json['apellido'];
    goles = json['goles'];
  }
}

class EquipoDTO extends ItemValue{
  int idEquipo;
  bool habilitado;
  String nombre;
  Null foto;
  CampeonatoDTO campeonatoDTO;
  int idCampeonato;

  EquipoDTO(
      {this.idEquipo, this.foto, this.habilitado, this.nombre, this.idCampeonato});

  EquipoDTO.fromJson(Map<String, dynamic> json) {
    foto = json['foto'];
    habilitado = json['habilitado'];
    idEquipo = json['id_equipo'];
    nombre = json['nombre'];
    idCampeonato = json['id_campeonato'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.idEquipo != null){
      data['id_equipo'] = this.idEquipo;
    }
    if(this.idCampeonato != null){
      data['id_campeonato'] = this.idCampeonato;
    }
    if(this.foto != null){
      data['foto'] = this.foto;
    }
    data['habilitado'] = this.habilitado;

    data['nombre'] = this.nombre;
    return data;
  }

  @override
  String toString() {
    return this.nombre;
  }
}

class EquipoTablePosDTO {
  int idCampeonato;
  int idEquipo;
  String nombre;
  int nroEquipo;
  int puntos;
  int partidosGanados;
  int partidosEmpatados;
  int partidosPerdidos;

  EquipoTablePosDTO(
      {this.idCampeonato, this.idEquipo, this.nombre, this.nroEquipo, this.puntos,
        this.partidosGanados, this.partidosEmpatados, this.partidosPerdidos});

  EquipoTablePosDTO.fromJson(Map<String, dynamic> json) {
    idCampeonato = json['id_campeonato'];
    idEquipo = json['id_equipo'];
    nombre = json['nombre'];
    nroEquipo = json['nro_equipo'];
    puntos = json['puntos'];
    partidosGanados = json['p_gan'];
    partidosEmpatados = json['p_emp'];
    partidosPerdidos = json['p_per'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_campeonato'] = this.idCampeonato;
    data['id_equipo'] = this.idEquipo;
    data['nombre'] = this.nombre;
    data['nro_equipo'] = this.nroEquipo;
    data['puntos'] = this.puntos;
    data['p_gan'] = this.partidosGanados;
    data['p_emp'] = this.partidosEmpatados;
    data['p_per'] = this.partidosPerdidos;
    return data;
  }
}

class SancionesJugadoresFromCampeonatoDTO {
  String apellido;
  String nombre;
  String eNombre;
  int  cRojas;
  int cAmarillas;
  int cAzules;

  SancionesJugadoresFromCampeonatoDTO(
      {this.nombre, this.apellido, this.eNombre, this.cRojas, this.cAmarillas, this.cAzules});

  SancionesJugadoresFromCampeonatoDTO.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    apellido = json['apellido'];
    eNombre = json['e_nombre'];
    cRojas = json['c_rojas'];
    cAmarillas = json['c_amarillas'];
    cAzules = json['c_azules'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this.nombre;
    data['apellido'] = this.apellido;
    data['e_nombre'] = this.eNombre;
    data['c_rojas'] = this.cRojas;
    data['c_amarillas'] = this.cAmarillas;
    data['c_azules'] = this.cAzules;
    return data;
  }
}



class PartidoDTO {
  int idPartidos;

  String fechaEncuentro;
  int idArbitro;
  int idAsistente;
  int idCampeonato;
  int idEquipoLocal;
  int idEquipoVisitante;
  int idLiga;
  String motivoSuspencion;
  String observacion;
  int resultadoLocal;
  int resultadoVisitante;
  bool suspendido;
  bool iniciado;
  bool finalizado;

  PartidoDTO(
      {this.fechaEncuentro,
        this.idArbitro,
        this.idAsistente,
        this.idCampeonato,
        this.idEquipoLocal,
        this.idEquipoVisitante,
        this.idLiga,
        this.idPartidos,
        this.motivoSuspencion,
        this.observacion,
        this.resultadoLocal,
        this.resultadoVisitante,
        this.suspendido,
        this.iniciado,
        this.finalizado
      });

  PartidoDTO.fromJson(Map<String, dynamic> json) {
    fechaEncuentro = json['fecha_encuentro'];
    idArbitro = json['id_arbitro'];
    idAsistente = json['id_asistente'];
    idCampeonato = json['id_campeonato'];
    idEquipoLocal = json['id_equipo_local'];
    idEquipoVisitante = json['id_equipo_visitante'];
    idLiga = json['id_liga'];
    idPartidos = json['id_partidos'];
    motivoSuspencion = json['motivo_suspencion'];
    observacion = json['observacion'];
    resultadoLocal = json['resultado_local'];
    resultadoVisitante = json['resultado_visitante'];
    if( json['suspendido'] == ""){
      suspendido = false;
    } else {
      suspendido = json['suspendido'].toLowerCase() == 'true';
    }
    iniciado = json['iniciado'];
    finalizado = json['finalizado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fecha_encuentro'] = this.fechaEncuentro;
    data['id_arbitro'] = this.idArbitro;
    data['id_asistente'] = this.idAsistente;
    data['id_campeonato'] = this.idCampeonato;
    data['id_equipo_local'] = this.idEquipoLocal;
    data['id_equipo_visitante'] = this.idEquipoVisitante;
    data['id_liga'] = this.idLiga;
    data['id_partidos'] = this.idPartidos;
    data['motivo_suspencion'] = this.motivoSuspencion;
    data['observacion'] = this.observacion;
    data['resultado_local'] = this.resultadoLocal;
    data['resultado_visitante'] = this.resultadoVisitante;
    data['suspendido'] = this.suspendido;
    return data;
  }
}

class PartidosFromDateDTO {
  int idPartidos;

  String fechaEncuentro;
  String ligaName;
  String campeonatoName;
  String eLocalName;
  String eVisitName;
  int resultadoLocal;
  int resultadoVisitante;
  bool suspendido;
  bool iniciado;
  bool finalizado;
  String motivo;

  PartidosFromDateDTO(
      {this.idPartidos,
        this.fechaEncuentro,
        this.ligaName,
        this.campeonatoName,
        this.eLocalName,
        this.eVisitName,
        this.resultadoLocal,
        this.resultadoVisitante,
        this.suspendido,
        this.iniciado,
        this.finalizado,
        this.motivo
      });

  PartidosFromDateDTO.fromJson(Map<String, dynamic> json) {
    idPartidos = json['id_partidos'];
    fechaEncuentro = json['fecha_encuentro'];
    ligaName = json['liga_name'];
    campeonatoName = json['campeonato_name'];
    eLocalName = json['e_local_name'];
    eVisitName = json['e_visit_name'];
    resultadoLocal = json['resultado_local'];
    resultadoVisitante = json['resultado_visitante'];
    suspendido = json['suspendido'];
    iniciado = json['iniciado'];
    finalizado = json['finalizado'];
    motivo = json['motivo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_partidos'] = this.idPartidos;
    data['fecha_encuentro'] = this.fechaEncuentro;
    data['liga_name'] = this.ligaName;
    data['campeonato_name'] = this.campeonatoName;
    data['e_local_name'] = this.eLocalName;
    data['e_visit_name'] = this.eVisitName;
    data['resultado_local'] = this.resultadoLocal;
    data['resultado_visitante'] = this.resultadoVisitante;
    data['suspendido'] = this.suspendido;
    return data;
  }
}

class PartidoResultDTO{
  int idPartidos;
  int resultadoLocal;
  String goleadoresLocal;
  String sancionAmarillosLocal;
  String sancionRojosLocal;
  int resultadoVisitante;
  String goleadoresVisitante;
  String sancionAmarillosVisitante;
  String sancionRojosVisitante;
  bool iniciado;
  bool finalizado;
  bool suspendido;
  String motivo;

  PartidoResultDTO({
    this.idPartidos,
    this.resultadoLocal,
    this.goleadoresLocal,
    this.sancionAmarillosLocal,
    this.sancionRojosLocal,
    this.resultadoVisitante,
    this.goleadoresVisitante,
    this.sancionAmarillosVisitante,
    this.sancionRojosVisitante,
    this.iniciado,
    this.finalizado,
    this.suspendido,
    this.motivo
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_partidos'] = this.idPartidos;
    data['resultado_local'] = this.resultadoLocal;
    data['goleadores_local'] = this.goleadoresLocal;
    data['sancion_amarillos_local'] = this.sancionAmarillosLocal;
    data['sancion_rojos_local'] = this.sancionRojosLocal;
    data['resultado_visitante'] = this.resultadoVisitante;
    data['goleadores_visitante'] = this.goleadoresVisitante;
    data['sancion_amarillos_visitantes'] = this.sancionAmarillosVisitante;
    data['sancion_rojos_visitantes'] = this.sancionRojosVisitante;
    data['iniciado'] = this.iniciado;
    data['finalizado'] = this.finalizado;
    data['suspendido'] = this.suspendido;
    data['motivo'] = this.motivo;
    return data;
  }
}

class PersonaDTO {
  int idPersona;
  String nombre;
  String apellido;
  String domicilio;
  int edad;
  String localidad;
  int idPais;
  PaisDTO paisDTO;
  int idProvincia;
  ProvinciaDTO provinciaDTO;
  int idTipoDoc;
  int nroDoc;

  PersonaDTO(
      {this.idPersona,
        this.nombre,
        this.apellido,
        this.domicilio,
        this.edad,
        this.localidad,
        this.idPais,
        this.idProvincia,
        this.idTipoDoc,
        this.nroDoc});

  PersonaDTO.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    apellido = json['apellido'];
    domicilio = json['domicilio'];
    edad = json['edad'];
    localidad = json['localidad'];
    idPais = json['id_pais'];
    idPersona = json['id_persona'];
    idProvincia = json['id_provincia'];
    idTipoDoc = json['id_tipo_doc'];
    nroDoc = json['nro_doc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this.nombre;
    data['apellido'] = this.apellido;
    data['domicilio'] = this.domicilio;
    data['edad'] = this.edad;
    data['localidad'] = this.localidad;
    data['id_pais'] = this.idPais;
    if(this.idPersona != null){
      data['id_persona'] = this.idPersona;
    }
    data['id_provincia'] = this.idProvincia;
    data['id_tipo_doc'] = this.idTipoDoc;
    data['nro_doc'] = this.nroDoc;
    return data;
  }
}

class ArbitroDTO {
  int idArbitro;
  int idPersona;
  int idCampeonato;
  PersonaDTO personaDTO;
  CampeonatoDTO campeonatoDTO;

  ArbitroDTO({this.idArbitro, this.idPersona, this.idCampeonato});

  ArbitroDTO.fromJson(Map<String, dynamic> json) {
    idArbitro = json['id_arbitro'];
    idPersona = json['id_persona'];
    idCampeonato = json['id_campeonato'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.idArbitro !=  null){
      data['id_arbitro'] = this.idArbitro;
    }
    data['id_persona'] = this.idPersona;
    data['id_campeonato'] = this.idCampeonato;
    return data;
  }
}

class AsistenteDTO {
  int idAsistente;
  int idPersona;
  int idCampeonato;
  PersonaDTO personaDTO;
  CampeonatoDTO campeonatoDTO;

  AsistenteDTO({this.idAsistente, this.idPersona, this.idCampeonato});

  AsistenteDTO.fromJson(Map<String, dynamic> json) {
    idAsistente = json['id_asistente'];
    idPersona = json['id_persona'];
    idCampeonato = json['id_campeonato'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.idAsistente == null){
      data['id_asistente'] = this.idAsistente;
    }
    data['id_persona'] = this.idPersona;
    data['id_campeonato'] = this.idCampeonato;
    return data;
  }
}

class JugadorDTO {
  int idJugador;
  int idPersona;
  PersonaDTO personaDTO;
  int idEquipo;
  int nroCamiseta;
  EquipoDTO equipoDTO;
  bool deleteSelected;
  JugadorDTO({this.idJugador, this.idPersona, this.idEquipo, this.deleteSelected});

  JugadorDTO.fromJson(Map<String, dynamic> json) {
    idJugador = json['id_jugador'];
    idPersona = json['id_persona'];
    idEquipo = json['id_equipo'];
    nroCamiseta = json['nro_camiseta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.idJugador != null){
      data['id_jugador'] = this.idJugador;
    }

    data['id_persona'] = this.idPersona;
    data['id_equipo'] = this.idEquipo;
    data['nro_camiseta'] = this.nroCamiseta;
    return data;
  }
}

class JugadorPlantelDTO {
  int idJugador;
  String nombre;
  String apellido;
  int nroCamiseta;

  JugadorPlantelDTO({this.idJugador, this.nombre, this.apellido, this.nroCamiseta});

  JugadorPlantelDTO.fromJson(Map<String, dynamic> json) {
    idJugador = json['id_jugador'];
    nombre = json['nombre'];
    apellido = json['apellido'];
    nroCamiseta = json['nro_camiseta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.idJugador != null){
      data['id_jugador'] = this.idJugador;
    }

    data['nombre'] = this.nombre;
    data['apellido'] = this.apellido;
    data['nro_camiseta'] = this.nroCamiseta;
    return data;
  }
}

class NotificacionDTO {
  int idNotificacion;
  String titulo;
  String texto;
  int idGrupo;
  AppGruposDTO appGruposDTO;

  NotificacionDTO({this.idNotificacion, this.titulo, this.texto});

  NotificacionDTO.fromJson(Map<String, dynamic> json) {
    idNotificacion = json['id_notificacion'];
    titulo = json['titulo'];
    texto = json['texto'];
    idGrupo = json['id_grupo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_notificacion'] = this.idNotificacion;
    data['titulo'] = this.titulo;
    data['texto'] = this.texto;
    data['id_grupo'] = this.idGrupo;
    return data;
  }
}

class AppGruposDTO extends ItemValue{
  int idAppGrupos;
  String descripcion;

  AppGruposDTO({this.idAppGrupos, this.descripcion});

  AppGruposDTO.fromJson(Map<String, dynamic> json) {
    idAppGrupos = json['id_grupo'];
    descripcion = json['descripcion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_grupo'] = this.idAppGrupos;
    data['descripcion'] = this.descripcion;
    return data;
  }

  @override
  String toString() {
    return descripcion;
  }
}


class UserDTO extends ItemValue{
  String idUser;
  String password;
  String telefono;
  bool habilitado;

  UserDTO({
    this.idUser,
    this.password,
    this.telefono,
    this.habilitado});

  UserDTO.fromJson(Map<String, dynamic> json) {
    idUser = json['id_user'];
    password = json['password'];
    telefono = json['telefono'];
    habilitado = json['habilitado'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_user'] = this.idUser;
    data['password'] = this.password;
    data['telefono'] = this.telefono;
    data['habilitado'] = this.habilitado;
    return data;
  }

  @override
  String toString() {
    return idUser;
  }
}


class PaisDTO extends ItemValue{
  int idPais;
  String nombre;

  PaisDTO({
    this.idPais,
    this.nombre});

  PaisDTO.fromJson(Map<String, dynamic> json) {
    idPais = json['id_pais'];
    nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pais'] = this.idPais;
    data['nombre'] = this.nombre;
    return data;
  }

  @override
  String toString() {
    return nombre;
  }
}

class ProvinciaDTO extends ItemValue{
  int idProvincia;
  int idPais;
  String nombre;

  ProvinciaDTO({
    this.idProvincia,
    this.idPais,
    this.nombre});

  ProvinciaDTO.fromJson(Map<String, dynamic> json) {
    idProvincia = json['id_provincia'];
    idPais = json['id_pais'];
    nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_provincia'] = this.idProvincia;
    data['id_pais'] = this.idPais;
    data['nombre'] = this.nombre;
    return data;
  }

  @override
  String toString() {
    return nombre;
  }
}

class QueryConfiguracionSize {
  int ligas;
  int campeonatos;
  int equipos;
  int arbitros;
  int asistentes;
  int jugadores;

  QueryConfiguracionSize({
    this.ligas,
    this.campeonatos,
    this.equipos,
    this.arbitros,
    this.asistentes,
    this.jugadores
  });

  QueryConfiguracionSize.fromJson(Map<String, dynamic> json) {
    ligas = json['ligas'];
    campeonatos = json['campeonatos'];
    equipos = json['equipos'];
    arbitros = json['arbitros'];
    asistentes = json['asistentes'];
    jugadores = json['jugadores'];
  }
}

class ComentariosDTO {
  int idComentario;
  String mail;
  double puntaje;
  String comentario;

  ComentariosDTO({
    this.idComentario,
    this.mail,
    this.puntaje,
    this.comentario
  });

  ComentariosDTO.fromJson(Map<String, dynamic> json) {

    idComentario = json['idComentario'];
    mail = json['mail'];
    puntaje = json['puntaje'];
    comentario = json['comentario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.idComentario != null) {
      data['id_comentario'] = this.idComentario;
    }
    data['mail'] = this.mail;
    data['puntaje'] = this.puntaje;
    data['comentario'] = this.comentario;
    return data;
  }
}