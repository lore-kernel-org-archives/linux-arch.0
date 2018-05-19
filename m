From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v6 02/28] x86/asm/suspend: drop ENTRY from local data
Date: Sat, 19 May 2018 21:42:35 +0200
Message-ID: <20180519194235.GA3058@amd>
References: <20180518091721.7604-1-jslaby@suse.cz>
 <20180518091721.7604-3-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180518091721.7604-3-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-05-18 11:16:55, Jiri Slaby wrote:
> ENTRY was intended for functions and shall be paired with ENDPROC.
> ENTRY also aligns symbols which creates unnecessary holes here between
> data.
>=20
> So drop ENTRY from saved_eip in wakeup_32 and many saved_* in wakeup_64,
> as these symbols are local only.
>=20
> We could use SYM_DATA_LOCAL for these symbols, but it was discouraged
> earlier [1].
>=20
> [1] https://lkml.org/lkml/2017/4/27/244
>=20
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsAfisACgkQMOfwapXb+vJN+gCgi6w02foFsu6Vm9cdugbPgdVl
5fUAnijCvo6E28F8/GTFkRTmPKy031TJ
=AUDI
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
