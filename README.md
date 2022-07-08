# docker-compose-proxy

This bug-demo shows how `docker compose build` doesn't set up proxy settings correctly at *build* time, even though docker does.  The Dockerfile used by each is exactly the same.

This example is tested on Ubuntu 22.04, but I don't think there's anything special about 22.04.

1. `$ docker compose version
   Docker Compose version v2.6.0`
2. `Docker version 20.10.17, build 100c701`
3. `docker build --no-cache .` (works fine, note the successful output in step 2: "HTTP_PROXY=http://proxy:8888 http_proxy=http://proxy:8888 NO_PROXY=127.0.0.1")

   ```bash
   $ docker build --no-cache .
   Sending build context to Docker daemon  61.95kB
   Step 1/4 : FROM ubuntu
    ---> a7870fd478f4
   Step 2/4 : RUN echo "HTTP_PROXY=$HTTP_PROXY http_proxy=$http_proxy NO_PROXY=$NO_PROXY"
    ---> Running in 167d0546dae8
   HTTP_PROXY=http://proxy:8888 http_proxy=http://proxy:8888 NO_PROXY=127.0.0.1
   Removing intermediate container 167d0546dae8
    ---> 067bf1404143
   Step 3/4 : RUN apt-get update
    ---> Running in b275fc47f89b
   Get:1 http://ports.ubuntu.com/ubuntu-ports jammy InRelease [270 kB]
   Get:2 http://ports.ubuntu.com/ubuntu-ports jammy-updates InRelease [114 kB]
   Get:3 http://ports.ubuntu.com/ubuntu-ports jammy-backports InRelease [99.8 kB]
   Get:4 http://ports.ubuntu.com/ubuntu-ports jammy-security InRelease [110 kB]
   Get:5 http://ports.ubuntu.com/ubuntu-ports jammy/restricted arm64 Packages [24.2 kB]
   Get:6 http://ports.ubuntu.com/ubuntu-ports jammy/universe arm64 Packages [17.2 MB]
   Get:7 http://ports.ubuntu.com/ubuntu-ports jammy/multiverse arm64 Packages [224 kB]
   Get:8 http://ports.ubuntu.com/ubuntu-ports jammy/main arm64 Packages [1758 kB]
   Get:9 http://ports.ubuntu.com/ubuntu-ports jammy-updates/universe arm64 Packages [171 kB]
   Get:10 http://ports.ubuntu.com/ubuntu-ports jammy-updates/multiverse arm64 Packages [1271 B]
   Get:11 http://ports.ubuntu.com/ubuntu-ports jammy-updates/restricted arm64 Packages [70.6 kB]
   Get:12 http://ports.ubuntu.com/ubuntu-ports jammy-updates/main arm64 Packages [416 kB]
   Get:13 http://ports.ubuntu.com/ubuntu-ports jammy-backports/universe arm64 Packages [5794 B]
   Get:14 http://ports.ubuntu.com/ubuntu-ports jammy-security/main arm64 Packages [232 kB]
   Get:15 http://ports.ubuntu.com/ubuntu-ports jammy-security/universe arm64 Packages [94.7 kB]
   Get:16 http://ports.ubuntu.com/ubuntu-ports jammy-security/restricted arm64 Packages [52.7 kB]
   Fetched 20.9 MB in 16s (1306 kB/s)
   Reading package lists...
   Removing intermediate container b275fc47f89b
    ---> 1151dec10c9f
   Step 4/4 : RUN apt-get install -y autojump
    ---> Running in 5f510c5e2d74
   Reading package lists...
   Building dependency tree...
   Reading state information...
   The following additional packages will be installed:
     libexpat1 libmpdec3 libpython3-stdlib libpython3.10-minimal
     libpython3.10-stdlib libreadline8 libsqlite3-0 media-types python3
     python3-minimal python3.10 python3.10-minimal readline-common
   Suggested packages:
     python3-doc python3-tk python3-venv python3.10-venv python3.10-doc binutils
     binfmt-support readline-doc
   The following NEW packages will be installed:
     autojump libexpat1 libmpdec3 libpython3-stdlib libpython3.10-minimal
     libpython3.10-stdlib libreadline8 libsqlite3-0 media-types python3
     python3-minimal python3.10 python3.10-minimal readline-common
   0 upgraded, 14 newly installed, 0 to remove and 9 not upgraded.
   Need to get 6486 kB of archives.
   After this operation, 22.9 MB of additional disk space will be used.
   Get:1 http://ports.ubuntu.com/ubuntu-ports jammy/main arm64 libpython3.10-minimal arm64 3.10.4-3 [806 kB]
   Get:2 http://ports.ubuntu.com/ubuntu-ports jammy/main arm64 libexpat1 arm64 2.4.7-1 [78.1 kB]
   Get:3 http://ports.ubuntu.com/ubuntu-ports jammy/main arm64 python3.10-minimal arm64 3.10.4-3 [2244 kB]
   Get:4 http://ports.ubuntu.com/ubuntu-ports jammy/main arm64 python3-minimal arm64 3.10.4-0ubuntu2 [24.4 kB]
   Get:5 http://ports.ubuntu.com/ubuntu-ports jammy/main arm64 media-types all 7.0.0 [25.5 kB]
   Get:6 http://ports.ubuntu.com/ubuntu-ports jammy/main arm64 libmpdec3 arm64 2.5.1-2build2 [89.0 kB]
   Get:7 http://ports.ubuntu.com/ubuntu-ports jammy/main arm64 readline-common all 8.1.2-1 [53.5 kB]
   Get:8 http://ports.ubuntu.com/ubuntu-ports jammy/main arm64 libreadline8 arm64 8.1.2-1 [153 kB]
   Get:9 http://ports.ubuntu.com/ubuntu-ports jammy/main arm64 libsqlite3-0 arm64 3.37.2-2 [636 kB]
   Get:10 http://ports.ubuntu.com/ubuntu-ports jammy/main arm64 libpython3.10-stdlib arm64 3.10.4-3 [1827 kB]
   Get:11 http://ports.ubuntu.com/ubuntu-ports jammy/main arm64 python3.10 arm64 3.10.4-3 [488 kB]
   Get:12 http://ports.ubuntu.com/ubuntu-ports jammy/main arm64 libpython3-stdlib arm64 3.10.4-0ubuntu2 [6990 B]
   Get:13 http://ports.ubuntu.com/ubuntu-ports jammy/main arm64 python3 arm64 3.10.4-0ubuntu2 [22.8 kB]
   Get:14 http://ports.ubuntu.com/ubuntu-ports jammy/universe arm64 autojump all 22.5.1-1.1 [32.6 kB]
   debconf: delaying package configuration, since apt-utils is not installed
   Fetched 6486 kB in 20s (323 kB/s)
   Selecting previously unselected package libpython3.10-minimal:arm64.
   (Reading database ... 4389 files and directories currently installed.)
   Preparing to unpack .../libpython3.10-minimal_3.10.4-3_arm64.deb ...
   Unpacking libpython3.10-minimal:arm64 (3.10.4-3) ...
   Selecting previously unselected package libexpat1:arm64.
   Preparing to unpack .../libexpat1_2.4.7-1_arm64.deb ...
   Unpacking libexpat1:arm64 (2.4.7-1) ...
   Selecting previously unselected package python3.10-minimal.
   Preparing to unpack .../python3.10-minimal_3.10.4-3_arm64.deb ...
   Unpacking python3.10-minimal (3.10.4-3) ...
   Setting up libpython3.10-minimal:arm64 (3.10.4-3) ...
   Setting up libexpat1:arm64 (2.4.7-1) ...
   Setting up python3.10-minimal (3.10.4-3) ...
   Selecting previously unselected package python3-minimal.
   (Reading database ... 4691 files and directories currently installed.)
   Preparing to unpack .../0-python3-minimal_3.10.4-0ubuntu2_arm64.deb ...
   Unpacking python3-minimal (3.10.4-0ubuntu2) ...
   Selecting previously unselected package media-types.
   Preparing to unpack .../1-media-types_7.0.0_all.deb ...
   Unpacking media-types (7.0.0) ...
   Selecting previously unselected package libmpdec3:arm64.
   Preparing to unpack .../2-libmpdec3_2.5.1-2build2_arm64.deb ...
   Unpacking libmpdec3:arm64 (2.5.1-2build2) ...
   Selecting previously unselected package readline-common.
   Preparing to unpack .../3-readline-common_8.1.2-1_all.deb ...
   Unpacking readline-common (8.1.2-1) ...
   Selecting previously unselected package libreadline8:arm64.
   Preparing to unpack .../4-libreadline8_8.1.2-1_arm64.deb ...
   Unpacking libreadline8:arm64 (8.1.2-1) ...
   Selecting previously unselected package libsqlite3-0:arm64.
   Preparing to unpack .../5-libsqlite3-0_3.37.2-2_arm64.deb ...
   Unpacking libsqlite3-0:arm64 (3.37.2-2) ...
   Selecting previously unselected package libpython3.10-stdlib:arm64.
   Preparing to unpack .../6-libpython3.10-stdlib_3.10.4-3_arm64.deb ...
   Unpacking libpython3.10-stdlib:arm64 (3.10.4-3) ...
   Selecting previously unselected package python3.10.
   Preparing to unpack .../7-python3.10_3.10.4-3_arm64.deb ...
   Unpacking python3.10 (3.10.4-3) ...
   Selecting previously unselected package libpython3-stdlib:arm64.
   Preparing to unpack .../8-libpython3-stdlib_3.10.4-0ubuntu2_arm64.deb ...
   Unpacking libpython3-stdlib:arm64 (3.10.4-0ubuntu2) ...
   Setting up python3-minimal (3.10.4-0ubuntu2) ...
   Selecting previously unselected package python3.
   (Reading database ... 5120 files and directories currently installed.)
   Preparing to unpack .../python3_3.10.4-0ubuntu2_arm64.deb ...
   Unpacking python3 (3.10.4-0ubuntu2) ...
   Selecting previously unselected package autojump.
   Preparing to unpack .../autojump_22.5.1-1.1_all.deb ...
   Unpacking autojump (22.5.1-1.1) ...
   Setting up media-types (7.0.0) ...
   Setting up libsqlite3-0:arm64 (3.37.2-2) ...
   Setting up libmpdec3:arm64 (2.5.1-2build2) ...
   Setting up readline-common (8.1.2-1) ...
   Setting up libreadline8:arm64 (8.1.2-1) ...
   Setting up libpython3.10-stdlib:arm64 (3.10.4-3) ...
   Setting up libpython3-stdlib:arm64 (3.10.4-0ubuntu2) ...
   Setting up python3.10 (3.10.4-3) ...
   Setting up python3 (3.10.4-0ubuntu2) ...
   running python rtupdate hooks for python3.10...
   running python post-rtupdate hooks for python3.10...
   Setting up autojump (22.5.1-1.1) ...
   Processing triggers for libc-bin (2.35-0ubuntu3) ...
   Removing intermediate container 5f510c5e2d74
    ---> 3c6180eb7b9e
   Successfully built 3c6180eb7b9e
   
   ```
   
4. `docker compose build --no-cache --progress=plain` - note that the output in step 5 is "HTTP_PROXY= http_proxy= NO_PROXY="
   ```bash
   #1 [internal] load build definition from Dockerfile
   #1 transferring dockerfile:
   #1 transferring dockerfile: 178B done
   #1 DONE 0.0s
   
   #2 [internal] load .dockerignore
   #2 transferring context: 2B done
   #2 DONE 0.0s
   
   #3 [internal] load metadata for docker.io/library/ubuntu:latest
   #3 DONE 0.0s
   
   #4 [1/4] FROM docker.io/library/ubuntu
   #4 CACHED
   
   #5 [2/4] RUN echo "HTTP_PROXY=$HTTP_PROXY http_proxy=$http_proxy NO_PROXY=$NO_PROXY"
   #5 0.152 HTTP_PROXY= http_proxy= NO_PROXY=
   #5 DONE 0.2s
   
   #6 [3/4] RUN apt-get update
   #6 0.418 Ign:1 http://ports.ubuntu.com/ubuntu-ports jammy InRelease
   #6 0.567 Ign:2 http://ports.ubuntu.com/ubuntu-ports jammy-updates InRelease
   #6 0.638 Ign:3 http://ports.ubuntu.com/ubuntu-ports jammy-backports InRelease
   #6 0.718 Ign:4 http://ports.ubuntu.com/ubuntu-ports jammy-security InRelease
   #6 1.513 Ign:1 http://ports.ubuntu.com/ubuntu-ports jammy InRelease
   #6 1.648 Ign:2 http://ports.ubuntu.com/ubuntu-ports jammy-updates InRelease
   #6 1.723 Ign:3 http://ports.ubuntu.com/ubuntu-ports jammy-backports InRelease
   #6 1.800 Ign:4 http://ports.ubuntu.com/ubuntu-ports jammy-security InRelease
   #6 3.591 Ign:1 http://ports.ubuntu.com/ubuntu-ports jammy InRelease
   #6 3.727 Ign:2 http://ports.ubuntu.com/ubuntu-ports jammy-updates InRelease
   #6 3.801 Ign:3 http://ports.ubuntu.com/ubuntu-ports jammy-backports InRelease
   #6 3.872 Ign:4 http://ports.ubuntu.com/ubuntu-ports jammy-security InRelease
   #6 7.669 Err:1 http://ports.ubuntu.com/ubuntu-ports jammy InRelease
   #6 7.669   Could not connect to ports.ubuntu.com:80 (185.125.190.39). - connect (101: Network is unreachable) Could not connect to ports.ubuntu.com:80 (185.125.190.36). - connect (101: Network is unreachable)
   #6 7.808 Err:2 http://ports.ubuntu.com/ubuntu-ports jammy-updates InRelease
   #6 7.808   Unable to connect to ports.ubuntu.com:80:
   #6 7.881 Err:3 http://ports.ubuntu.com/ubuntu-ports jammy-backports InRelease
   #6 7.881   Unable to connect to ports.ubuntu.com:80:
   #6 7.957 Err:4 http://ports.ubuntu.com/ubuntu-ports jammy-security InRelease
   #6 7.957   Unable to connect to ports.ubuntu.com:80:
   #6 7.970 Reading package lists...
   #6 7.989 W: Failed to fetch http://ports.ubuntu.com/ubuntu-ports/dists/jammy/InRelease  Could not connect to ports.ubuntu.com:80 (185.125.190.39). - connect (101: Network is unreachable) Could not connect to ports.ubuntu.com:80 (185.125.190.36). - connect (101: Network is unreachable)
   #6 7.989 W: Failed to fetch http://ports.ubuntu.com/ubuntu-ports/dists/jammy-updates/InRelease  Unable to connect to ports.ubuntu.com:80:
   #6 7.989 W: Failed to fetch http://ports.ubuntu.com/ubuntu-ports/dists/jammy-backports/InRelease  Unable to connect to ports.ubuntu.com:80:
   #6 7.989 W: Failed to fetch http://ports.ubuntu.com/ubuntu-ports/dists/jammy-security/InRelease  Unable to connect to ports.ubuntu.com:80:
   #6 7.989 W: Some index files failed to download. They have been ignored, or old ones used instead.
   #6 DONE 8.0s
   
   #7 [4/4] RUN apt-get install -y autojump
   #7 0.339 Reading package lists...
   #7 0.346 Building dependency tree...
   #7 0.346 Reading state information...
   #7 0.346 E: Unable to locate package autojump
   #7 ERROR: executor failed running [/bin/sh -c apt-get install -y autojump]: exit code: 100
   ------
    > [4/4] RUN apt-get install -y autojump:
   
   #7 0.346 Building dependency tree...
   #7 0.346 Reading state information...
   #7 0.346 E: Unable to locate package autojump
   ------
   failed to solve: executor failed running [/bin/sh -c apt-get install -y autojump]: exit code: 100
   ```
