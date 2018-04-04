From: James Hogan <jhogan@kernel.org>
Subject: Re: [GIT PULL] arch: remove obsolete architecture ports
Date: Wed, 4 Apr 2018 14:28:16 +0100
Message-ID: <20180404132815.GC25517@saruman>
References: <CAK8P3a0q70FYtBaCcsBPejVULgsbJPwUG7QmrkU9NJpr7oTzpQ@mail.gmail.com>
 <CA+55aFzmQ9specaytsjEb=iNm-NHE5kxMSy_H_jKvqZa4-Fomw@mail.gmail.com>
 <CAK8P3a2pdmLOHb2wkPVvqLDo71Rf3hLVfhG7vsMzaPD-DMEzSg@mail.gmail.com>
 <CAMuHMdVZg8BL7D2eB-FnDbJabU3sfda6nOnaCdJj-3OC-+KP0g@mail.gmail.com>
 <20180404080142.GC9342@amd>
 <CAK8P3a3Rj7utFTrNrNiv3948whE9Tsta9mmLPdX5HxBhif-_9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Rj7utFTrNrNiv3948whE9Tsta9mmLPdX5HxBhif-_9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, David Howells <dhowells@redhat.com>, "moderated list:PANASONIC MN10300..." <linux-am33-list@redhat.com>, Hirokazu Takata <takata@linux-m32r.org>, Lennox Wu <lennox.wu@gmail.com>, Aaron Wu <Aaron.Wu@analog.com>, Bryan Wu <cooloney@gmail.com>, Chris Metcalf <chris.d.metcalf@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-arch.vger.kernel.org


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04, 2018 at 10:38:41AM +0200, Arnd Bergmann wrote:
> Also, now that the other architectures are gone, a lot of changes can
> be done more easily that will be incompatible with a pure revert, so
> the more time passes, the harder it will get to do that.

Yes, and an out-of-tree arch port (as effectively these arches now are)
requires constant maintenance (often subtle runtime breakage) to keep up
to date with each new kernel release, which happens mostly automatically
=66rom arch maintainer POV while they're merged.

Even without changes intentionally taking advantage of not having to
care about these arches, it'll be only a few cycles at the most before a
plain revert won't "just work".

Cheers
James

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrE0u8ACgkQbAtpk944
dnpouw/7BuX2Xq6CccnKjZ0E6fXJrndakmq3V81c5YtmhPBNilFw/n2Rpf0k0edd
HflcS2dsfIDBL6CB6mZIrXidwTcaIgYdClbOK+VNReyzcCGKqBWFguxQ4YF6H+Qt
5Ri1ihoHveHtCkZC2Om9wA8GD5p0283QpHnI19pHCQwL0XblU56dE1210UEDT4CB
ehPIzr7QaOAk8zeN97iB5xEjx6i7xoZQ1e9b4yOERQoR4rTtfx0CyJ75CfdZKVh3
DXenWrRaen4+AeGbczkEeraJI7fL73Uw48Eb8KzZXbqWR21aH4wedb5t1No7T3hK
igW7KhQ/yvwONhEngjyAQ7tIENwckBTtscJm0Amti9fek47i+bMVzVL9Ho2ZlMND
0cb0v07reizXbmjEPVP9ZEQW5FwgYAj+72TD+EvUNHYq6n6pSwOPXZCbtk7LjBBR
MKQ/Wj5FPP89QtA78gDgNfzByRzZPoHK2xbxwy7zstanWTBA0iEJ+jUQzL+bMMVM
CwBI9SGSxbL5hoqk9cd/Owiks7LOhJSyz/R9J39chmB5bqyS0jRDY9j5KSSVYeoI
LWi2fJklr24hIB5xBKow+S3ft5RTqgZOQ1YqRPCLbo1EGXKbGCZ6F2No8KHep2si
rIRA4BLuhM6rz7vVGaRwYN2C5I3Kw6xSI1JWZSNqm4nrEvpMruw=
=ztgU
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
