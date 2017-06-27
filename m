From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/5] kbuild: thin archives final link close
 --whole-archives option
Date: Tue, 27 Jun 2017 17:42:35 +0200
Message-ID: <20170627154235.4a3silh5qlhnvnos@flea.lan>
References: <20170621220213.2b33d56d@roar.ozlabs.ibm.com>
 <CAK8P3a0nVPz=eLV8ET6BYR2Qs0H3PQZuhYsu4Cb_kJSPACrR9w@mail.gmail.com>
 <20170621161913.GY4493@codeaurora.org>
 <20170622040838.1c63ebb7@roar.ozlabs.ibm.com>
 <CAK8P3a2vV10+ymS7vHybfhRf_DVvACOW4O2OZzyz+v75y2Ak4w@mail.gmail.com>
 <20170622061838.ljlmk4enzpvdlyyu@flea.lan>
 <20170623015021.58f74316@roar.ozlabs.ibm.com>
 <CAK7LNATbd5n2uMsTN_jaUN+QjpB5DN3AvS+6iqqt3w3kuwQS3A@mail.gmail.com>
 <20170623145734.7pv3rdgucveg66s3@flea.lan>
 <CAK8P3a1m9teuQV-r5-753FBVtFTDsz=31bC_zeuCZ5ViBTQKRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ds7sh6hdenphovoh"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52713 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbdF0Pms (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2017 11:42:48 -0400
Content-Disposition: inline
In-Reply-To: <CAK8P3a1m9teuQV-r5-753FBVtFTDsz=31bC_zeuCZ5ViBTQKRw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Nicholas Piggin <npiggin@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <fengguang.wu@intel.com>, Josh Triplett <josh@joshtriplett.org>, Nicolas Pitre <nicolas.pitre@linaro.org>


--ds7sh6hdenphovoh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2017 at 05:04:45PM +0200, Arnd Bergmann wrote:
> On Fri, Jun 23, 2017 at 4:57 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Fri, Jun 23, 2017 at 02:31:40PM +0900, Masahiro Yamada wrote:
> >> As far as I tried,  minus MACH_SUN8I still enabled the following:
> >> CONFIG_SUNXI_CCU=3Dy
> >> CONFIG_SUNXI_CCU_DIV=3Dy
> >> CONFIG_SUNXI_CCU_FRAC=3Dy
> >> CONFIG_SUNXI_CCU_GATE=3Dy
> >> CONFIG_SUNXI_CCU_MUX=3Dy
> >> CONFIG_SUNXI_CCU_MULT=3Dy
> >> CONFIG_SUNXI_CCU_PHASE=3Dy
> >> CONFIG_SUNXI_CCU_NK=3Dy
> >> CONFIG_SUNXI_CCU_NKM=3Dy
> >> CONFIG_SUNXI_CCU_NKMP=3Dy
> >> CONFIG_SUNXI_CCU_NM=3Dy
> >> CONFIG_SUNXI_CCU_MP=3Dy
> >>
> >> I think you need to disable some more MACH_SUN*I and
> >> perhaps disable some CONFIG_SUN*I_*_CCU explicitly,
> >> then you will see difference in the result.
> >
> > Ah, right, it's all selected by the rest.
> >
> > I guess to get a meaningful example you could disable all the
> > SUN*I_CCU (SUN5I, SUN8I, and the likes) options and while keeping
> > SUN8I_R_CCU.
> >
> > Most of the clock types shouldn't be used but div and gates.
>=20
> Given that we appear to basically always pull in all (or most) of
> the CCU parts anyway, and it's hard to even test with a subset
> being disabled, I wonder how much we care about dropping
> the unused objects at all:
>=20
> Maybe the answer is that we just always build all of them into
> the kernel and make only the SoC-specific objects configurable ;-)

I was trying to avoid that, but maybe that's not worth it, and it's
our only solution.

> Once we start linking with  --gc-sections, it will all be fine anyway.

That works for me. Who wants to send the patch?

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ds7sh6hdenphovoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZUnzrAAoJEBx+YmzsjxAgd2wP/3zWkniZak/Wm2qfjOGdS9ld
tlv2iq3tTyZ7eCvbRSRCzGd8YMy58PjaN2mcGKfHlKsscEcRdTYMMp4ir2VxGy4u
TlgZEjcUZpO/VcnSnuxKUfT6W//rRMZyiWvTgpiecwcmeM2BdPOguzAPR2BomHzV
BPYd8Do4J1bD0160dorXHCll3SQXdo71NJtSLKWnkVLLcLxhftntHkv1aojb1Sf2
fBsiZNtHFTWgyQZuiQ/nWySXiciKxqWttMZHCo2mWDVad1uBSww4N+UU66Xo9yRK
CsVClb2M//YkPoRk0DJtF5dkRHgR5bRJVo9RLPPG/Ij+5zeFFE7LZyhOC5KLZImu
8LvawFcaN8MT3R/01NuEEaTN9ECl966Z2M7EpFLtaIj3dbWTzu14TkH1DNSrtktE
95skx3r1b9HH0GiIH3Sw2Rmv6aocxgJirrS9Zz7wiHQFNwaMi31XK2FMQc2iHEoZ
AjStkrwEMpcUCn6iuAjosv+WnK+MAZisZQpc9Qh6ZQJ1wzgkjY209+ZOjl6/63D/
LAwHRlza3mSHZ6VcZe4IyIsUIC5uzyINvV18+z6/giA3eXrtzhOt7lngb+yRSF3h
ss0QI5MPuvmcYbQe2Pn1cjseGwpjb0zx6pm5sbl3xFL06dmeMMoRJ98TK4ke6ro5
fuHxLudW1nvffilvgVj3
=61Ib
-----END PGP SIGNATURE-----

--ds7sh6hdenphovoh--
