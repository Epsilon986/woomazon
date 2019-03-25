<%@ page pageEncoding="UTF-8"%>
<%@ include file="enTetePage.html"%>
<%@ page import="commerce.catalogue.service.CatalogueManager"%>
<%@ page import="commerce.catalogue.domaine.modele.Article"%>
<%@ page import="commerce.catalogue.domaine.modele.Livre"%>
<%@ page import="commerce.catalogue.domaine.modele.Musique"%>
<%@ page import="commerce.catalogue.domaine.modele.Piste"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%
	if (session.getAttribute("panier")==null) {
		response.sendRedirect("./index.jsp");
	} else {
		CatalogueManager catalogueManager = (CatalogueManager) application
									.getAttribute("catalogueManager");
		List<Article> articles = catalogueManager.getArticles();
		Iterator<Article> listeDesArticles ;
		Livre livre = null;
		Musique musique = null;
		Article article;
%>
<nav id="navigation" class="col-full" role="navigation">
	<ul id="main-nav" class="nav fl">
		<li id="menu-item-290"
			class="menu-item menu-item-type-custom menu-item-object-custom current-menu-item">
			<a href="<%=response.encodeURL("./afficheRecherche.jsp")%>">Rechercher
				un article</a>
		</li>
		<li id="menu-item-290"
			class="menu-item menu-item-type-custom menu-item-object-custom">
			<a href="<%=response.encodeURL("./controlePanier.jsp")%>">Panier</a>
		</li>
	</ul>
</nav>
<div id="content" class="site-content" tabindex="-1">
	<div class="col-full">
		<div class="primary" class="content-area">
			<section id="main" class="site-main" role="main">
				<h1 class="page-title">Résultats de la recherche</h1>
				<ul class="products">
					<%
							listeDesArticles = articles.iterator() ;
							while (listeDesArticles.hasNext()) {
								article = (Article) listeDesArticles.next();
					%>
					<li class="product type-product"><a
						href="<%=response.encodeURL("./controlePanier.jsp?refArticle="
								+ article.getRefArticle()
						+ "&amp;commande=ajouterLigne")%>"> <img
							src="<% if (article.getImage().startsWith("http")) 
									    out.print(article.getImage()) ;
							        else
							        	out.print("./images/"+article.getImage()) ; %>"
							class="attachment-shop_catalog wp-post-image" alt="poster_2_up"
							height="300" width="300"/>
							<h3><%=article.getTitre()%></h3> <span class="price"><ins>
									<span class="amount"><%=article.getPrix()%> €</span>
								</ins></span>

					</a> <a
						href="<%=response.encodeURL("./controlePanier.jsp?refArticle="
								+ article.getRefArticle()
						+ "&amp;commande=ajouterLigne")%>"
						class="button add_to_cart_button product_type_simple">Mettre
							dans le panier</a>
<%
                            	if (article instanceof Musique) { 
                            		musique = (Musique) article;
                            		if (musique.getPistes().size() > 0) {
%>
						<div id="jquery_jplayer_<%=article.getRefArticle()%>" class="jp-jplayer"></div>
						<div id="jp_container_<%=article.getRefArticle()%>" class="jp-audio" role="application">
							<div class="jp-type-playlist">
								<div class="jp-gui jp-interface">
									<div class="jp-controls-holder">
										<div class="jp-controls">
											<button class="jp-previous" role="button" tabindex="0">previous</button>
											<button class="jp-play" role="button" tabindex="0">play</button>
											<button class="jp-stop" role="button" tabindex="0">stop</button>
											<button class="jp-next" role="button" tabindex="0">next</button>
										</div>
									</div>
								</div>
								<div class="jp-playlist">
									<ul>
										<li>&nbsp;</li>
									</ul>
								</div>
								<div class="jp-no-solution">
									<span>Update Required</span> To play the media you will need to
									either update your browser to a recent version or update your <a
										href="http://get.adobe.com/flashplayer/" target="_blank">Flash
										plugin</a>.
								</div>
							</div>
						</div> 
<%
                            		}
                            	}
							}
 %>
				</ul>
			</section>
		</div>
	</div>
</div>
<script type="text/javascript">
window.addEventListener("load", myFunction, false);
function myFunction(event) {
<%
		listeDesArticles = articles.iterator() ;
		while (listeDesArticles.hasNext()) {
			article = (Article) listeDesArticles.next();
			if (article instanceof Musique) {
%>
	var myPlaylist_<%=article.getRefArticle()%> = new jPlayerPlaylist({
	cssSelectorAncestor : "#jp_container_<%=article.getRefArticle()%>",
	jPlayer: "#jquery_jplayer_<%=article.getRefArticle()%>"}, [<%
	musique = (Musique) article;
				if (musique.getPistes().size() > 0) {
					Iterator<Piste> itPistes = musique.getPistes()
							.iterator();
					Piste unePiste;
					while (itPistes.hasNext()) {
						unePiste = itPistes.next();
%>
{ title:"<%=unePiste.getTitre().replace("\"", "\\\"" )%>", mp3:"<%=unePiste.getUrl()%>" },<%

					}
				}
%>
], { swfPath : "/js/jplayer-2.9.2/jplayer", supplied : "mp3", wmode:
"window", useStateClassSkin: true, autoBlur: false, smoothPlayBar: true,
keyEnabled: true });
<%

			}
		}
%>
	var jp_playlist_tab = document.getElementsByClassName("jp-playlist") ;
 	for (i = 0; i < jp_playlist_tab.length; i++) {
    	jp_playlist_tab[i].style.display = "none";
	} 
}
</script>
<%
	}
%>
<%@ include file="piedDePage.html"%>