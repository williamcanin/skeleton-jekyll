# Skeleton Jekyll

Simple in appearance, and powerful in management.
Create Jekyll layout with this full-featured skeleton.

[ MINIMUM REQUIREMENTS ]

- Git
- Ruby

[ FEATURE ]

- Category and Tag posts. Use plugin: https://github.com/jekyll/jekyll-archives
- Gulp tasks
- BrowserSync, for follow-up of change.
- Create header for posts, pages, and projects (Using Ruby code).
- Dependency installer with just one command.

[ USAGE ]

1 - Clone and Enter folder:

shell> git clone https://github.com/williamcanin/skeleton-jekyll.git
shell> cd skeleton-jekyll

2 - Install

shell> rake install

3 - Start server:

shell> rake serve

4 - Build for deploy:

shell> rake build

Note: Change configuration in file: 'config/config.json'.

-----------------------------------------------
For more commands, access the 'help' command:

shell> rake help
-----------------------------------------------

[ CONFIGURATION ]

The configuration for your project will be in the '_data/data.yml' file, where you have to edit the values.

The '_config.yml' file also has some settings you want to make.

To change the url to your website, you have to do it in the 'url.json' file, since the 'url' and 'baseurl' variables in the '_config.yml' file will be filled automatically through the file 'url.json'.

[ LICENSE ]

MIT License (MIT)
https://opensource.org/licenses/MIT


© Skeleton Jekyll. William C. Canin. All rights reserved. ®
