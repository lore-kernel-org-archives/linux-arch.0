From: Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
Date: Sun, 30 Sep 2018 14:44:11 +1000
Message-ID: <20180930044411.orcuw7xok4szqzzo@ryuk>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <20180929143814.yfo6rud7dkyb5ip4@brauner.io>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="olyw2qotbhbwue5q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180929143814.yfo6rud7dkyb5ip4@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Brauner <christian@brauner.io>
Cc: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, dev@opencontainers.org, containers@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org


--olyw2qotbhbwue5q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-09-29, Christian Brauner <christian@brauner.io> wrote:
> > Currently I've only enabled these for openat(2) and the stat(2) family.
> > I would hope we could enable it for basically every *at(2) syscall --
> > but many of them appear to not have a @flags argument and thus we'll
> > need to add several new syscalls to do this. I'm more than happy to send
> > those patches, but I'd prefer to know that this preliminary work is
> > acceptable before doing a bunch of copy-paste to add new sets of *at(2)
> > syscalls.
>=20
> We should really make sure that we can't make due with openat() alone
> before adding a bunch of new syscalls. So there's no need to rush into
> this. :)

Yeah, I think that we could (mostly) make do with openat(2). We might
need to have renameat(2) and a few others, but if we had more support
for AT_EMPTY_PATH you should be able to just O_PATH|O_{BENEATH,XDEV,...}
and then operate on the O_PATH fd.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--olyw2qotbhbwue5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAluwVJsACgkQnhiqJn3b
jbR0AA//VbHHrVwS/hgpTdN1okuZDNZ5MgjStZWgSjTWaEpyL8G2YwAmKes3x5MS
nfvOGCx32EeDIXhcjNzSjkDQIMGRHNwPTTqzymFzY/OmVgYj1ECdDrpQrFtF3msM
501KZ507tvbJti4hZq0EZF6Jbq3py+fXzGqpCWGBv4VWoPsHPt+/KoTf6enleZQJ
6hiM4anCKveDNTE+BQ20fsTbs1V0x7A9ykVq2hNQECmiWJvOHgUdzddBIdOM95Vb
13k7G3Wf/YcaS2kp1cUVtLcfFocqKGPLcuPrdXAjkekfYth0KwDX0ViBKt5LbUKb
l4XpiFZ0MlFOY04zdIGRYGyP8s6Vse/GpdukmnSTL68ALRDR5/4G5okrbSILmvFh
YJr+QF+b/H+yg51LdYi/o2YZqcwPrYJAdUzbWvxz68nLA3YdOeXCEOvES/q8ebDZ
03Rt7v1UhTSg2QdZvax4MAdlhUe2IJKw0/vC18uyCqwTPRpE+yxM7Ux2P1RpMp2t
eDC6zH7sGdAN7iGewJqEWmD+EE6FYlaP0Fd1IjNgg6qeETprfNzk5orJPzwxvMdu
zGrxuAGmagi+6t18ZSKq7Gsaq8ZpZ1wXfgaC5cRzDEQigy1s105NepC0/wbBhVFU
5g7ykyPiCuOSN+E4ifsbWCUUemKUNb8FmZwx1XIArYE5UDbY9Q0=
=oJlG
-----END PGP SIGNATURE-----

--olyw2qotbhbwue5q--
