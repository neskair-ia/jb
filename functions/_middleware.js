export async function onRequest(context) {
  const url = new URL(context.request.url);
  
  // Si el usuario accede por el subdominio viejo de pages.dev,
  // lo redirigimos automáticamente (301 Permanente) al dominio oficial.
  // Esto previene contenido duplicado en Google y mejora el SEO.
  if (url.hostname === "jb-ingenieria-corporativa.pages.dev") {
    url.hostname = "jbingenieriacorporativa.com";
    return Response.redirect(url.toString(), 301);
  }
  
  // Para cualquier otro caso (el dominio oficial, localhost, etc), 
  // seguimos procesando la petición normalmente.
  return context.next();
}
