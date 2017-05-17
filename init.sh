#!/bin/bash
#
# Type: Script Shell Installer
# Description: Script Management.
#
#
# Supported: Unix Linux
# Release State: 1.0.0
# Script Name: init.sh

# Author: William C. Canin
#   E-Mail: william.costa.canin@gmail.com
#   Home page: https://williamcanin.com

# License:
# The MIT License (MIT)

# Copyright (c) 2017 William C. Canin <william.costa.canin@gmail.com>

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# ******************************************************************************
#
# Note: Not use with root.
# Usage: bash ghoost help
#

# Import libs
source "./lib/shell/global/functions/utils.lib"

# Verify OS
function _os_check(){
  if [[ "$(uname)" != "Linux" ]]; then
    msg_error "The operating system is not Linux."
    msg_warning "Aborted."
    exit 1
  fi
}
_os_check

# Function to create header files
function _create_file(){
    if [[ ! -f "$(ls _vendor/bundle/ruby/*/bin/rake)" ]]; then

      msg_warning "You need Rake to continue. Install the project dependencies first."
      msg_warning "Command: $0 install"
      exit 1

    else

      msg_header "Creating new header \"$1\""
      msg_header "Add TITLE:"
      read -p "> " title_

      if [[ -z "${title_}" ]]; then
        msg_error "The TITLE variable is required! Try again."
        exit 1
      fi

      if [[ $2 == true ]]; then
        msg_header "Add ${3^^}:"
        read -p "> " parameter_

        if [[ -z "${3}_" ]]; then
          msg_error "The LAYOUT variable is required! Try again."
          exit 1
        fi

        bundle exec rake ${4}:${5} TITLE="${title_}"  ${3^^}="${parameter_}"
      else
        bundle exec rake ${4}:${5} TITLE="${title_}"
      fi

    fi
}

# Function verify Gulp local
function _verify_gulp(){
   if [[ ! -f "$(npm bin)/gulp" ]]; then
    msg_error "Gulp is not installed locally. Use the command: \"bash $0 install\". Approached!"
    exit 1
   fi
}

# Menu
case $1 in
  install )
    gem install bundle
    bundle install
    msg_finish "Done!"
  ;;
  serve )
    _verify_gulp
    $(npm bin)/gulp serve
    msg_finish "Done!"
    ;;
  build )
    _verify_gulp
    $(npm bin)/gulp build
    msg_finish "Done!"
    ;;
  post:blog)
    _create_file "BLOG Post" true  "category" "post" "blog"
    ;;
  page:create)
    _create_file "PAGE" true  "layout" "page" "create"
    ;;
  post:project)
    _create_file "PROJECTS" false nil "post" "project"
    ;;
  reset)
    msg_header "Primitive mode!"
    msg_header "This will clear your entire project, and leave it as factory-mode."
    msg_warning "By accepting this operation, it will remove the contents of the following directories and files:"
    msg_header "Folders:"
    printf " _vendor \n node_modules \n _site/* \n assets/js \n assets/css \n"
    msg_header "Files:"
    printf " Gemfile.lock \n\n"
    msg_header "Do you want to continue the operation? (y/n)"
    read -p "> " reply_
    case $reply_ in
      y|Y)
        msg_header "Clearing compiled project. Wait ..."
        rm -rf "Gemfile.lock"
        rm -rf "node_modules"
        rm -rf "_vendor"
        rm -rf "_site/*"
        rm -rf "assets/js"
        rm -rf "assets/css"
        msg_finish "Done!"
      ;;
      n|N)
        msg_warning "Operation canceled by user."
        exit 0
        exit 1
      ;;
      *)
        msg_error "Invalid option! Approached!"
        exit 1
      ;;
    esac
  ;;
  *|help)
     msg_warning "Usage: $0 { install | build | serve | post:blog | page:create | post:project | reset }"
  ;;
esac
