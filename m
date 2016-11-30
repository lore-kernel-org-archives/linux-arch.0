From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported
 from asm
Date: Wed, 30 Nov 2016 21:33:01 +0000
Message-ID: <1480541581.16599.78.camel@decadent.org.uk>
References: <20161129131922.GA31466@angband.pl>
         <20161129135118.24696-1-kilobyte@angband.pl>
         <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
         <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com>
         <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
         <20161129195721.GI2697@decadent.org.uk>
         <CA+55aFyQko0t8oMZjhnwhWHrmBUyWjGhsnT=oUOU-W7_04xdzw@mail.gmail.com>
         <20161201051852.28dc335f@roar.ozlabs.ibm.com>
         <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-klxXsQwT7KIXqD7n2dRN"
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


--=-klxXsQwT7KIXqD7n2dRN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2016-11-30 at 10:40 -0800, Linus Torvalds wrote:
> > On Wed, Nov 30, 2016 at 10:18 AM, Nicholas Piggin <npiggin@gmail.com> w=
rote:
> >=20
> > Here's an initial rough hack at removing modversions. It gives an idea
> > of the complexity we're carrying for this feature (keeping in mind most
> > of the lines removed are generated parser).
>=20
> You definitely don't have to try to convince me. We've had many issues
> with modversions over the years. This was just the "last drop" as far
> as I'm concerned, we've had random odd crc generation failures due to
> some build races too.
>=20
> > In its place I just added a simple config option to override vermagic
> > so distros can manage it entirely themselves.
>=20
> So at least Fedora doesn't even enable CONFIG_MODVERSIONS as-is. I'm
> _hoping_ it's just Debian that wants this,

The last time I looked, RHEL and SLE did.  They change the release
string for each new kernel version, but they will copy/link old out-of-
tree modules into the new version's "weak-updates" module subdirectory
if the symbol versions still match.

> and we'd need to get some
> input from the Debian people whether that "control vermagic" is
> sufficient? I suspect it isn't, but I can't come up with any simple
> alternate model either..

Allowing the vermagic to be changed separately doesn't help us, as we
already control the release string.  If we were to change some of the
module tools to consider vermagic then it would allow us to report the
full version in the release string while not forcing rebuilds on every
kernel upgrade - but that's not a pressing problem.

One thing that could work for us would be:

- Stricter version matching for in-tree modules (maybe some extra
  part in vermagic that is skipped for out-of-tree modules)
- Ability to blacklist use of a symbol, or all symbols in a module,
  by out-of-tree modules

where the blacklist would be a matter of distribution policy.  But this
would still require a fair amount of work by someone, and I doubt you'd
want this upstream.

> I'm also somewhat surprised that it's Debian that has this problem,
> considering how Debian is usually the distro that is _least_ receptive
> to various non-free binaries.

If this was just about non-free modules I wouldn't care.  There are
also many freely licenced out-of-tree modules that for various reasons
don't get submitted or accepted upstream; also backports of new or
updated drivers.

Ben.

--=20
Ben Hutchings
Never attribute to conspiracy what can adequately be explained by
stupidity.


--=-klxXsQwT7KIXqD7n2dRN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlg/RY0ACgkQ57/I7JWG
EQnN2hAAkVAd5Bm3CKx6+QapANdGcirkRHA8kPIUpXF2Nfe0VT+DPvyAz7C8m9BV
qRxEQaA6ryCApf0HQuw5j0mgaAEQOkFSU6ScKhb9Jnziuz0BFpeQdenolDIhyNvh
ZL/He7GnoPU9xVi86OYVk5TupiVEeKH+5CNTmPytXiYjibeCt/CwPGele1HR7Qra
VhnzVH/P6OxD4bcUso/2BPB7upYqcSIvOvaQNLtxHCv6UTUF7mDCVSeu2Z4R34d4
6YG1lU6gUtC3R8mD67GGRQlIDV+vZCQKGhnjRnEbd6hm1UCwcF67LxqyCZwldFAh
vFHVgv+ZWNu0ma8TuIjQz7XlO462Mfg+IjL+ZIQwsXNTYcmuv/NMqRR40otUYv00
rltdS14ByLUl9ccTYpuIlzLmH2nlJs0RyZJB1BjE3KCmmo8JffseOhhsGTSBjwiM
Oh51EtzVh3c+1zMscyBvjQgNnyy1M0TCIHLdjY1ljyAdGsTM3Wrvpv4yaI+Dlana
y0E3nHrJg67m4RpGjnOYBM/huEQ00nAabOKz0lc36HWFDT3+FJ+uuZYdPvaRiZI/
szoQmKWUfmmlnzC1B7WHhILJ281nvhSTSPlljnjpdQ0pEzg0CVpImLRWI9QqNSDJ
vkmEOxG6bntWJlf47Kxio0vJg9WG9BfyKvnvgZezizVWef1eqaM=
=5O1q
-----END PGP SIGNATURE-----

--=-klxXsQwT7KIXqD7n2dRN--
