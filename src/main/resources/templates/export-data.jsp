<%--
    Document   : index
    Created on : Aug 30, 2012, 5:23:17 PM
    Author     : MSANTARE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>	
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="WEB-INF/jspf/sessionmanager.jsp" %>

<!DOCTYPE html>
<html> 
    <head> 
        <title>Screening - Export</title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head> 
    <body>
        <div data-role="page" data-add-back-btn="true">
            <c:import url="WEB-INF/jspf/header.jsp">
                <c:param name="key" value="value" />
            </c:import>

            <div data-role="content">
                <form action="xlsexport.xlsx" method="post" data-ajax="false">
                    <textarea type="search" name="query" id="query">
SELECT                                                                                                                                
IF(anagrafica.cartella like "%K",false,true) AS controllo,                                                                            
anagrafica.cartella,                                                                                                                  
anagrafica.nome,                                                                                                                      
anagrafica.cognome,                                                                                                                   
anagrafica.iniziali,                                                                                                                  
anagrafica.sesso,                                                                                                                     
anagrafica.datanascita,                                                                                                               
anagrafica.luogonascita,                                                                                                              
anagrafica.nazionenascita,                                                                                                            
anagrafica.peso,                                                                                                                      
anagrafica.altezza,                                                                                                                   
anagrafica.bmi,                                                                                                                       
anagrafica.fumo,                                                                                                                      
anagrafica.alcohol,
esami.dataesame,
colonscopia.stadio,
colonscopia.tnm,
CONCAT(
	IF(sedecancro_cieco,"Cieco ",""),
	IF(sedecancro_ascendente,"Ascendente ",""),
	IF(sedecancro_flessuraepatica,"Flessura Epatica ",""),
	IF(sedecancro_trasverso,"Trasverso ",""),
	IF(sedecancro_flessurasplenica,"Flessura Splenica ",""),
	IF(sedecancro_sigma,"Sigma ",""),
	IF(sedecancro_retto,"Retto ",""),
	IF(sedecancro_discendente,"Discendente","")) as sede,
IF(COUNT(IF(patologiec.tipo = "Ipertensione",1,NULL))>0,true,false) AS ipertensione,
IF(COUNT(IF(patologiec.tipo = "Dislipidemie",1,NULL))>0,true,false) AS dislipidemie,
IF(COUNT(IF(patologiec.tipo = "Diabete",1,NULL))>0,true,false) AS diabete
FROM screening.anagrafica                 
LEFT OUTER JOIN esami ON esami.anagrafica_id = anagrafica.id
LEFT OUTER JOIN colonscopia ON colonscopia.esami_id = esami.id
LEFT OUTER JOIN patologiec ON patologiec.anagrafica_id = anagrafica.id                                                                       
WHERE anagrafica.cartella NOT IN(1, 3, 4, 6, 8, 9, 11, 12, 13, 14, 15, 670, 3176, 2134, 3718,"86K")  
AND esami.tipo = "csc" 
AND (esami.dataesame = (SELECT MIN(dataesame) from esami WHERE tipo = "csc" AND anagrafica_id = anagrafica.id) OR esami.dataesame = NULL)
GROUP BY anagrafica.id
                    </textarea>
                    <button type="submit" name="action" value="export">Export Data</button>
                </form>
            </div>
            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>
    </body>
</html>
