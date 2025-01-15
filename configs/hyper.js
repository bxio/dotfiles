// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    // choose either `'stable'` for receiving highly polished,
    // or `'canary'` for less polished but more frequent updates
    updateChannel: 'stable',

    // default font size in pixels for all tabs
    fontSize: 16,

    // font family with optional fallbacks
    fontFamily: '"Fira Code", "Roboto Mono for Powerline", "Meslo LG L DZ for Powerline", "Source Code Pro for Powerline", Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
    // default font weight: 'normal' or 'bold'
    fontWeight: 'normal',

    // font weight for bold characters: 'normal' or 'bold'
    fontWeightBold: 'bold',

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: '#2C85F7',

    // terminal text color under BLOCK cursor
    cursorAccentColor: '#000',

    // `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for █
    cursorShape: 'BLOCK',

    // set to `true` (without backticks and without quotes) for blinking cursor
    cursorBlink: true,

    // color of the text
    foregroundColor: '#CDD2E9',

    // terminal background color
    // opacity is only supported on macOS
    backgroundColor: 'rgba(41, 51, 64, 1)',

    // terminal selection color
    // selectionColor: 'rgba(248,28,229,0.3)',
    selectionColor: 'rgba(145, 152, 162,0.3)',

    // border color (window, tabs)
    borderColor: '#333',

    colors: {
      black: '#293340',
      red: '#E17E85',
      green: '#61BA86',
      yellow: '#FFEC8E',
      blue: '#4CB2FF',
      magenta: '#BE86E3',
      cyan: '#2DCED0',
      white: '#CDD2E9',
      lightBlack: '#546386',
      lightRed: '#E17E85',
      lightGreen: '#61BA86',
      lightYellow: '#FFB68E',
      lightBlue: '#4CB2FF',
      lightMagenta: '#BE86E3',
      lightCyan: '#2DCED0',
      lightWhite: '#CDD2E9'
    },


    // custom CSS to embed in the main window
    css: '',

    // custom CSS to embed in the terminal window
    termCSS: '',

    // if you're using a Linux setup which show native menus, set to false
    // default: `true` on Linux, `true` on Windows, ignored on macOS
    showHamburgerMenu: '',

    // set to `false` (without backticks and without quotes) if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` (without backticks and without quotes) on Windows and Linux, ignored on macOS
    showWindowControls: '',

    // custom padding (CSS format, i.e.: `top right bottom left`)
    padding: '12px 14px',

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object


    hyperCustomTouchbar: [{
        label: 'git',
        options: [{
            label: 'diff',
            backgroundColor: '#4a846a',
            command: 'git diff'
          },
          {
            label: 'mergesquash',
            backgroundColor: "#5198D5",
            command: 'git merge --squash HEAD@{1}',
            prompt: true
          },
          {
            label: 'log',
            backgroundColor: "#51D58F",
            command: 'git log'
          },
          {
            label: 'remote',
            command: 'git remote -v'
          },
          {
            label: 'bx',
            backgroundColor: '#37adff',
            command: 'git config user.name bxio && git config user.email billxiong99@gmail.com',
            prompt: true
          },
          {
            label: 'vld',
            backgroundColor: '#d13232',
            command: 'git config user.name verylongdelay && git config user.email verylongdelay@gmail.com',
            prompt: true
          },
        ]
      },
      {
        label: '💻vim',
        options: [{
            label: 'quit',
            command: ':q!',
            esc: true
          },
          {
            label: 'save & quit',
            command: ':x',
            esc: true
          },
          {
            label: 'date',
            command: ':r !date',
            esc: true
          },
        ]
      },

      {
        label: '🐳Docker',
        options: [{
            label: 'clean',
            // backgroundColor: '#37adff',
            command: 'echo "y" | docker system prune',
            prompt: true
          },
          {
            label: 'dangling',
            backgroundColor: '#37adff',
            command: 'docker rmi -f $(docker images --quiet --filter "dangling=true")',
            esc: true
          },
          {
            label: 'killall',
            backgroundColor: '#d13232',
            command: 'docker stop $(docker ps -a -q)',
            prompt: true,
            esc: true
          },
          {
            label: 'dev',
            command: 'docker build --file Devfile -t bxio/ho:test . && docker run -it --env-file env_list_dev bxio/ho:test',
            esc: true
          },
          {
            label: 'h-dev',
            command: 'docker build --file Devfile -t bxio/ho:test . && docker run -it --env-file env_list_production bxio/ho:test',
            esc: true
          },
          {
            label: 'h-prod',
            command: 'docker build -t bxio/ho:test . && docker run -it --env-file env_list_production bxio/ho:test',
            esc: true
          },
          {
            label: 'h-up',
            command: 'docker build -t bxio/ho:web . && docker tag bxio/ho:web gcr.io/harmedore/ho:web && docker push gcr.io/harmedore/ho:web && docker push bxio/ho:web',
            esc: true
          }, {
            label: 'h-con',
            command: 'gcloud compute --project "harmedore" ssh --zone "us-west1-b" "ho"',
            esc: true
          }
        ]
      },

      {
        label: 'fn()',
        options: [
          {
            label: 'gs',
            backgroundColor: '#37adff',
            command: 'gsutil du -sh gs://artifacts.harmedore.appspot.com gs://harmedore.appspot.com gs://hobackup gs://staging.harmedore.appspot.com gs://us.artifacts.harmedore.appspot.com'
          },
          {
            label: 'dig',
            backgroundColor: '#5CC390',
            command: 'dig +nostats +nocomments +nocmd ',
            prompt: true,
            esc: true
          },
          {
            label: 'afk',
            backgroundColor: '#8264A2',
            command: '/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
          },
          {
            label: 'sha256',
            backgroundColor: '#37adff',
            command: 'shasum - a 256'
          },
          {
            label: 'viragofit',
            backgroundColor: '#37adff',
            command: 'doctl compute ssh viragofit-ols'
          },
          {
            label: 'aws',
            backgroundColor: '#37adff',
            command: 'ssh -i ~/.ssh/aws_ec2.pem ec2-user@ec2-18-222-191-98.us-east-2.compute.amazonaws.com'
          }
        ]
      },
    ],

    hyperTabs: {
      tabIcosnsColored: true,
      activityPulse: false,
      activityColor: 'salmon',
    },

    hypercwd: {
      initialWorkingDirectory: '~/Developer'
    },

    hypernpm: {
      // wil run `npm run lint`
      1: "lint",
      // will run `npm test` since it's a native npm command
      5: "test"
    },


    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    //
    // Windows
    // - Make sure to use a full path if the binary name doesn't work
    // - Remove `--login` in shellArgs
    //
    // Bash on Windows
    // - Example: `C:\\Windows\\System32\\bash.exe`
    //
    // PowerShell on Windows
    // - Example: `C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe`
    shell: '',

    // for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
    // by default `['--login']` will be used
    shellArgs: ['--login'],

    // for environment variables
    env: {},

    // set to `false` for no bell
    bell: 'SOUND',

    copyOnSelect: false,

    defaultSSHApp: true,

    // if `true` (without backticks and without quotes), on right click selected text will be copied or pasted if no
    // selection is present (`true` by default on Windows and disables the context menu feature)
    // quickEdit: true,

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // for advanced config flags please refer to https://hyper.is/#cfg
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: ["hyper-custom-touchbar",
    "hyper-tabs-enhanced",
    "hyper-statusline",
    "hyperalfred",
    "hypercwd",
    "hyper-sync-settings",
    "hyperterm-cursor",
    "hyper-simple-highlight-active-session",
    "hypernpm",
  ],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [],

  keymaps: {
    // Example
    // 'window:devtools': 'cmd+alt+o',
  },
};
