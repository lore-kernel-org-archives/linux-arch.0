Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58096 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbeESTmz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 May 2018 15:42:55 -0400
Date: Sat, 19 May 2018 21:42:52 +0200
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v6 03/28] x86/asm/suspend: use SYM_DATA for data
Message-ID: <20180519194252.GB3058@amd>
References: <20180518091721.7604-1-jslaby@suse.cz>
 <20180518091721.7604-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <20180518091721.7604-4-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org
Message-ID: <20180519194252.0qa8KtCL6yiEqYkRQIAtRcluLmkhauxZ9fsR-z_Mbus@z>


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-05-18 11:16:56, Jiri Slaby wrote:
> Some global data in the suspend code were marked as `ENTRY'. ENTRY was
> intended for functions and shall be paired with ENDPROC. ENTRY also
> aligns symbols which creates unnecessary holes here between data. Since
> we are dropping historical markings, make proper use of newly added
> SYM_DATA in this code.
>=20
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsAfjwACgkQMOfwapXb+vIlcwCfYo968n8UL3BKY9XiJ9tEe76z
LmQAoJxc6Ygb55pjIpQ2Vi6xxx09Dgax
=FTtg
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
