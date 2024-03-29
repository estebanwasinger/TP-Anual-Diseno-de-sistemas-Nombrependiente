<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="main" />
	<style>
.bs-docs-header {
background-color: #292929;
padding: 30px;
}
</style>
</head>
<body>

<g:render template="menuSuperior" model="['nombre': 'Seguidor de Carrera']"/>
<div style="width: 90%; padding: 15pt;">
		
		<g:if test="${flash.message}">
			<div class="alert alert-info">
				${flash.message}
			</div>
		</g:if>		
		
			<br>
			<div class="panel-group" id="accordion2">
				<div class="panel panel-default">
					<div class="panel-heading">
						<a class="accordion-toggle" data-toggle="collapse"
							data-parent="#accordion2" href="#collapseTwo">Resultados: ${materiaInstanceTotal } 
						</a>
					</div>
					<div id="collapseTwo" class="panel-collapse collapse in">
						<div class="panel-body">
							<div id="list-libro" class="content scaffold-list">
								<table class="table table-striped table-bordered table-hover table-condensed">
									<thead>
										<g:sortableColumn property="nombre" title="Nombre" />
										<g:sortableColumn property="profesor" title="Profesor"/>
										<g:sortableColumn property="ubicacion" title="Ubicaci&oacute;n"/>
										<g:sortableColumn property="anioCursada" title="A&ntilde;o de Cursada" />
										<g:sortableColumn property="finalAprobado" title="Final Aprobado" />
									</thead>
									<tbody>
										<g:each in="${materiaInstanceList}" status="i"
											var="materiaInstance">
											<tr class="${(i % 2) == 0 ? 'info' : ''}">
												<td><g:link action="show" id="${materiaInstance.id}">
														${materiaInstance.nombre}
													</g:link></td>
												<td>
													${materiaInstance.profesor}
												</td>
												<td>
													${materiaInstance.ubicacion}
												</td>
												<td>
													${materiaInstance.anioCursada}
												</td>
												<td>
													${(materiaInstance.finalAprobado == true) ? 'Si':'No'}
												</td>
											</tr>
										</g:each>
									</tbody>
								</table>
							</div>
						</div>
					</div>							
				</div>
			</div>
		</div>
</body>
</html>
