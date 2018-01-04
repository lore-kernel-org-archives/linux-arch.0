From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Fri, 5 Jan 2018 00:33:00 +0100
Message-ID: <20180104233259.GA24680@amd>
References: <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop>
 <CAPcyv4ge14OPyfoQvXHLyXwqX7cjWvm4DouUOc=WrNo1Lr9Qyw@mail.gmail.com>
 <alpine.DEB.2.20.1801040728140.2148@hadrien>
 <CAPcyv4gLcC7vsxLUCEJdEvDRf4AhgF0x1fpTEcH7AOe=kuNfoQ@mail.gmail.com>
 <20180104192648.GA10427@amd>
 <CAPcyv4g0ZEP_LuXwsf1rJGaG65UHn5sj=DMyMdCnzKD9T-vnyg@mail.gmail.com>
 <20180104224455.GA22369@amd>
 <CAPcyv4gVq=F-+8YX6ALUiL61MtOVtDzPrEo18WVsFodZ1YY20A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49928 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbeADXdC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jan 2018 18:33:02 -0500
Content-Disposition: inline
In-Reply-To: <CAPcyv4gVq=F-+8YX6ALUiL61MtOVtDzPrEo18WVsFodZ1YY20A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > What did it leak? Nothing. Attacker had to know
> > array+attacker_controlled_index, and he now knows
> > (array+attacker_controlled_index)%CACHELINE_SIZE.
> >
> > With (void) array2[val];, the attack gets interesting -- I now know
> > *(array+attacker_controlled_index) % CACHELINE_SIZE ... allowing me to
> > get information from arbitrary place in memory -- which is useful for
> > .. reading ssh keys, for example.
>=20
> Right, but how far away from "val =3D array[attacker_controlled_index];"
> in the instruction stream do you need to look before you're
> comfortable there's no 'val' dependent reads in the speculation window
> on all possible architectures. Until we have variable annotations and
> compiler help my guess is that static analysis has an easier time
> pointing us to the first potentially bad speculative access.

Well, you are already scanning for if (attacker_controlled_index <
limit) .... array[attacker_controlled_index] and those can already be
far away from each other....

Anyway, likely in the end human should be creating the patch, and if
there's no array2[val], we do not need the patch after all.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpOuasACgkQMOfwapXb+vJ3CwCdE0uzmPXT1L+DQcMFtkSoZC3L
OlMAoL/rdluf4+hii/KvspigMtaaz9rY
=Uz4A
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
