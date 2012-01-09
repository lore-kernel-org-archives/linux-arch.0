From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 1/2] topology: Check for missing CPU devices
Date: Mon, 09 Jan 2012 02:52:46 +0000
Message-ID: <1326077566.4097.7.camel@deadeye>
References: <1326055714.13595.309.camel@deadeye>
	 <CA+55aFwwnJPpVY++Vgr6p3s47YjdYWV3sgLZzvCtiJp6DEu78Q@mail.gmail.com>
	 <CAFLxGvwJWrSRSNxHE620XZkc4w0ayzeqqxZOR1efkh1V+VBO1w@mail.gmail.com>
	 <CA+55aFwVnLE-DLRzS8G=8NxQZjF5M_O4kgrPoX+AOOEH-OZgog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-RKEqcBw08P14vBh4EUOt"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53128 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751467Ab2AICwx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 8 Jan 2012 21:52:53 -0500
In-Reply-To: <CA+55aFwVnLE-DLRzS8G=8NxQZjF5M_O4kgrPoX+AOOEH-OZgog@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: richard -rw- weinberger <richard.weinberger@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, Thorsten Glaser <tg@mirbsd.de>, Debian kernel team <debian-kernel@lists.debian.org>, linux-m68k@vger.kernel.org, debian-68k@lists.debian.org


--=-RKEqcBw08P14vBh4EUOt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2012-01-08 at 17:29 -0800, Linus Torvalds wrote:
> On Sun, Jan 8, 2012 at 5:06 PM, richard -rw- weinberger
> <richard.weinberger@gmail.com> wrote:
> > On Mon, Jan 9, 2012 at 1:18 AM, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >> Ok, both of the patches look sane to me, but it would really be nice
> >> to hear from somebody with the actual affected architectures, and get
> >> a tested-by.
> >
> > UML is affected:
> > https://lkml.org/lkml/2012/1/8/186
> >
> > I wasted an hour finding out why it is crashing.
> > Instead of testing kernels I really should read more LKML. ;-)
>=20
> Hmm.
>=20
> Ben - how about that
>=20
>   static DEFINE_PER_CPU(struct cpu, cpu_devices);
>=20
> approach that Richard uses in his patch, instead of the kcalloc?

That seems perfectly good.

> And
> clearly UM should also do that CONFIG_GENERIC_CPU_DEVICES thing with
> your patch.
>
> Richard - does Ben's patch work for  you too if you just add "select
> GENERIC_CPU_DEVICES" in the UM Kconfig too (Kconfig.common, probably)?

Sorry, I meant to cover UM as well but I couldn't see how its Kconfig
files were organised.

Ben.

--=20
Ben Hutchings
Life is what happens to you while you're busy making other plans.
                                                               - John Lenno=
n

--=-RKEqcBw08P14vBh4EUOt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUATwpWfue/yOyVhhEJAQrmtw/+NgIHg4M4/jyGZhq8suuOotDLW1rp4ZOT
KFPFwhmJ0O5t6aEbhkmBBWdf/NnkMMGGTolRuWNkieppSKcESJOBHoF+34eD79L6
oz4oOlaVU/z90S+Gw98/dZEktD9PnOfBr8bF4bNsh2AWPadwqeIRRhatwzk0PUHE
dyiKbW6KdtlTSiUmnmknJ9OyVkB+tTqp9eKTU0BknMCMSNRclJZcbrWsviipBMMh
N9/HlWaC0Vljn3E5HKM7VZ5segN1ktbMu8NWTDTpFXT0Cr1f3pOD1sXz3IH0l5Ii
S0+YLK2ubJRiRFAHseyS9y6qlsB9W5CGJdo+VDkFDJfQ/K8YRu4kcwqmSNbcceaI
wWoyJAt5xgTHClomLde36IkN01JX/WQ6e1Jd6V72HrRtZjO/jeT3c0wXS3W06+BP
N2itvaSBSJxlZ9JZ5hWSuCz5MwcqMqoV76mg1t2I8f0WmQZtuZbGsHQ8/gFEL9Lk
fpTBEPlQuS8QoRfX/SatZwMypfUcy67P/Nhui+2TyBCrGyotBGqBHn3LJGW/40D+
QA/XECv/umgpXLhEgB8w5GX4NmEiR9QUQtWwoQKN3DszlmIWLS00X9l+nFP5Zcj/
kdXhhiFQVEZdBFYkasJ/il4AcqxeWmBOuS0/Q3KwDa02i180w7Sr1J7EaHMLKitH
7gY3lWpxHo8=
=t+UK
-----END PGP SIGNATURE-----

--=-RKEqcBw08P14vBh4EUOt--
