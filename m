From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
Date: Sun, 30 Sep 2018 21:45:18 +0200
Message-ID: <39d64180-73d5-6f27-e455-956143a5b5d3@digikod.net>
References: <20180929103453.12025-1-cyphar@cyphar.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Feym2fnev053dmFcOhqlbxZLmNqxSKfIy"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180929103453.12025-1-cyphar@cyphar.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksa Sarai <cyphar@cyphar.com>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Christian Brauner <christian@brauner.io>, Eric Biederman <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, dev@opencontainers.org, containers@lists.linux-foundation.org, linux-security-module <linux-security-module@vger.kernel.org>, Kees Cook <keescook@chromium.org>Andy Lutomirski <luto@kernel.org>
List-Id: linux-arch.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Feym2fnev053dmFcOhqlbxZLmNqxSKfIy
Content-Type: multipart/mixed; boundary="sMs1JIs6X9nEq3L8PGLQai3GHiZyPZxOB";
 protected-headers="v1"
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To: Aleksa Sarai <cyphar@cyphar.com>, Jeff Layton <jlayton@kernel.org>,
 "J. Bruce Fields" <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <christian@brauner.io>,
 Eric Biederman <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.ws>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dev@opencontainers.org, containers@lists.linux-foundation.org,
 linux-security-module <linux-security-module@vger.kernel.org>,
 Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>
Message-ID: <39d64180-73d5-6f27-e455-956143a5b5d3@digikod.net>
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
References: <20180929103453.12025-1-cyphar@cyphar.com>
In-Reply-To: <20180929103453.12025-1-cyphar@cyphar.com>

--sMs1JIs6X9nEq3L8PGLQai3GHiZyPZxOB
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

As a side note, I'm still working on Landlock which can achieve the same
goal but in a more flexible and dynamic way: https://landlock.io

Regards,
 Micka=EBl

On 9/29/18 12:34, Aleksa Sarai wrote:
> The need for some sort of control over VFS's path resolution (to avoid
> malicious paths resulting in inadvertent breakouts) has been a very
> long-standing desire of many userspace applications. This patchset is a=

> revival of Al Viro's old AT_NO_JUMPS[1] patchset with a few additions.
>=20
> The most obvious change is that AT_NO_JUMPS has been split as dicussed
> in the original thread, along with a further split of AT_NO_PROCLINKS
> which means that each individual property of AT_NO_JUMPS is now a
> separate flag:
>=20
>   * Path-based escapes from the starting-point using "/" or ".." are
>     blocked by AT_BENEATH.
>   * Mountpoint crossings are blocked by AT_XDEV.
>   * /proc/$pid/fd/$fd resolution is blocked by AT_NO_PROCLINKS (more
> 	correctly it actually blocks any user of nd_jump_link() because it
> 	allows out-of-VFS path resolution manipulation).
>=20
> AT_NO_JUMPS is now effectively (AT_BENEATH|AT_XDEV|AT_NO_PROCLINKS). At=

> Linus' suggestion in the original thread, I've also implemented
> AT_NO_SYMLINKS which just denies _all_ symlink resolution (including
> "proclink" resolution).
>=20
> An additional improvement was made to AT_XDEV. The original AT_NO_JUMPS=

> path didn't consider "/tmp/.." as a mountpoint crossing -- this patch
> blocks this as well (feel free to ask me to remove it if you feel this
> is not sane).
>=20
> Currently I've only enabled these for openat(2) and the stat(2) family.=

> I would hope we could enable it for basically every *at(2) syscall --
> but many of them appear to not have a @flags argument and thus we'll
> need to add several new syscalls to do this. I'm more than happy to sen=
d
> those patches, but I'd prefer to know that this preliminary work is
> acceptable before doing a bunch of copy-paste to add new sets of *at(2)=

> syscalls.
>=20
> One additional feature I've implemented is AT_THIS_ROOT (I imagine this=

> is probably going to be more contentious than the refresh of
> AT_NO_JUMPS, so I've included it in a separate patch). The patch itself=

> describes my reasoning, but the shortened version of the premise is tha=
t
> continer runtimes need to have a way to resolve paths within a
> potentially malicious rootfs. Container runtimes currently do this in
> userspace[2] which has implicit race conditions that are not resolvable=

> in userspace (or use fork+exec+chroot and SCM_RIGHTS passing which is
> inefficient). AT_THIS_ROOT allows for per-call chroot-like semantics fo=
r
> path resolution, which would be invaluable for us -- and the
> implementation is basically identical to AT_BENEATH (except that we
> don't return errors when someone actually hits the root).
>=20
> I've added some selftests for this, but it's not clear to me whether
> they should live here or in xfstests (as far as I can tell there are no=

> other VFS tests in selftests, while there are some tests that look like=

> generic VFS tests in xfstests). If you'd prefer them to be included in
> xfstests, let me know.
>=20
> [1]: https://lore.kernel.org/patchwork/patch/784221/
> [2]: https://github.com/cyphar/filepath-securejoin
>=20
> Aleksa Sarai (3):
>   namei: implement O_BENEATH-style AT_* flags
>   namei: implement AT_THIS_ROOT chroot-like path resolution
>   selftests: vfs: add AT_* path resolution tests
>=20
>  fs/fcntl.c                                    |   2 +-
>  fs/namei.c                                    | 158 ++++++++++++------=

>  fs/open.c                                     |  10 ++
>  fs/stat.c                                     |  15 +-
>  include/linux/fcntl.h                         |   3 +-
>  include/linux/namei.h                         |   8 +
>  include/uapi/asm-generic/fcntl.h              |  20 +++
>  include/uapi/linux/fcntl.h                    |  10 ++
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/vfs/.gitignore        |   1 +
>  tools/testing/selftests/vfs/Makefile          |  13 ++
>  tools/testing/selftests/vfs/at_flags.h        |  40 +++++
>  tools/testing/selftests/vfs/common.sh         |  37 ++++
>  .../selftests/vfs/tests/0001_at_beneath.sh    |  72 ++++++++
>  .../selftests/vfs/tests/0002_at_xdev.sh       |  54 ++++++
>  .../vfs/tests/0003_at_no_proclinks.sh         |  50 ++++++
>  .../vfs/tests/0004_at_no_symlinks.sh          |  49 ++++++
>  .../selftests/vfs/tests/0005_at_this_root.sh  |  66 ++++++++
>  tools/testing/selftests/vfs/vfs_helper.c      | 154 +++++++++++++++++
>  19 files changed, 707 insertions(+), 56 deletions(-)
>  create mode 100644 tools/testing/selftests/vfs/.gitignore
>  create mode 100644 tools/testing/selftests/vfs/Makefile
>  create mode 100644 tools/testing/selftests/vfs/at_flags.h
>  create mode 100644 tools/testing/selftests/vfs/common.sh
>  create mode 100755 tools/testing/selftests/vfs/tests/0001_at_beneath.s=
h
>  create mode 100755 tools/testing/selftests/vfs/tests/0002_at_xdev.sh
>  create mode 100755 tools/testing/selftests/vfs/tests/0003_at_no_procli=
nks.sh
>  create mode 100755 tools/testing/selftests/vfs/tests/0004_at_no_symlin=
ks.sh
>  create mode 100755 tools/testing/selftests/vfs/tests/0005_at_this_root=
=2Esh
>  create mode 100644 tools/testing/selftests/vfs/vfs_helper.c
>=20


--sMs1JIs6X9nEq3L8PGLQai3GHiZyPZxOB--

--Feym2fnev053dmFcOhqlbxZLmNqxSKfIy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUysCyY8er9Axt7hqIt7+33O9apUFAluxJ84ACgkQIt7+33O9
apXeyAf+OnSwPdBayV1fdgXBpMfKOUYkvGnIu/wwMcrCZsARqrmToAlomImix6JX
nRiOPtjUGFSFeL8RgAAsaJH32m4jvMVMl2nI7Yz2ai+17ia36BeF2JvtGVzgO2Wk
TQFmEHUTb81mtZY6pj8M5hAuHMnYHbQVHXdy2raxRe+st8FmJwTFCF02tGGpgzDT
Q9EhyKlyMI+wwO6QLsBjGqfgfDv7qsCpHcAgENR0UVavKjxhN6ecNECgiYIwATCV
6Wl8IsgsgruG42uQrGt+ph9yZBAkHVtRfFwl/k2y2Z2N0NCzoRLDLdx0/iXHNtV5
Vo+/RbgySyTjkO8kl1y+i6qwdmyEkg==
=/s0t
-----END PGP SIGNATURE-----

--Feym2fnev053dmFcOhqlbxZLmNqxSKfIy--
