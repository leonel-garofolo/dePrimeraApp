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

class CampeonatoDTO {
  int idCampeonato;
  int idLiga;
  LigaDTO ligaDTO;
  String idModelo;
  String descripcion;
  DateTime fechaInicio;
  DateTime fechaFin;

  CampeonatoDTO(
      {this.idCampeonato,
        this.idLiga,
        this.idModelo,
        this.descripcion,
        this.fechaInicio,
        this.fechaFin});

  CampeonatoDTO.fromJson(Map<String, dynamic> json) {
    idCampeonato = json['id_campeonato'];
    idLiga = json['id_liga'];
    idModelo = json['id_modelo'];
    descripcion = json['descripcion'];
    fechaInicio = DateTime.parse(json['fecha_inicio']);
    fechaFin = DateTime.parse(json['fecha_fin']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_campeonato'] = this.idCampeonato;
    data['id_liga'] = this.idLiga;
    data['id_modelo'] = this.idModelo;
    data['descripcion'] = this.descripcion;
    data['fecha_inicio'] = this.fechaInicio;
    data['fecha_fin'] = this.fechaFin;
    return data;
  }
}

class EquipoDTO {
  int idEquipo;
  int idLiga;
  LigaDTO ligaDTO;
  bool habilitado;
  String nombre;
  Null foto;

  EquipoDTO(
      {this.idEquipo, this.idLiga, this.foto, this.habilitado, this.nombre});

  EquipoDTO.fromJson(Map<String, dynamic> json) {
    foto = json['foto'];
    habilitado = json['habilitado'];
    idEquipo = json['id_equipo'];
    idLiga = json['id_liga'];
    nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foto'] = this.foto;
    data['habilitado'] = this.habilitado;
    data['id_equipo'] = this.idEquipo;
    data['id_liga'] = this.idLiga;
    data['nombre'] = this.nombre;
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
        this.suspendido});

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
    suspendido = json['suspendido'];
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

class PersonaDTO {
  int idPersona;

  String apellidoNombre;
  String domicilio;
  int edad;
  int idLiga;
  int idLocalidad;
  int idPais;
  int idProvincia;
  int idTipoDoc;
  int nroDoc;

  PersonaDTO(
      {this.idPersona,
        this.apellidoNombre,
        this.domicilio,
        this.edad,
        this.idLiga,
        this.idLocalidad,
        this.idPais,
        this.idProvincia,
        this.idTipoDoc,
        this.nroDoc});

  PersonaDTO.fromJson(Map<String, dynamic> json) {
    apellidoNombre = json['apellido_nombre'];
    domicilio = json['domicilio'];
    edad = json['edad'];
    idLiga = json['id_liga'];
    idLocalidad = json['id_localidad'];
    idPais = json['id_pais'];
    idPersona = json['id_persona'];
    idProvincia = json['id_provincia'];
    idTipoDoc = json['id_tipo_doc'];
    nroDoc = json['nro_doc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apellido_nombre'] = this.apellidoNombre;
    data['domicilio'] = this.domicilio;
    data['edad'] = this.edad;
    data['id_liga'] = this.idLiga;
    data['id_localidad'] = this.idLocalidad;
    data['id_pais'] = this.idPais;
    data['id_persona'] = this.idPersona;
    data['id_provincia'] = this.idProvincia;
    data['id_tipo_doc'] = this.idTipoDoc;
    data['nro_doc'] = this.nroDoc;
    return data;
  }
}

class ArbitroDTO {
  int idArbitro;
  int idPersona;

  ArbitroDTO({this.idArbitro, this.idPersona});

  ArbitroDTO.fromJson(Map<String, dynamic> json) {
    idArbitro = json['id_arbitro'];
    idPersona = json['id_persona'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_arbitro'] = this.idArbitro;
    data['id_persona'] = this.idPersona;
    return data;
  }
}

class AsistenteDTO {
  int idAsistente;
  int idPersona;

  AsistenteDTO({this.idAsistente, this.idPersona});

  AsistenteDTO.fromJson(Map<String, dynamic> json) {
    idAsistente = json['id_asistente'];
    idPersona = json['id_persona'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_asistente'] = this.idAsistente;
    data['id_persona'] = this.idPersona;
    return data;
  }
}


