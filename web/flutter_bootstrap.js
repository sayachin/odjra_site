// Custom Flutter web bootstrap.
//
// A server-rendered landing page (index.html) is shown to users and search
// engine crawlers before Flutter initializes. This script starts the Flutter
// app and then removes that landing page once the app has taken over.
//
// Docs: https://docs.flutter.dev/platform-integration/web/initialization
{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  onEntrypointLoaded: async function (engineInitializer) {
    // Initialize the Flutter engine and run the app.
    const appRunner = await engineInitializer.initializeEngine();
    await appRunner.runApp();

    // Fade out and remove the pre-rendered landing page so it doesn't remain
    // in the DOM behind the Flutter canvas (duplicate content).
    const prerender = document.getElementById('prerender');
    if (prerender) {
      prerender.classList.add('prerender--hidden');
      window.setTimeout(function () {
        prerender.remove();
      }, 500);
    }
  },
});
