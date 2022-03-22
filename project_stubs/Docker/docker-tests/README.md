# Dockerfiles, Take 2

My interest in dockerfiles is specifically to allow quick and easy development
of C++ and experimentation with open source libraries without nuking my existing
dev environment. To that end, this directory holds an few examples of how to
set up the docker files in a way that is easily adaptable to future projects. 

This file should also explain some of the thought processes behind different
ways to handle this problem. 

## Managing Dependencies
Managing dependencies is a tricky problem. In an ideal world, we would be able
to pass around a dockerfile and everyone would be able to easily rebuild the
same image. In actuality however, it is easy for some inconsistencies to slip
through. For example, take the following command. 

```
RUN git clone https://github.com/drewtu2/myUtils.git \
    && cd myUtils \
    && ./setup-dotfiles.sh
```

Depending on when this command is executed, the state of the git repo might have
changed, leading to different built images. To fix this we could probably do
something like this.

```
RUN git clone https://github.com/drewtu2/myUtils.git \
    && cd myUtils \
    && git checkout <commithash> \
    && ./setup-dotfiles.sh
```

This would guarantee we were at the specific commit we wanted to use for this
repository. Since this is baked into the dockerfile, it would guarantee everyone
would be using the same version. 

Installing via `apt-get` will likely also lead to similar problems. 

```
RUN apt-get install gparted
```

vs

```
RUN apt-get install gparted=0.16.1-1
```

However, this doesn't seem to always work well in practice for a number of reasons.
Based on [this][so-packages] SO post, it seems like only a handful of the most
recent packages are kept around on the archive. Furthermore, older packages
might have dependencies on other old packages so even IF the "first" order old
dependency exists, it's dependencies might not.

One way around this is to package the dependencies yourself and host your own
mirror of the dependencies. For a hobbiest/homework project, this is probably
overkill...

Therefore, one of the easiest solutions is to build an image, test it, and then
archive/distribute that snapshot of the image to everyone else. This forces
everyone to be using an identical version of the code.

### Download and Patch. 

Another option of updating code is to track patch/diff files and apply them as
part of the docker build process. This also seems fairly brittle...

## Working with Source Code

Since all changes to a container are wiped every time the container is
restarted, developing INSIDE a container is probably a bad idea. Instead, it
would make sense to download and edit your source code on the HOST machine. From
the host machine, we can MOUNT the source directory into the docker container.
This allows the container to see and modify the source code as if it were part
of the container itself. However, since the code actually lives on the host
machine, it remains intact after the container is destroyed. 


[so-packages]:
https://askubuntu.com/questions/428772/how-to-install-specific-version-of-some-package
