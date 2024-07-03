# Playing with Devcontainers

**CAVEAT**: Avoid using _Open Folder in Container..._.
Especially on Windows OS, at least for now, it slows down performance.  Perhaps due to filesystem communication across
the system boundary from the native environment over to the WSL which is the environment that the container lives in.


## Clone in Container Volume

Take a GitHub repo that already exists and clone it into the container.

1. Open VS Code - no directory, just a new window.
1. Install the _Remote Development_ extension (it contains 4 extensions, including the Devcontainers extension).
1. Open the command palette and select: _Dev Containers: Clone Repository in Container Volume_ ([docs][clone-in-container]).
1. You will be prompted for the repo URL (if not logged into GitHub it will prompt you for credentials and authorization).
1. VS Code will start building the container.  Click the "Show Log" link in the dialog window in the bottom right of VS Code window.
1. You will be prompted to _Select a container configuration template_.  Search by name, scroll to pick, or click _Show All Definitions_ to see more options.  Select the _Default Linux Universal_ image - unless you have a specific need.  This is the image used for Codespaces.  See the [docs]][default-linux-universal] for details about what the image contains (it's a lot).  One downside to selecting this image is that it is large and will take a while to download.
1. You will be prompted to _Select additional features to install_.  Leave this as `0 Selected` and click `OK`. (Note: Features can be added later through the _Configure Container Features_ command.)
1. Take a break while waiting for the image to be built.
1. Open a new terminal and you should be in `/workspaces/<repo-name>` directory.  `whoami` should return `codespaces`.  `git status` will show the `.devcontainer` and `.github` directories that have been created locally, but not committed to the project yet.
1. Add and commit the new files - you may be prompted to add `git config user.name "<name>"` and `git config user.email "<email>"` before you can `git commit`.
1. Push to the remote.
1. Explore the container.  Notice the farily robust shell configuration and wide range of tools.  Notice you can modify shell configuration files; however, those changes will be lost when the image is rebuilt.  Until then, they will persist.
1. Open the `.devcontainer/devcontainer.json` configuration file.  Notice this is where the image that we selected is referenced.
1. Open the command palette and select _Dev Containers: Configure Container Features_.  Add any features that you want.  Notice how they are added to the `devcontainer.json` file under the `features` key ([docs on features][container-features]).

TODO: Install a project, like a default next.js app or something, that will demonstrate the port mapping from container to localhost and that the development server running in the container can be reached through the opened port on the host.  Make changes and demonstrate hot reload.


### Customize the Image

You can extend the base image by defining your own `Dockerfile` ([docs][custom-dockerfile]).

Create `Dockerfile` next to the `devcontainer.json` file.
```
FROM <get this from devcontainer.json>

# Do anthing you would normally in a Dockerfile.
RUN apt-get update && apt-get install -y jq
```

Open `devcontainer.json`.  Use value for "image" in the `Dockerfile`, then replace the `image` key with:
```
"build": {
    // Path is relative to the devcontainer.json file.
    "dockerfile": "Dockerfile"
}
```

Open the palette and select _Dev Containers: Rebuild Container_.  Don't forget to add and commit your changed files.


### Locate the Actual Files from the Repo

The repo files do live on your file system.  How can you locate them?

1. Through Docker Desktop.
1. With the _Remote Explorer_ in VS Code (the icon looks like a computer screen icon).
1. With the Docker CLI in a shell outside the devcontainer.


In a shell outside of VS Code, execute `docker container ls` and identify the container that is your Devcontainer (Hint: It will have the repo name in the image name).  Make note of the container name from the `ls` output.  Then you can use `docker inspect <container-name>` to examine details about the container.  Under the `Mounts` you will find an entry that, again, has the name of your repo in its name and its destination is `/workspaces`.

```
$ docker inspect <container-name> | jq '.[].Mounts[] | {Name, Source, Destination}'
# ... snip...
{
    "Name": "<repo-name>-<branch>-<hash>",
    "Source": "/var/lib/docker/volumes/<repo-name>-<branch>-<hash>/_data
    "Destination": "/workspaces"
}
# ... snip...
```

TODO: I'm not seeing these files on my actual system!  Hmmm... I'll have to come back and sort this out.


### Open in Codespaces

In a browser navigate to your repo.  Click on the `Code` button, select `Codespaces`, and then click `Open in codespace`.  A new tab will be opened, your custom container will be spun up and the Web GUI for VS Code will show your project!

TODO: There are probably ways to open the codespace locally on VS Code or use VS Code to open a Codespace ... explore those features.
- Yup.  It requires the Codespace extension in VS Code.  It is then accessible as a window in the Remote Explorer extension.

[Learn more about Codespaces][codespaces-docs]

From the Web GUI, via the command palette or the


## Clone in Named Container Volume

TODO: Explore how this is different than _Clone in Container Volume_ ([docs][clone-in-named-volume])


[default-linux-universal]: https://github.com/microsoft/vscode-dev-containers/blob/main/containers/codespaces-linux/README.md
[clone-in-container]: https://code.visualstudio.com/remote/advancedcontainers/improve-performance#_use-clone-repository-in-container-volume
[clone-in-named-volume]: https://code.visualstudio.com/remote/advancedcontainers/improve-performance#_use-a-targeted-named-volume
[container-features]: https://containers.dev/features
[custom-dockerfile]: https://containers.dev/guide/dockerfile
[dockerfile-best-practices]: https://docs.docker.com/build/building/best-practices/
[dockerfile-best-practices-2]: https://github.com/dnaprawa/dockerfile-best-practices
[dockerfile-best-practices-3]: https://sysdig.com/blog/dockerfile-best-practices/
[dockerfile-best-practices-4]: https://docs.docker.com/guides/workshop/09_image_best/
[codespaces-docs]: https://docs.github.com/en/codespaces
[my-codespaces]: https://github.com/codespaces/
