'use strict';
var yeoman = require('yeoman-generator');
var chalk = require('chalk');
var yosay = require('yosay');

module.exports = yeoman.generators.Base.extend({
  initializing: function () {
    this.pkg = require('../package.json');
  },

  prompting: function () {
    var done = this.async();

    // Have Yeoman greet the user.
    this.log(yosay(
      'Welcome to the supreme' + chalk.red('ThreejsGulp') + ' generator!'
    ));

    var prompts = [{
      type: 'confirm',
      name: 'someOption',
      message: 'Would you like to enable this option?',
      default: true
    }];

    this.prompt(prompts, function (props) {
      this.someOption = props.someOption;

      done();
    }.bind(this));
  },

  writing: {
    app: function () {
      this.fs.copy(
        this.templatePath('_package.json'),
        this.destinationPath('package.json')
      );
      this.fs.copy(
        this.templatePath('_bower.json'),
        this.destinationPath('bower.json')
      );
    },

    projectfiles: function () {
      this.mkdir('public');
      this.mkdir('src/jade');
      this.mkdir('src/jade/include');
      this.mkdir('src/jade/spec');
      this.mkdir('src/stylus');
      this.mkdir('src/coffee');
      this.mkdir('src/spec');

      this.fs.copy(
        this.templatePath('editorconfig'),
        this.destinationPath('.editorconfig')
      );
      this.fs.copy(
        this.templatePath('jshintrc'),
        this.destinationPath('.jshintrc')
      );

      this.copy(
        this.templatePath('_gulpfile.coffee'),
        this.destinationPath('gulpfile.coffee')
      );
      this.copy(
        this.templatePath('_karma.conf.js'),
        this.destinationPath('karma.conf.js')
      );
      // jade
      this.copy(
        this.templatePath('jade/fixture.jade'),
        this.destinationPath('src/jade/spec/fixture.jade')
      );
      this.copy(
        this.templatePath('jade/index.jade'),
        this.destinationPath('src/jade/index.jade')
      );
      // stylus
      this.copy(
        this.templatePath('stylus/style.styl'),
        this.destinationPath('src/stylus/style.styl')
      );
      this.copy(
        this.templatePath('stylus/_function.styl'),
        this.destinationPath('src/stylus/_function.styl')
      );
      this.copy(
        this.templatePath('stylus/_mixin.styl'),
        this.destinationPath('src/stylus/_mixin.styl')
      );
      // spec
      this.copy(
        this.templatePath('spec/script-spec.coffee'),
        this.destinationPath('src/spec/script-spec.coffee')
      );
      // coffee
      this.copy(
        this.templatePath('coffee/camera.coffee'),
        this.destinationPath('src/coffee/camera.coffee')
      );
      this.copy(
        this.templatePath('coffee/light.coffee'),
        this.destinationPath('src/coffee/light.coffee')
      );
      this.copy(
        this.templatePath('coffee/main.coffee'),
        this.destinationPath('src/coffee/main.coffee')
      );
      this.copy(
        this.templatePath('coffee/object.coffee'),
        this.destinationPath('src/coffee/object.coffee')
      );
      this.copy(
        this.templatePath('coffee/scene.coffee'),
        this.destinationPath('src/coffee/scene.coffee')
      );
    }
  },

  install: function () {
    this.installDependencies({
      skipInstall: this.options['skip-install']
    });
  }
});
