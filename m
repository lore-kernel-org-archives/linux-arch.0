Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45491 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbeI2WO5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Sep 2018 18:14:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id a23-v6so6260198pfi.12
        for <linux-arch@vger.kernel.org>; Sat, 29 Sep 2018 08:46:03 -0700 (PDT)
Date: Sun, 30 Sep 2018 01:45:51 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
Message-ID: <20180929154551.jsi6dt3xjxdxoqeh@ryuk>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <1EE20CA2-4C8B-4A80-B613-0277D92B376D@amacapital.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qwzrg5udmfedjzky"
Content-Disposition: inline
In-Reply-To: <1EE20CA2-4C8B-4A80-B613-0277D92B376D@amacapital.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Christian Brauner <christian@brauner.io>, Eric Biederman <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, dev@opencontainers.org, containers@lists.linux-foundation.org
Message-ID: <20180929154551.7h-bd-Z8RBKrMq67NmnG_5Tm3jdr9gUCJJKuWnml_oY@z>


--qwzrg5udmfedjzky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-09-29, Andy Lutomirski <luto@amacapital.net> wrote:
> > The most obvious change is that AT_NO_JUMPS has been split as dicussed
> > in the original thread, along with a further split of AT_NO_PROCLINKS
> > which means that each individual property of AT_NO_JUMPS is now a
> > separate flag:
> >=20
> >  * Path-based escapes from the starting-point using "/" or ".." are
> >    blocked by AT_BENEATH.
>=20
> Seems useful.
>=20
> >  * Mountpoint crossings are blocked by AT_XDEV.
>=20
> Seems useful.
>=20
> >  * /proc/$pid/fd/$fd resolution is blocked by AT_NO_PROCLINKS (more
> >    correctly it actually blocks any user of nd_jump_link() because it
> >    allows out-of-VFS path resolution manipulation).
> >=20
>=20
> So how do I disable following symlinks? ISTM the most natural way
> would be to have AT_NO_SYMLINKS, and to have that flag disable proc
> links.

So, this patchset has both AT_NO_SYMLINKS and AT_NO_PROCLINKS.

* AT_NO_SYMLINKS blocks *all* symlinks (which is something Linus requested
  in the original thread[2] -- apparently this is something that would
  be useful to git even if wouldn't violate AT_BENEATH). This implies
  AT_NO_PROCLINKS.

* AT_NO_PROCLINKS only blocks procfs-style "symlinks" (filesystem
  "symlinks" that call nd_jump_link() themselves -- currently only
  procfs and nsfs).

The reason why we need AT_NO_PROCLINKS is that "proclinks"[*] allow for
breaking-out of nd->root without a trivial way of detecting it (since
the filesystem can manipulate nd->path almost arbitrarily outside of the
control of VFS). Al Viro's original patchset[1] also blocked these but
it was all included within AT_NO_JUMPS.

Requiring you to block *all* symlinks in order to block "proclinks"
seems to be a bit overkill to me (especially if consider that
AT_THIS_ROOT|AT_NO_PROCLINKS is definitely a usecase most container
runtimes would be _very_ interested in -- while AT_NO_SYMLINKS will
cause issues with most distribution images).

[*]: Sorry for the awful naming, I'm not sure what the correct name is
	 (I've called them "super symlinks" in the past) -- if you have a
	 better name please let me know!

[1]: https://lwn.net/Articles/721443/
[2]: https://marc.info/?l=3Dlinux-kernel&m=3D149394765324531&w=3D2

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--qwzrg5udmfedjzky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAluvnisACgkQnhiqJn3b
jbRV4Q//Yv0XqDT57HQ7f6MoWyB/2CXJ7ato/sBw45GjHWhxXQeE+7YX1j3Dos0b
YCGutLWMFaLFV4lezrHWqKMwEn1ZvntEdaqufQyTIr8i/2sCdRXQbQvX3t1Rb48e
6FPyzXMzPJNxq7MOo6ELsuhJbX3u2S46gCkBsDRpkSqxoGsd8M7pY4+zmtVmtBoH
kvHFHsyiHbOlRaDUhwx4KPEmYM14bUWgTYSa4jH+yQrI6gLGbuGMlcWd5izj2gUh
L0OFFnUSXh5wPa1XBbyuMseutfA9vLUSf7ixeEcaA91v4kRj2s2eLonwFDyy85PB
+MlxYbWGmpNH2dICexMklhgjnHXEqWfFZzWQIPFoeaDi1o9JS+14wvL5oEUaHt2S
dGtAjASgwo/T6lwuvkZcvIm52JGNT7br37tHuxqZsIUa5jTk3QqKK3FjNKneOVvA
qKpq7baRP+83b7szJI8P5giKqZd6dCJl3VT7vr5dIu2J3icAVP6t+rOZXvFazlT9
9osRnYfb1h36OgpJt0kbiPIDHKeyYTbDJHklVE039KNhBvk4tMD/vsTi/h+Daey1
tCsvRAd7OiphkO/agltEcQh6LG/0mGAL0Ded2jh4halv1frFXmBdp/jcezbPGEMz
/rb8svqBRkp+xbfqLvpbNOLYS+j4plv3SAvsSnNOcckWfnbxAnM=
=MTjA
-----END PGP SIGNATURE-----

--qwzrg5udmfedjzky--
