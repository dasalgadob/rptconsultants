#Script thought to be run on production environment
## Run using rails db:seed:seed_limit_degrees_on_position_types
PositionType.where(name: "apoyo administrativo").update_all(minimum_degree: 2, maximum_degree: 7)
PositionType.where(name: "asistenciales").update_all(minimum_degree: 1, maximum_degree: 5)
PositionType.where(name: "profesionales").update_all(minimum_degree: 5, maximum_degree: 8)
PositionType.where(name: "especialista").update_all(minimum_degree: 9, maximum_degree: 11)
PositionType.where(name: "supervision").update_all(minimum_degree: 5, maximum_degree: 9)
PositionType.where(name: "gerencia").update_all(minimum_degree: 9, maximum_degree: 12)
PositionType.where(name: "alta direccion").update_all(minimum_degree: 12, maximum_degree: 15)
PositionType.where(name: "primer directivo").update_all(minimum_degree: 13, maximum_degree: 18)
