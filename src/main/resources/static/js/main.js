require.config({
  shim: {

  },
  paths: {
    jquery: "../vendor/jquery/dist/jquery",
    requirejs: "../vendor/requirejs/require",
    "jquery-mobile-bower": "../vendor/jquery-mobile-bower/js/jquery.mobile-1.4.5"
  },
  packages: [

  ]
});

require(["jquery-mobile-bower"],function(){
   console.info("App loaded.");
});
