Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53595 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbeGMGlR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Jul 2018 02:41:17 -0400
Date: Fri, 13 Jul 2018 08:28:04 +0200
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH v2 25/27] x86/cet: Add PTRACE interface for CET
Message-ID: <20180713062804.GA6905@amd>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-26-yu-cheng.yu@intel.com>
 <20180711102035.GB8574@gmail.com>
 <1531323638.13297.24.camel@intel.com>
 <20180712140327.GA7810@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20180712140327.GA7810@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromiun.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20180713062804.SdFt3yV_7f-4fkDXVhTDI3hQxIcwfGmkujLrRuY17sQ@z>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > to "CET" (which is a well-known acronym for "Central European Time"),
> > > not to CFE?
> > >=20
> >=20
> > I don't know if I can change that, will find out.
>=20
> So what I'd suggest is something pretty simple: to use CFT/cft in kernel =
internal=20
> names, except for the Intel feature bit and any MSR enumeration which can=
 be CET=20
> if Intel named it that way, and a short comment explaining the acronym di=
fference.
>=20
> Or something like that.

Actually, I don't think CFT is much better -- there's limited number
of TLAs (*). "ENFORCE_FLOW"? "FLOWE"? "EFLOW"?

									Pavel

(*) Three letter accronyms.
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltIRnQACgkQMOfwapXb+vJRBACbBpRDlJCr67dR/rk3Htvd60uk
2z0AoJRrkyCatIQBwROh41c0B0Qw/Luu
=9cvN
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
