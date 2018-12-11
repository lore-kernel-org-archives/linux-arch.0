From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 21/27] treewide: surround file paths in Kconfig files
 with double quotes
Date: Tue, 11 Dec 2018 12:19:50 +0100
Message-ID: <20181211111950.ewqhxaoitrrsxp7x@ninjato>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
 <1544526070-16690-22-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mwbqm27pd7bahvul"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544526070-16690-22-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Herbert Xu <herbert@gondor.apana.org.au>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org


--mwbqm27pd7bahvul
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 08:01:04PM +0900, Masahiro Yamada wrote:
> The Kconfig lexer supports special characters such as '.' and '/' in
> the parameter context. In my understanding, the reason is just to
> support bare file paths in the source statement.
>=20
> I do not see a good reason to complicate Kconfig for the room of
> ambiguity.
>=20
> The majority of code already surround file paths with double quotes,
> and it makes sense since the included file paths are constant string
> literals.
>=20
> Make it treewide consistent now.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--mwbqm27pd7bahvul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwPnVYACgkQFA3kzBSg
KbapthAAswtEQAelInCKg1PRZxmFeR9k5d7t4431idaQJttt0QpBw8aERjobozOf
9QrWod/rn7R82mtt9TkSm89JAgla/b7+o2EfCj5niTwt8qyJC3MmeeyJ1ZEMXky9
mu6ZYvA7+yIKO1kTGxaWj3FkeifJmYa9DSjvfk6YXCNjUEmwC71VBOz3kSriIaqp
s1zjn3UYZyKomGiCTsv6652a4lWiRicqIkPBAFkRZ1ZhHszBHXfoPnSIt4z3tJLm
LmRFjc5/J8M1lo/niOjbV9vnR4BerHDW3cO5tX/pt/jRnYmKxtI+wYk3M7jI98Du
kq0XYBwC/2Q6AKUXp27m/BvndNykBB9A3cm85oxaORKoPhS+ZChz18o0Tu6oBlFf
TZs9isju21V9ffcZWZHdmWt24UgRZl+OhRuvGREbNzoVKT+4vPJMzYlKnMNFWMxr
afbBlfGz7RiSD5C+f96hWBPQr8cdP75QLH6myWNY6Hi0G8oYgB81zr9kD2qTrXSB
B8rZiJhFbgnGbGBIcbCPRlOq4kQ5LZWBVCCsMZn7Rzwku7F+ZoVOqc8VKYx8ewUT
is3rtS9tKu6xve/mLWyHqM2Rp2Gid4oQlLqomzCA7PK+k7YxpvEao4AIG51JbujC
pUKib9TWNrPFCrIi6siIkbjlP4HOGTminSdOahxyGgK61Ev74U8=
=6+ar
-----END PGP SIGNATURE-----

--mwbqm27pd7bahvul--
