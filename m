From: Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 1/3] namei: implement O_BENEATH-style AT_* flags
Date: Sun, 30 Sep 2018 01:34:30 +1000
Message-ID: <20180929152754.rbh37oluivbywdja@ryuk>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <20180929103453.12025-2-cyphar@cyphar.com>
 <20180929144845.4nglr3sf3jyzosfz@brauner.io>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p4urhvw3vy4zr33u"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180929144845.4nglr3sf3jyzosfz@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Brauner <christian@brauner.io>
Cc: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, dev@opencontainers.org, containers@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org


--p4urhvw3vy4zr33u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-09-29, Christian Brauner <christian@brauner.io> wrote:
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Christian Brauner <christian@brauner.io>
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
>=20
> Not to be a stickler about protocol but given that this is based heavily
> on ideas from prior patchsets and suggestions as you mentioned it might
> make sense to cite them as links and also maybe add some Suggested-by
> lines for some of the authors for the sake of posterity. :)

Oops -- yup, I will fix that up.

> [1]: https://lwn.net/Articles/721443/
> [2]: https://lwn.net/Articles/723057/

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--p4urhvw3vy4zr33u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAluvm4YACgkQnhiqJn3b
jbRVuw/9EgcWsNeK8k0ILlm2J0+yTei8nqAn3kRgmI1Gu6r5NTzK+ZDn2lsRbn/g
tBiyVspNAtnHhTLdweYqGveWbp9QF7ZM/iQGQPyU9i6u4JUThiFO43plGZ3a13SQ
FjhKGgbAxlenk0fJ1nUngjP5pcXGOTPtNu7iQbXMITefSC/S+0RJ2HvjBkR5tD7z
I7A8yQ4yoQxeu4jXJzk5sGRcABiL4m0X3B3CYRM0nbbejVDMcG4bK/kUy999FfI0
aYIhAGEWAMzjgROXaj737byJGbVJtqih5qy/ACpIdPFhLZOZo4gF2QlU8z6Rxfk2
8/1wahOf7YzOJrVvQHfVsZIX06g5mPTosstWr90AoGm8D0LyreRZUJpR6PA9R+08
Ozn32/BoidlnlNuOALythUGzaSb8QTQOPY7tBsGNDA+Y3vJLBBjmbqmp/bTpukmu
7zCyuQEtUJnuaRdMqttTGxy4NonH3pHE5LDfnYtyedvW9u0jZ5wwGceclXzBM8Ge
/UGTa7VPrv4P3n0GqGVGxmN5kb/eiVwI1YneNe+q2GzCV6lAcDabMBZPI1Z7r9SI
Jk73gpD4FLTwdnm2L9uZwC5R66FmEeo6tVj1GG0wKtnQGUamBUINqVZWUQrc3T+k
8S8nTJvdG69l1VO3GyyFGaFhyOEqu3D5b6hpR5f4zFNTXgUxcVY=
=KoTi
-----END PGP SIGNATURE-----

--p4urhvw3vy4zr33u--
