From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 23:44:55 +0100
Message-ID: <20180104224455.GA22369@amd>
References: <20180103223827.39601-1-mark.rutland@arm.com>
 <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop>
 <CAPcyv4ge14OPyfoQvXHLyXwqX7cjWvm4DouUOc=WrNo1Lr9Qyw@mail.gmail.com>
 <alpine.DEB.2.20.1801040728140.2148@hadrien>
 <CAPcyv4gLcC7vsxLUCEJdEvDRf4AhgF0x1fpTEcH7AOe=kuNfoQ@mail.gmail.com>
 <20180104192648.GA10427@amd>
 <CAPcyv4g0ZEP_LuXwsf1rJGaG65UHn5sj=DMyMdCnzKD9T-vnyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48713 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeADWo5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jan 2018 17:44:57 -0500
Content-Disposition: inline
In-Reply-To: <CAPcyv4g0ZEP_LuXwsf1rJGaG65UHn5sj=DMyMdCnzKD9T-vnyg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> > What should one be looking for.  Do you have a typical example?
> >> >
> >>
> >> See "Exploiting Conditional Branch Misprediction" from the paper [1].
> >>
> >> The typical example is an attacker controlled index used to trigger a
> >> dependent read near a branch. Where an example of "near" from the
> >> paper is "up to 188 simple instructions inserted in the source code
> >> between the =E2=80=98if=E2=80=99 statement and the line accessing arra=
y...".
> >>
> >> if (attacker_controlled_index < bound)
> >>      val =3D array[attacker_controlled_index];
> >> else
> >>     return error;
> >>
> >> ...when the cpu speculates that the 'index < bound' branch is taken it
> >> reads index and uses that value to read array[index]. The result of an
> >> 'array' relative read is potentially observable in the cache.
> >
> > You still need
> >
> >         (void) array2[val];
> >
> > after that to get something observable, right?
>=20
> As far as I understand the presence of array2[val] discloses more
> information, but in terms of the cpu taking an action that it is
> observable in the cache that's already occurred when "val =3D
> array[attacker_controlled_index];" is speculated. Lets err on the

Well yes, attacker can observe val =3D=20
array[attacker_controlled_index]; . But that's not something he's
interested in. So the CPU cheats and attacker has a proof. But he knew
that before.

>side
> of caution and shut down all the observable actions that are already
> explicitly gated by an input validation check. In other words, a low
> bandwidth information leak is still a leak.

What did it leak? Nothing. Attacker had to know
array+attacker_controlled_index, and he now knows
(array+attacker_controlled_index)%CACHELINE_SIZE.

With (void) array2[val];, the attack gets interesting -- I now know
*(array+attacker_controlled_index) % CACHELINE_SIZE ... allowing me to
get information from arbitrary place in memory -- which is useful for
=2E. reading ssh keys, for example.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpOrmcACgkQMOfwapXb+vKwmQCguX0I4qoID6YTQ61TQcvNzXqd
I8oAn2uz+48drfa6fJfzy9+DzvK/DylH
=8wlw
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
