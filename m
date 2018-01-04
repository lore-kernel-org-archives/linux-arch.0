From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 21:40:00 +0100
Message-ID: <20180104204000.GD10427@amd>
References: <20180103223827.39601-1-mark.rutland@arm.com>
 <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop>
 <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
 <CAPcyv4ic=X3nMz7deg9NMyvj994+SM9XYoP0u7WvgKaAFSGAYw@mail.gmail.com>
 <alpine.LRH.2.00.1801040253410.27010@gjva.wvxbf.pm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44975 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeADUkC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jan 2018 15:40:02 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1801040253410.27010@gjva.wvxbf.pm>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > So this is in that same category, but yes, it's inconvenient.
>=20
> Disagreed, violently. CPU has to execute the instructions I ask it to=20
> execute, and if it executes *anything* else that reveals any information=
=20
> about the instructions that have *not* been executed, it's flawed.

I agree that's a flaw. Unfortunately... CPUs do execute instructions
you did not ask them to execute all the time.

Plus CPU designers forgot that cache state (and active row in DRAM) is
actually observable side-effect. ....and that's where we are today.

If you want, I have two systems with AMD Geode. One is PC. Neither is
very fast.

All the other general purpose CPUs I have -- and that includes
smartphones -- are likely out-of-order, and that means flawed.

So... situation is bad.

CPUs do execute intruction you did not ask them to execute. I don't
think that's reasonable to change.

I believe "right" fix would be for CPUs to treat even DRAM read as
side-effects, and adjust speculation accordingly. I'm not sure Intel/AMD
is going to do the right thing here.

Oh, I have an FPGA, too, if you want to play with RISC-V :-).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpOkSAACgkQMOfwapXb+vJPRgCgp2tylF7Soatf4W/Qefzl60dG
UIgAoI0XKcoFtyat3mY+/wQudW/E6G11
=lJ95
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--
