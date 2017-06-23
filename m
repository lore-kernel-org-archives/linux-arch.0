From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/5] kbuild: thin archives final link close
 --whole-archives option
Date: Fri, 23 Jun 2017 16:57:34 +0200
Message-ID: <20170623145734.7pv3rdgucveg66s3@flea.lan>
References: <20170621211002.44525d9b@roar.ozlabs.ibm.com>
 <CAK8P3a2A9fMrNZPWJft2t+52kmGkGgm3gv_fxJntjevWtJ69Zw@mail.gmail.com>
 <20170621220213.2b33d56d@roar.ozlabs.ibm.com>
 <CAK8P3a0nVPz=eLV8ET6BYR2Qs0H3PQZuhYsu4Cb_kJSPACrR9w@mail.gmail.com>
 <20170621161913.GY4493@codeaurora.org>
 <20170622040838.1c63ebb7@roar.ozlabs.ibm.com>
 <CAK8P3a2vV10+ymS7vHybfhRf_DVvACOW4O2OZzyz+v75y2Ak4w@mail.gmail.com>
 <20170622061838.ljlmk4enzpvdlyyu@flea.lan>
 <20170623015021.58f74316@roar.ozlabs.ibm.com>
 <CAK7LNATbd5n2uMsTN_jaUN+QjpB5DN3AvS+6iqqt3w3kuwQS3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="33cog44uo5eg5a2w"
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNATbd5n2uMsTN_jaUN+QjpB5DN3AvS+6iqqt3w3kuwQS3A@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@codeaurora.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <fengguang.wu@intel.com>, Josh Triplett <josh@joshtriplett.org>, Nicolas Pitre <nicolas.pitre@linaro.org>
List-Id: linux-arch.vger.kernel.org


--33cog44uo5eg5a2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2017 at 02:31:40PM +0900, Masahiro Yamada wrote:
> Hi Nicholas,
>=20
> 2017-06-23 0:50 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> > On Thu, 22 Jun 2017 08:18:38 +0200
> > Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> >
> >> On Wed, Jun 21, 2017 at 10:55:06PM +0200, Arnd Bergmann wrote:
> >> > On Wed, Jun 21, 2017 at 8:08 PM, Nicholas Piggin <npiggin@gmail.com>=
 wrote:
> >> > > On Wed, 21 Jun 2017 09:19:13 -0700
> >> > > Stephen Boyd <sboyd@codeaurora.org> wrote:
> >> > >> On 06/21, Arnd Bergmann wrote:
> >> > >>
> >> > >> Ok. Can you send a revert patch to the list with some information
> >> > >> on why we can't do the hack anymore and also Cc lkml/kbuild
> >> > >> lists? The commit is in linux-next now as commit 06e226c7fb23
> >> > >> (clk: sunxi-ng: Move all clock types to a library, 2017-06-02).
> >> > >>
> >> > >
> >> > > I grabbed this patch and applied it to the kbuid/thin-ac tree. I t=
ested
> >> > > with thin archives enabled and disabled with arm defconfig which e=
nds up
> >> > > setting CONFIG_SUNXI_CCU=3Dy.
> >> > >
> >> > > The patch makes no difference to vmlinux size whether using tradit=
ional
> >> > > incremental link, or thin archives (there is a small difference be=
tween
> >> > > inclink and thinarc but that's unrelated).
> >> > >
> >> > > So this thin archives change does not break your patch, it's just =
that
> >> > > it doesn't really do the right thing. I like the general idea, but=
 we
> >> > > need to work out how to make it properly supported by the build sy=
stem.
> >> > >
> >> > > With the patch applied, this is what the build system currently do=
es:
> >> > >
> >> > > arm-linux-gnueabihf-ld -EL    -r -o drivers/clk/sunxi-ng/built-in.=
o drivers/clk/sunxi-ng/ccu-sun5i.o drivers/clk/sunxi-ng/ccu-sun6i-a31.o dri=
vers/clk/sunxi-ng/ccu-sun8i-a23.o drivers/clk/sunxi-ng/ccu-sun8i-a33.o driv=
ers/clk/sunxi-ng/ccu-sun8i-h3.o drivers/clk/sunxi-ng/ccu-sun8i-v3s.o driver=
s/clk/sunxi-ng/ccu-sun8i-r.o drivers/clk/sunxi-ng/ccu-sun9i-a80.o drivers/c=
lk/sunxi-ng/ccu-sun9i-a80-de.o drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.o dri=
vers/clk/sunxi-ng/lib.a drivers/clk/sunxi-ng/lib-ksyms.o
> >> > >
> >> > > This incremental link pulls in all your lib.a objects and links th=
em
> >> > > into built-in.o. They can no longer be selectively linked.
> >> >
> >> > I think the ARM defconfig actually needs all those objects because it
> >> > enables all the high-level drivers. You could try disabling e.g. all=
 except
> >> > CONFIG_SUN8I_DE2_CCU if you want the objects to actually becomes
> >> > unused.
> >>
> >> You can also disable MACH_SUN8I, it should disable a significant
> >> number of the clocks driver.
> >
> >    text    data     bss     dec     hex filename
> > 11655078        6018736  418944 18092758        11412d6 vmlinux.inclink
> > 11655078        6018736  418944 18092758        11412d6 vmlinux.inclink=
=2Eclk
> > 11650534        6010288  418616 18079438        113dece vmlinux.thinarc
> > 11650534        6010288  418616 18079438        113dece vmlinux.thinarc=
=2Eclk
> >
> > Same result for me when compiling defconfig minus MACH_SUN8I, comparing
> > +/- the clock patch and thin archives. No size savings. As I explained
> > already, I really can't see how there could be any saving if the lib.a =
is
> > incrementally linked into built-in.o.
>=20
> I think defconfig minus MACH_SUN8I
> will give no difference to CONFIG_SUNXI_CCU*
>=20
> As far as I tried,  minus MACH_SUN8I still enabled the following:
> CONFIG_SUNXI_CCU=3Dy
> CONFIG_SUNXI_CCU_DIV=3Dy
> CONFIG_SUNXI_CCU_FRAC=3Dy
> CONFIG_SUNXI_CCU_GATE=3Dy
> CONFIG_SUNXI_CCU_MUX=3Dy
> CONFIG_SUNXI_CCU_MULT=3Dy
> CONFIG_SUNXI_CCU_PHASE=3Dy
> CONFIG_SUNXI_CCU_NK=3Dy
> CONFIG_SUNXI_CCU_NKM=3Dy
> CONFIG_SUNXI_CCU_NKMP=3Dy
> CONFIG_SUNXI_CCU_NM=3Dy
> CONFIG_SUNXI_CCU_MP=3Dy
>=20
> I think you need to disable some more MACH_SUN*I and
> perhaps disable some CONFIG_SUN*I_*_CCU explicitly,
> then you will see difference in the result.

Ah, right, it's all selected by the rest.

I guess to get a meaningful example you could disable all the
SUN*I_CCU (SUN5I, SUN8I, and the likes) options and while keeping
SUN8I_R_CCU.

Most of the clock types shouldn't be used but div and gates.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--33cog44uo5eg5a2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZTSxeAAoJEBx+YmzsjxAg6FoQAIa5kTABMrQsVQiWZKzQxBh0
qeBuCuv7ijrRP1UrhGQLFwo4ezrWxLdDoJ8W0zox6sKuZwpfqQlmamDk/sfUWNJl
WoV/+HeAvCdEVZHDAzkLpH75i1EpEQCzjGgJ99sj7khe0nYBaMoMVpgp9BJZS9uM
09cckDBn9CgpIl5ifeG4LN4j8j0RlwJMklxWeG0IReBpUShMK2ybIx6mmrULqd8S
odkl20UMvfAIkXRA4SlX/PoIoqWKcpkqvQfSRCFN/RMDXr0H8IbEAWvq66jKYTJ+
2z+dqMWTi4K1WJ6wRgmXFu7P8YtaLlM5XQrw3CQnmOd4nX5OiQV9ZquMKcuy6U5B
MH6BLy1Tq/DxzU90aqD0Q9T0V57wY1K6ytEOieVe6fMERg7OHG+HIFh1Fv2b42pN
vbm2F1P2sTG5IsYOHT60gAdBoEV2W+DKunxY+CohXVo+fQBAZYLTIJuUWUeimja8
xlbNwjZoMjuojnlbBVr8OnQicSEXtvnkrDApd0FpFyYp5tx2Gu7kWaF0z/ZVKPGe
HcjGKOARHUpeHMBLkHTNMCxM4L6SJeYSU6X6VWk8+mq0J8nV0H9gBI22dCLbpoVe
p9n5pis2O2omxViBx48m4bIKNu4A0y1DEqb3RED98ccrjgPMEkyo+RoQX4ofF58Y
ysjyv0MOG/9NcR6BlkFO
=atQP
-----END PGP SIGNATURE-----

--33cog44uo5eg5a2w--
