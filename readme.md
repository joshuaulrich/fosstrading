Notes to future me:

* I'm using the [mainroad](https://github.com/vimux/mainroad) theme. Make sure the repo has been cloned into this repo because it's not a submodule. You can do that via `git clone https://github.com/vimux/mainroad.git themes/mainroad` from this repo's root directory.

* I could not get the install via `snap install hugo` to work on Ubuntu 20.04. A call to `hugo` threw the error: `Error: open /var/lib/snapd/void: permission denied`. Setting `--devmode` and `--classic` didn't work. So I installed via `apt` instead.

* Posts go in `content/post/`. They can be a `*.md` file in that folder, or they can be in separate sub-folders that contain a `index.md` file.

* Build the site by calling `hugo`. `hugo -D` builds draft posts too. `hugo server` runs a local web server.

* The built site in stored in the `docs/` folder. Commit and push those files to publish the site.
