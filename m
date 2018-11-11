Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44235 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeKKVT0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Nov 2018 16:19:26 -0500
Date: Sun, 11 Nov 2018 12:31:03 +0100
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 04/27] x86/fpu/xstate: Add XSAVES system states for
 shadow stack
Message-ID: <20181111113103.GG27666@amd>
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
 <20181011151523.27101-5-yu-cheng.yu@intel.com>
 <20181108184038.GJ7543@zn.tnic>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nqkreNcslJAfgyzk"
Content-Disposition: inline
In-Reply-To: <20181108184038.GJ7543@zn.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20181111113103.tUZeLuS_LCOs3hPHBUEnzxrrE3kDy2WNnMUAZvSCB9k@z>


--nqkreNcslJAfgyzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > +/*
> > + * State component 12 is Control flow Enforcement kernel states
> > + */
> > +struct cet_kernel_state {
> > +	u64 kernel_ssp;	/* kernel shadow stack */
> > +	u64 pl1_ssp;	/* ring-1 shadow stack */
> > +	u64 pl2_ssp;	/* ring-2 shadow stack */
>=20
> Just write "privilege level" everywhere - not "ring".

Please just use word "ring". It is well estabilished terminology.

Which ring is priviledge level 1, given that we have SMM and
virtualization support?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--nqkreNcslJAfgyzk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvoEvcACgkQMOfwapXb+vKz1QCaAypyvDoDPjpZVCuUoaiXMZ/5
uvwAoIAkSweKPnKv96HsSHiq/rCF0eRL
=gjve
-----END PGP SIGNATURE-----

--nqkreNcslJAfgyzk--
