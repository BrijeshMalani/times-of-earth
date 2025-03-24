'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "98ca45bfe05a5c2389c8efa7bfa9d631",
"assets/AssetManifest.bin.json": "4971ea33f53425aa4c995ec15f82bce0",
"assets/AssetManifest.json": "17f507366706f0c34d34de250ae017e9",
"assets/assets/animation/splash_animation.json": "1fa141c4b9c9c3ffd45212f5fc342ba8",
"assets/assets/fonts/PoetsenOne-Regular.ttf": "e7f249e71a563eed9c495835657eb9c2",
"assets/assets/images/add_money.png": "baf08e417f115b62ecf3b1bed5999583",
"assets/assets/images/add_money_bg.png": "c79abd52142229013d87c353daaf1a9d",
"assets/assets/images/background.png": "010782987d359b638e07e577e76b7c7e",
"assets/assets/images/biglose.png": "5b983ea62aed749acd1d09d20aeb5c6c",
"assets/assets/images/bigWin.png": "4ba221ff3f94f41d10ba2d966ef146b3",
"assets/assets/images/dice.png": "b677aa2218fc9c7ca4be379e091ae94f",
"assets/assets/images/dice1.png": "5f03cb1af2c8bcd4f7d9bb683af474ee",
"assets/assets/images/dice2.png": "30a98dd8200ffae4c457dc387e9ce8eb",
"assets/assets/images/dice3.png": "5d9852bc66cf2d912cd204a4f5f88c81",
"assets/assets/images/dice4.png": "0d0b09f9a195f05c66ecc283885985cf",
"assets/assets/images/dice5.png": "343e6c1f76804989666c5be6ea88ce35",
"assets/assets/images/dice6.png": "3ae3b586724f97ab9462cbb20b81a6d8",
"assets/assets/images/diceImage.png": "b7badfdcc898610be934413af76b3254",
"assets/assets/images/digitBG.png": "a0e21f16668e12423b1d3fcd224fa01a",
"assets/assets/images/evenButton.png": "5b54d2c74253db3b5f8f0460432c5dd1",
"assets/assets/images/evenButton1.png": "ad62cb7f544c130f742b3467ef24f975",
"assets/assets/images/icon1.png": "75f7becc0c523b16fb50216bb77ff853",
"assets/assets/images/icon2.png": "7a07fbe9005acd5ca7d6a630cad7efbe",
"assets/assets/images/icon3.png": "88ccaffa42e0d43c308cf2c7c4137aed",
"assets/assets/images/ludoBG.png": "ab66315fda4db543092236f2e0cdcbfa",
"assets/assets/images/menuIcom.png": "b592afcdfa4654ee9d7319f17e17cf4b",
"assets/assets/images/oddButton.png": "52cf39b3837cd84eb763e49b4f267399",
"assets/assets/images/oddButton1.png": "eac6573fb8158501aa987c5d5bedf2fa",
"assets/assets/images/personIcon.png": "e9d3f9ed54110a10a157db82a18257d1",
"assets/assets/images/png/background_login.png": "087e9dcddd8b2ef28d7282eaafa7d5a2",
"assets/assets/images/png/coin.png": "b50ffd78f82b1ef4fd44aa04803db60d",
"assets/assets/images/png/collect_coin.png": "d829cac202804e28703e3179879b00e7",
"assets/assets/images/png/logo.png": "38069d7a52771b59e07e0fa4101cbb08",
"assets/assets/images/png/ludo_dice.png": "a44de166f03feabd239493eafa663389",
"assets/assets/images/png/p1.png": "44fd549903899cae01dd05f3af87774c",
"assets/assets/images/png/p2.png": "8b141d98304c294971c854ac1ae7536f",
"assets/assets/images/png/p3.png": "dd2d7622611807dac6e9ebd6aebac6b0",
"assets/assets/images/png/p4.png": "11583b9a3e872947c18c7d29c891ecc0",
"assets/assets/images/png/p5.png": "6be7c6d1243f87421275588f7b9b0828",
"assets/assets/images/png/p6.png": "35f5915462d6d86aadab26cc9b75d8e1",
"assets/assets/images/png/wifi.png": "ab6e125c391ae69414cbf16cb76f9ec3",
"assets/assets/images/win.png": "af483c8082da125f63886ca21503bbe7",
"assets/assets/images/winning_balance.png": "e18c551797dd1c95570d80f978c4e958",
"assets/assets/images/with_drawal_bg.png": "c2d395b333fb96f242604ddc1378e2e1",
"assets/assets/mp3/click.mp3": "4817461a984d2f55389774fde74d6b85",
"assets/assets/mp3/collect-coin.mp3": "e557ead1a6901363a135e6fd027ef855",
"assets/assets/mp3/dicesound.mp3": "f4392cb561a813fa99cf19f94c1db5ed",
"assets/assets/mp3/loss-coin.mp3": "2551901f6a32e9e06662d0ac56e8c8cd",
"assets/assets/mp3/win-coin.mp3": "bb778b512878298f0ab648c91b9c1065",
"assets/FontManifest.json": "a9acbfb1dd3b7084b02e8fd0b26886c7",
"assets/fonts/MaterialIcons-Regular.otf": "215c398cff0477529301a429b89abd12",
"assets/NOTICES": "6c4657a00d23006edb521013873bab03",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "44267f9bdfa3cfecd83d0a795a3203f0",
"index.html": "ef913d882d51acc9a6a2577ae55cdae9",
"/": "ef913d882d51acc9a6a2577ae55cdae9",
"main.dart.js": "98e0092c9ba13b543703564bc1a4b05b",
"manifest.json": "67b4223530dac9ddc4c0dc543d63f296",
"version.json": "6576940195f66f90e92dbe45d5503831"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
