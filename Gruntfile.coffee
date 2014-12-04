module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    coffee:
      compileWithMaps:
        options:
          # sourceMap: true
          join: true
        expand: true
        cwd: 'lib/'
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
        files: 'lib/*.coffee'
        tasks: ['coffee']

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  # Default task.
  grunt.registerTask 'default', ['coffee', 'watch']
