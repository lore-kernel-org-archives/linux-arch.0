From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] parisc: fix tracing of signals
Date: Fri, 12 Feb 2010 18:58:54 -0500
Message-ID: <201002121859.00083.vapier@gentoo.org>
References: <20100212155306.GI24051@bombadil.infradead.org> <alpine.LFD.2.00.1002120816100.7792@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1283464.y4TUGDY5zy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:53209 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755850Ab0BLX66 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 12 Feb 2010 18:58:58 -0500
In-Reply-To: <alpine.LFD.2.00.1002120816100.7792@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kyle McMartin <kyle@mcmartin.ca>, linux-parisc@vger.kernel.org, roland@redhat.com, "David S. Miller" <davem@davemloft.net>, Paul Mundt <lethal@linux-sh.org>, linux-arch@vger.kernel.org

--nextPart1283464.y4TUGDY5zy
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 12 February 2010 11:21:33 Linus Torvalds wrote:
> On Fri, 12 Feb 2010, Kyle McMartin wrote:
> > Mike Frysinger pointed out that calling tracehook_signal_handler with
> > stepping=3D0 missed testing the thread flags, resulting in not calling
> > ptrace_notify. Fix this by testing if we're single stepping or branch
> > stepping and setting the flag accordingly.
> >
> > Tested, seems to work.
>=20
> Hmm. All other architectures either pass in zero, or test TIF_SINGLESTEP.
>=20
> I guess TIF_BLOCKSTEP is a parisc addition, so now parisc matches x86 and
> power etc, but it still makes me wonder about all those other
> architectures that pass in zero.
>=20
> For the curious, that seems to be at least sparc and 64-bit (but not
> 32-bit) sh.
>=20
> David? Paul?

David said that the sparc code is currently correct as hardware single=20
stepping is not supported:
http://lkml.org/lkml/2010/2/11/385
=2Dmike

--nextPart1283464.y4TUGDY5zy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAABAgAGBQJLdetEAAoJEEFjO5/oN/WB/ZcP+wW7nGfC+LfOphhuJC/Bm/4M
h83QD3eS6EpX8ekGGHt5HYEvAPzRqfUiZRUStTxJ3gyWJty7UR81tNmj8Fq4Q4u3
bpjsJ9D0CTYsRTXGofbjxtng6fdO2XZIS9O511XMNoFvmij7FXkZhPzpK3XXTPeE
auBJ3tC9PwrTbo7I+o9mDPGYg1YMT7bcZrFBLrx2AGRG06yTbeaPqwaeNPL9QZrJ
JNHN7chpXf/cxgGdAyZuyivBRCkFfche9hjNngRQVaRkayqwukCuqYR2xiGCqMJ1
nSmmodugKCt1D1ZKvrDYMNitUY1DYs1dF96lRzbJ8g9SvhzghLmULRbOZvlGOjFn
tJ1VkeMUXLU2vBYz2k9F/Bac7dpqMXM3tRQXf0wIH2Dm9ZIpUlMo43p9e0RRNhsz
UT7h8ggxgmvG/h8KTyWH/FS7lA7UI3iLFSjTl3DklBtJnwvGYlhqtE1QGwXO6Eqx
dCez9nt9HLsMsS20DApsz2D200dnZ1xpdtu00bjb33Zlw2ogc7pOT/c3itbcmCg+
FYoeAH2jlf4rDqil0n7aWH/rDDq3wusFRTRnYAoIgPU02/t4NYqxsF2bmYAFbecy
CATSiToA4VEin6dFz5/HVDddDb3cVG9eBcGfh3lvmJysNf7zwsKf7NafuXEwgiJH
TYAhKxVbaLxmKDRRa22l
=a93F
-----END PGP SIGNATURE-----

--nextPart1283464.y4TUGDY5zy--
