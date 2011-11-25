From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH-RFC 01/10] lib: move GENERIC_IOMAP to lib/Kconfig
Date: Fri, 25 Nov 2011 09:41:09 +0100
Message-ID: <20111125084109.GS13937@axis.com>
References: <cover.1322163031.git.mst@redhat.com> <5aed7b7e1dbc8a50ebd6986245df8054fd05b7cd.1322163031.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <5aed7b7e1dbc8a50ebd6986245df8054fd05b7cd.1322163031.git.mst@redhat.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mikael Starvik <starvik@axis.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Jonas Bonn <jonas@southpole.se>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Chen Liqin <liqin.chen@sunplusct.com>, Lennox Wu <lennox.wu@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Da
List-Id: linux-arch.vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2011 at 09:15:42PM +0100, Michael S. Tsirkin wrote:
> define GENERIC_IOMAP in a central location
> instead of all architectures. This will be helpful
> for the follow-up patch which makes it select
> other configs. Code is also a bit shorter this way.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

For the CRIS part:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
--=20
               Jesper Nilsson -- jesper.nilsson@axis.com

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk7PVKUACgkQ31LbvUHyf1e75ACePpPqRaa0/hcY5Pc6jHLp11KX
g3oAn37y5BAjmjOjjeqo5aGJkxBrHR5C
=GpXx
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
