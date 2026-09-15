# BaseDeDatos-U2-Ej18-ProduccionIndustrial
Base de Datos - Unidad 2 - Ejercicio 18

Consigna

Modelar el control de producción de una planta metalúrgica: artículos finales compuestos por materias primas y componentes intermedios (BOM), órdenes de fabricación asignadas a líneas de montaje, empleados como supervisores e inspectores, e inspecciones de control de calidad.

Lógica

Una sola entidad ARTICULO para productos, componentes y materias primas. Esta es la decisión central. La tentación es crear PRODUCTO y COMPONENTE separados, pero se rompe apenas aparecen los componentes intermedios: un subconjunto soldado es componente de la carrocería y a la vez está compuesto por chapas y bulones, o sea que sería producto y componente al mismo tiempo. Con dos entidades habría que duplicarlo en las dos tablas. Con una sola entidad y el atributo tipo_articulo (final, intermedio, materia prima), la estructura soporta un BOM de cualquier profundidad sin cambios.

BOM: autorrelación N:M con articulo-componente. Un artículo se compone de muchos componentes y un mismo componente forma parte de muchos artículos, así que la autorrelación es N:M y necesita entidad intermedia. Se conecta dos veces a ARTICULO con los roles padre (el conjunto) e hijo (la pieza que lo integra). cantidad_necesaria es el atributo del vínculo: no es propiedad del bulón ni del chasis, sino de cuántos bulones lleva ese chasis. Es la misma estructura que la autorrelación de seguidores, no la de comentarios: acá los dos lados son "muchos".

ORDEN-FABRICACION vincula artículo y línea. Cada orden produce un único artículo (N:1) y se ejecuta en una única línea (N:1), mientras que un artículo puede fabricarse en muchas órdenes y una línea recibe muchas órdenes a lo largo del tiempo.

EMPLEADO con dos roles (punto 3). El empleado participa en dos relaciones distintas: supervisa hacia LINEA-MONTAJE (un supervisor a cargo de la línea) e inspecciona hacia INSPECCION (el inspector que hace el control). No son dos entidades ni un atributo "rol": son dos vínculos con significados diferentes, y de hecho la misma persona podría cumplir ambos. Si la planta necesitara controlar qué puestos puede ocupar cada uno, se agregaría una entidad ROL con una N:M empleado-rol.

INSPECCION asociada a la ORDEN, no al artículo. El control de calidad se hace sobre lo que se fabricó en una corrida concreta: la orden identifica qué artículo, en qué línea y en qué fecha, así que colgando la inspección de la orden queda determinado el lote exacto que se controló. Colgarla del artículo diría que "ese modelo fue inspeccionado" sin poder decir cuál producción. cantidad_inspeccionada permite registrar muestreos parciales, y motivo_falla queda en NULL cuando el resultado es Aprobado.

Restricciones de integridad a considerar: un artículo no puede ser componente de sí mismo, ni directa ni indirectamente (control de ciclos en el BOM, si no el cálculo de materiales entra en recursión infinita); UNIQUE sobre (Id_Articulo_padre, Id_Articulo_hijo) para no cargar dos veces el mismo componente; cantidad_necesaria mayor a cero; cantidad_inspeccionada menor o igual a la cantidad_planificada de la orden; motivo_falla obligatorio cuando el resultado es Rechazado o Rework; y una orden Cancelada no debería generar inspecciones nuevas.

Resultado
<img width="4800" height="2582" alt="BaseDeDatos-U2-Ej18-ProduccionIndustrial" src="https://github.com/user-attachments/assets/86ff6a18-ff63-4858-81a2-7b6b9f09394e" />
