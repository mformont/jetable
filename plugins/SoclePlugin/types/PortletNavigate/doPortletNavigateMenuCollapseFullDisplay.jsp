<%@ page contentType="text/html; charset=UTF-8"%><%
%><%@ page import="fr.cg44.plugin.socle.SocleUtils"%><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%
%><%@ include file='/jcore/doInitPage.jspf'%><%
%><%@ include file='/jcore/portal/doPortletParams.jspf'%><%
%><%@ include file='/types/PortletNavigate/doInitPortletNavigate.jspf'%><%
%>
<%-- SGU
    Menu de navigation déroulant (collapse)
    Affiche systématiquement 2 niveaux (le 1er niveau sous forme de titre, et le 2è sous forme de "collapser"),
    puis boucle récursivement jusqu'à afficher le nombre max de niveaux paramétré dans la portlet.
 --%><%

if (((rootCategory == null) || (rootCategory.isLeaf())) && box.getHideWhenNoResults()){
    request.setAttribute("ShowPortalElement",Boolean.FALSE);
  return;
}

// Tri et filtre sur les catégories autorisées
TreeSet<Category> rootSet = SocleUtils.getOrderedAuthorizedChildrenSet(rootCategory);

int maxLevels = box.getLevels();
%>
<jalios:foreach collection="<%= rootSet %>" type="Category"	name="itCatLevel1"><%
%><h2 class="h3-like"><%=itCatLevel1%></h2><%
TreeSet<Category> level1CatSet = SocleUtils.getOrderedAuthorizedChildrenSet(itCatLevel1);
%><ul class="ds44-collapser"><%
    %><jalios:foreach collection="<%= level1CatSet %>" type="Category" name="itCatLevel2"><%
	%> <li class="ds44-collapser_element"><%
	%><%
	%><%-- On regarde si la catégorie contient des catégries filles autorisées : si oui génération des enfants, si non lien direct --%><%
	TreeSet<Category> level3CatSet = SocleUtils.getOrderedAuthorizedChildrenSet(itCatLevel2);
		    if(Util.notEmpty(level3CatSet)){%>
		      <c:set var="itCategory" value="<%=itCatLevel2%>" scope="request"/>
		      <c:set var="maxLevels" value="<%=maxLevels%>" scope="request"/>
		      <ds:toggle title="<%=itCatLevel2.getName() %>">
		          <ds:categoryList rootCat="${itCategory}" maxLevels="${maxLevels}" currentLevel="0" />
		      </ds:toggle><%
		    }else{%>
		    	<jalios:link data="<%=itCatLevel2%>" css="ds44-collapser_content--buttonLike"><%=itCatLevel2.getName()%></jalios:link>
		    <%}%>
        </li><%
	%></jalios:foreach><%
%></ul><%
%></jalios:foreach>