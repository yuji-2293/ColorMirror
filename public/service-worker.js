self.addEventListener("install", function(event) {
    console.log("Service worker installed.");
    event.waitUntil(
      caches.open("v1").then(function(cache) {
        return cache.addAll([
          "/",
          "/manifest.json",
          "/icon_192x192.png",
          "/icon_512x512.png"
        ]);
      })
    );
  });

  self.addEventListener("fetch", function(event) {
    event.respondWith(
      caches.match(event.request).then(function(response) {
        return response || fetch(event.request);
      })
    );
  });
