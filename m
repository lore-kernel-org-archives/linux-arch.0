From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported
 from asm
Date: Thu, 01 Dec 2016 02:35:54 +0000
Message-ID: <1480559754.16599.92.camel@decadent.org.uk>
References: <20161129131922.GA31466@angband.pl>
	 <20161129135118.24696-1-kilobyte@angband.pl>
	 <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
	 <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com>
	 <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
	 <20161129195721.GI2697@decadent.org.uk>
	 <CA+55aFyQko0t8oMZjhnwhWHrmBUyWjGhsnT=oUOU-W7_04xdzw@mail.gmail.com>
	 <20161201051852.28dc335f@roar.ozlabs.ibm.com>
	 <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
	 <1480541581.16599.78.camel@decadent.org.uk>
	 <20161201125545.406d092c@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-m5/LqilhEeEFnUOXnXZo"
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
In-Reply-To: <20161201125545.406d092c@roar.ozlabs.ibm.com>
Resent-Message-ID: <vQJxCkRv3wP.A.l0C.my4PYB@bendel>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/1480559754.16599.92.camel@decadent.org.uk
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


--=-m5/LqilhEeEFnUOXnXZo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2016-12-01 at 12:55 +1100, Nicholas Piggin wrote:
> On Wed, 30 Nov 2016 21:33:01 +0000
> > Ben Hutchings <ben@decadent.org.uk> wrote:
>=20
> > On Wed, 2016-11-30 at 10:40 -0800, Linus Torvalds wrote:
> > > > On Wed, Nov 30, 2016 at 10:18 AM, Nicholas Piggin <npiggin@gmail.co=
m> wrote:
> > > >=20
> > > > Here's an initial rough hack at removing modversions. It gives an i=
dea
> > > > of the complexity we're carrying for this feature (keeping in mind =
most
> > > > of the lines removed are generated parser).=C2=A0=C2=A0
> > >=20
> > > You definitely don't have to try to convince me. We've had many issue=
s
> > > with modversions over the years. This was just the "last drop" as far
> > > as I'm concerned, we've had random odd crc generation failures due to
> > > some build races too.
> > > =C2=A0=C2=A0
> > > > In its place I just added a simple config option to override vermag=
ic
> > > > so distros can manage it entirely themselves.=C2=A0=C2=A0
> > >=20
> > > So at least Fedora doesn't even enable CONFIG_MODVERSIONS as-is. I'm
> > > _hoping_ it's just Debian that wants this,=C2=A0=C2=A0
> >=20
> > The last time I looked, RHEL and SLE did.=C2=A0=C2=A0They change the re=
lease
> > string for each new kernel version, but they will copy/link old out-of-
> > tree modules into the new version's "weak-updates" module subdirectory
> > if the symbol versions still match.
> >=20
> > > and we'd need to get some
> > > input from the Debian people whether that "control vermagic" is
> > > sufficient? I suspect it isn't, but I can't come up with any simple
> > > alternate model either..=C2=A0=C2=A0
> >=20
> > Allowing the vermagic to be changed separately doesn't help us, as we
> > already control the release string.=C2=A0=C2=A0If we were to change som=
e of the
> > module tools to consider vermagic then it would allow us to report the
> > full version in the release string while not forcing rebuilds on every
> > kernel upgrade - but that's not a pressing problem.
>=20
> Okay, but existing modversions AFAIKS does not solve your problems descri=
bed
> in yor your earlier mail either. Modversions hardly catches ABI breakage =
at
> all, you can't rely on it that way. It's far more likely that some struct=
ure
> size changes deep in the kernel than an exported function type signature
> changes.

As I understand it, genksyms incorporates the definitions of a
function's parameter and return types - not just their names - and all
the types they refer to, recursively.  So a structure size change
should change the version of all functions where the function and its
caller pass that structure between them, however indirectly.  It finds
such indirect ABI breakage for me fairly regularly, though of course I
don't know that it finds everything.

> I'm not sure how you know which exports are used only by in-tree modules
> and which are used out of tree, but if you know that then you can version
> them manually as we said by adding _v2 in the rare case you need to chang=
e
> a behaviour.

That's fine for individual functions.

> So I'm still having trouble understanding what modversions is giving you.

Where there is a family of driver modules (e.g. foo-core, foo-pci, foo-
usb), a structure change can change all exports from foo-core.  That
ABI is of no use to out-of-tree drivers so we don't care about keeping
it stable, but we do care about preventing an accidental mismatch.

> > One thing that could work for us would be:
> >=20
> > - Stricter version matching for in-tree modules (maybe some extra
> > =C2=A0 part in vermagic that is skipped for out-of-tree modules)
> > - Ability to blacklist use of a symbol, or all symbols in a module,
> > =C2=A0 by out-of-tree modules
> >=20
> > where the blacklist would be a matter of distribution policy.=C2=A0=C2=
=A0But this
> > would still require a fair amount of work by someone, and I doubt you'd
> > want this upstream.
>=20
> I don't think people are adverse to carrying some upstream complexity for
> ditsros. Although for this fancy blacklist case, can it just be done in
> userspace?

Since the kernel does the symbol lookup and version matching,=C2=A0I'm not
sure what userland can do about it.

Ben.

--=20
Ben Hutchings
A free society is one where it is safe to be unpopular. - Adlai
Stevenson


--=-m5/LqilhEeEFnUOXnXZo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlg/jIoACgkQ57/I7JWG
EQm+dxAAod1rGl6PvaZgFGlcEgk63g8J0Ny/1sWBYX/9Yo3S6OygBXARLN6zZbe5
d55rRqhBOqv8X9kOuxMoBmtC6G8/5h/8OXnfIaA5KBqeJ0UcvBDUsw9btk7d4uOJ
p5hSNDnqOtz192n/UlOrId78xpsdKZwZ6Iq6Tz/N40LhX3nnbxSSsm33Qs2BfLX0
HGE3YtoVlCDeYCKZdHFeA2xS4fygNP69mGVFSkXn9OSXO/b+zly/DSIs1dhcG+Yn
k060yTGRB3oFOcpxQ7fG5AbXq1ZxQepiMOtBGc1+x+94k93BvEMv99LqO6rOsBA/
suCY0Xz7XjqHsJJSU1oP5DxGtFQxGdX55lZ0wgFpl97pQTSbhdpqsnlSDt5FRj1y
FpojnFitozgPiYD1RmyRUNugW7FbqzpBjRznlMhD1JkOZOuKjqcxUMdfOVKya75t
JBKh8HBV0woAB/x2Ieo2dIFJG5idcs7HusmjiEK9xt/zKBmKOk1pbqGFrY1oxWmV
ne+bp7yEcq/vtfLnN8l9ac7uaBnVB44z1OLEs7CA+3JQ/302HLLgE3jTtv79dN5s
9QU6h+y4qK18r92I7Hv8sOI41df1l3TyuP43HJq3+j683HiaaP/FOfm3DpB22/xu
FGAfEKocuem1hFIrMrS3sLamKsBGURh2qkWnw3+ZXBj3gHIOmKA=
=doA7
-----END PGP SIGNATURE-----

--=-m5/LqilhEeEFnUOXnXZo--
