From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported
 from asm
Date: Tue, 29 Nov 2016 01:15:48 +0000
Message-ID: <1480382148.16599.61.camel@decadent.org.uk>
References: <CA+55aFwXqv6uYmW0kC=c+yyumO_T0CJrz6m+MQCQX6bR5gRBQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-388Uc9j86g6pPFS3NL3W"
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <CA+55aFwXqv6uYmW0kC=c+yyumO_T0CJrz6m+MQCQX6bR5gRBQw@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Marek <mmarek@suse.com>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Adam Borowski <kilobyte@angband.pl>, Debian kernel maintainers <debian-kernel@lists.debian.org>
List-Id: linux-arch.vger.kernel.org


--=-388Uc9j86g6pPFS3NL3W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[I've had to guess at the cc list for this, because we no longer have
mail archives that preserve them.]

On Fri, 2016-11-25 at 10:01 -0800, Linus Torvalds wrote:
> On Thu, Nov 24, 2016 at 4:40 PM, Nicholas Piggin <npiggin@gmail.com> wrot=
e:
> > >=20
> > > Yes, manual "marking" is never going to be a viable solution.
> >=20
> > I guess it really depends on how exactly you want to use it. For distro=
s
> > that do stable ABI but rarely may have to break something for security
> > reasons, it should work and give exact control.

This is roughly how Debian handles the kernel module=C2=A0ABI during a
stable release.

> No. Because nobody else will care, so unless it's like a single symbol
> or something, it will just be a maintenance nightmare.

I agree with this. =C2=A0We can explicitly "version" individual symbols
anyway by doing something like:

-int foo(void);
+#define foo foo_2
+int foo_2(int);

> > What else do people *actually* use it for? Preventing mismatched module=
s
> > when .git version is not attached and release version of the kernel has
> > not been bumped. Is that it?
>=20
> It used to be very useful for avoiding loading stale modules and then
> wasting days on debugging something that wasn't the case when you had
> forgotten to do "make modules_install". Change some subtle internal
> ABI issue (add/remove a parameter, whatever) and it would really help.
>=20
> These days, for me, LOCALVERSION_AUTO and module signing are what I
> personally tend to use.
>
> The modversions stuff may just be too painful to bother with. Very few
> people probably use it, and the ones that do likely don't have any
> overriding reason why.
[...]

Debian has some strong reasons:

1. Changing the release string requires any out-of-tree modules to be
upgraded (at least rebuilt) on end-user systems.  So we try to avoid
doing that during the lifetime of a stable release, i.e. we don't let
the release string change.  Also, the release string is reflected in
package names (e.g. linux-image-4.8.0-1-amd64), and introducing new
package names requires manual approval by the Debian archive team.

2. We want to allow ABI breaks for "internal" symbols used only by in-
tree modules, as those breaks will be resolved by rebooting to complete
the upgrade.  But we need a run-time check to prevent loading an
incompatible module before the reboot.

3. So far as I can see, module signing doesn't work for a distribution
kernel with out-of-tree modules as there has to be a trust path from a
built-in certificate to the module signing certificate.  So signature
enforcement will have to be disabled on systems that use out-of-tree
modules, thus it's not a substitute for modversions.

We expect Linux 4.9 to be the basis for a longterm stable branch and=C2=A0o=
n
that basis intend to include it in the next Debian stable release.=20
Even if the decision is to get rid of modversions, it would be very
helpful if they could be revived for 4.9 so that we have some time to
adapt our packaging practices to work without them in future.

Ben.

--=20
Ben Hutchings
Theory and practice are closer in theory than in practice.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- John Levine, moderator of
comp.compilers


--=-388Uc9j86g6pPFS3NL3W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlg81sQACgkQ57/I7JWG
EQmvxw/9EDj7jYImHnt76gEQEMC/SiaIMl10l1b/w2+HpZonB52kJ6USf+IeWLhU
8/2JmX2SSspeoskAADLRlwYq3dqsZasV22BI6yuc1pb56oczlsmecU5B8J0oO2S1
eDC0QWwRae6E3a+fuBkQH4xdSkC9yvuqPb28maG3l1D76pKGzjcCqJmzTrfP/Mkw
2Y7X6B9wOMlI5yM33PEGw/46/l6GGPPsbuCt4CS2gvoH4QNe4pemBVSiymad0YgH
PStS7pitiKhC7czQQig1xz/b66nTw6TezYUGiV4Ie4gK1CcjLU5nWQZDxKvadpD8
TOz/EDl3p1dzfnt0IcNu8aujrn0ftLhbCJr1Mxb6yq9fVL/YzYItSlpIkVwHgcCy
GGemGnvN2xDPRY3kwihZ985hrUsrOT7+REHdbAAp3xvzyEQ7GTbjZRn3OI0D7UsS
SNGcXAAHMsHrEjqNDk3AqpDmbmEi4VIY+oYgIm7Eg/R3iQ8aHiikcQN+Wrr2a3YP
hXVNM+J1bzJVIeLGM/uEH9d+RN2a977y0LOI0SiitnlRuCqZ/gXM6amsIGUUxW0D
gu8ogvDGqgSIKorV3P/KOkTMeMICks0XaiN5lq8OKIjUqX19RQ7jONEv4X3t5puK
aQJ+VY0UBJvOwXD/2E19jCS4YZ50Pq3G2x5JnFYcj2C5ialKCIM=
=F2z7
-----END PGP SIGNATURE-----

--=-388Uc9j86g6pPFS3NL3W--
