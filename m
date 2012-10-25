From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH] asm-generic/io.h: remove asm/cacheflush.h
	include
Date: Thu, 25 Oct 2012 15:40:16 +0200
Message-ID: <1351172416.6232.70.camel@jerome.southpole.se>
References: <1350984117-17369-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3131519270252712387=="
Return-path: <linux-bounces@lists.openrisc.net>
In-Reply-To: <1350984117-17369-1-git-send-email-james.hogan@imgtec.com>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Mike Frysinger <vapier@gentoo.org>, Arnd Bergmann <arnd@arndb.de>, Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, linux@lists.openrisc.net, uclinux-dist-devel@blackfin.uclinux.org, Chen Liqin <liqin.chen@sunplusct.com>, Lennox Wu <lennox.wu@gmail.com>
List-Id: linux-arch.vger.kernel.org


--===============3131519270252712387==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-DroHWeIpZkq/HMR3Q1UU"


--=-DroHWeIpZkq/HMR3Q1UU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-10-23 at 10:21 +0100, James Hogan wrote:
> Including <asm/cacheflush.h> from <asm-generic/io.h> prevents
> cacheflush.h being able to use I/O functions like readl and writel due
> to circular include dependencies. It doesn't appear as if anything from
> cacheflush.h is actually used by the generic io.h, so remove the
> include.
>=20
> I've compile tested a defconfig compilation of blackfin, openrisc (which
> needed <asm/pgtable.h> including from it's <asm/io.h> to get the PAGE_*
> definitions), and xtensa.
>=20
> Other architectures which use asm-generic/io.h are score and unicore32,
> and looking at their io.h I don't see any obvious problems.

Acked-by: Jonas Bonn <jonas@southpole.se> for OpenRISC

Who's tree should this go via.  I can take it via the openrisc tree, but
it would be good to get some Ack's that this isn't going to break things
for the other arch's (in particular score and unicore32, since they are
untested).

/Jonas

--=-DroHWeIpZkq/HMR3Q1UU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlCJQUAACgkQ70gcjN2673Mg9ACgj7RYv/dyPk9S9zHc+g4dSAhL
KpIAn0413qPWwD42ZyDGpMBjlY5nzmxf
=i/LT
-----END PGP SIGNATURE-----

--=-DroHWeIpZkq/HMR3Q1UU--


--===============3131519270252712387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3131519270252712387==--
