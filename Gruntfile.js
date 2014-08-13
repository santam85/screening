module.exports = function(grunt) {

    grunt.initConfig({
        bower: {
            target: {
                rjsConfig: 'src/main/resources/static/js/main.js',
                exclude: ["requirejs"]
            }
        },
        wiredep: {
            dev: {
                // Point to the files that should be updated when
                // you run `grunt wiredep`
                src: [
                    'src/main/resources/templates/*.html'   // .html support...
                ],
                ignorePath:'../static/',
                // Optional:
                // ---------
                dependencies: true,
                devDependencies: false,
                exclude: ["jquery-ui","jquery-ui-tabs","jquery-hashchange"]
            }
        }
    });

    grunt.loadNpmTasks('grunt-bower-requirejs');
    grunt.loadNpmTasks('grunt-wiredep');

    grunt.registerTask('default', ['bower']);
}