module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    express:
      server:
        options:
          port: 8080
          bases: './'

    coffee:
      compileWithMaps:
        options:
          # sourceMap: true
          join: true
        expand: true
        cwd: 'src/'
        src: ['*.coffee']
        dest: './'
        ext: '.js'
        # files:
        #   'index.js' : ['lib/*.coffee']

        # cwd: 'src'
        # src: ['**/*.coffee']
        # dest: 'lib'
        # ext: '.js'
    watch:
      app:
        files: 'src/*.coffee'
        tasks: ['coffee']
        options:
          livereload: true
          port: 8080

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-express'
  # Default task.
  grunt.registerTask 'default', ['coffee', 'express', 'watch']
