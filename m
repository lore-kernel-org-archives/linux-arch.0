From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/5] kbuild: thin archives final link close
 --whole-archives option
Date: Thu, 22 Jun 2017 08:18:38 +0200
Message-ID: <20170622061838.ljlmk4enzpvdlyyu@flea.lan>
References: <CAK8P3a0NT42HKOU+ZDRg_-1hA+RzYnL0RtzqbMsLbY=yTUxGRA@mail.gmail.com>
 <20170621203824.719ffdc5@roar.ozlabs.ibm.com>
 <CAK8P3a1o91guXimc99sY3UOUjKTX5QxhQyOfY+j-x7MMCdRbdw@mail.gmail.com>
 <20170621211002.44525d9b@roar.ozlabs.ibm.com>
 <CAK8P3a2A9fMrNZPWJft2t+52kmGkGgm3gv_fxJntjevWtJ69Zw@mail.gmail.com>
 <20170621220213.2b33d56d@roar.ozlabs.ibm.com>
 <CAK8P3a0nVPz=eLV8ET6BYR2Qs0H3PQZuhYsu4Cb_kJSPACrR9w@mail.gmail.com>
 <20170621161913.GY4493@codeaurora.org>
 <20170622040838.1c63ebb7@roar.ozlabs.ibm.com>
 <CAK8P3a2vV10+ymS7vHybfhRf_DVvACOW4O2OZzyz+v75y2Ak4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="htz6dluaznhgng5h"
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2vV10+ymS7vHybfhRf_DVvACOW4O2OZzyz+v75y2Ak4w@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <fengguang.wu@intel.com>, Josh Triplett <josh@joshtriplett.org>, Nicolas Pitre <nicolas.pitre@linaro.org>
List-Id: linux-arch.vger.kernel.org


--htz6dluaznhgng5h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2017 at 10:55:06PM +0200, Arnd Bergmann wrote:
> On Wed, Jun 21, 2017 at 8:08 PM, Nicholas Piggin <npiggin@gmail.com> wrot=
e:
> > On Wed, 21 Jun 2017 09:19:13 -0700
> > Stephen Boyd <sboyd@codeaurora.org> wrote:
> >> On 06/21, Arnd Bergmann wrote:
> >>
> >> Ok. Can you send a revert patch to the list with some information
> >> on why we can't do the hack anymore and also Cc lkml/kbuild
> >> lists? The commit is in linux-next now as commit 06e226c7fb23
> >> (clk: sunxi-ng: Move all clock types to a library, 2017-06-02).
> >>
> >
> > I grabbed this patch and applied it to the kbuid/thin-ac tree. I tested
> > with thin archives enabled and disabled with arm defconfig which ends up
> > setting CONFIG_SUNXI_CCU=3Dy.
> >
> > The patch makes no difference to vmlinux size whether using traditional
> > incremental link, or thin archives (there is a small difference between
> > inclink and thinarc but that's unrelated).
> >
> > So this thin archives change does not break your patch, it's just that
> > it doesn't really do the right thing. I like the general idea, but we
> > need to work out how to make it properly supported by the build system.
> >
> > With the patch applied, this is what the build system currently does:
> >
> > arm-linux-gnueabihf-ld -EL    -r -o drivers/clk/sunxi-ng/built-in.o dri=
vers/clk/sunxi-ng/ccu-sun5i.o drivers/clk/sunxi-ng/ccu-sun6i-a31.o drivers/=
clk/sunxi-ng/ccu-sun8i-a23.o drivers/clk/sunxi-ng/ccu-sun8i-a33.o drivers/c=
lk/sunxi-ng/ccu-sun8i-h3.o drivers/clk/sunxi-ng/ccu-sun8i-v3s.o drivers/clk=
/sunxi-ng/ccu-sun8i-r.o drivers/clk/sunxi-ng/ccu-sun9i-a80.o drivers/clk/su=
nxi-ng/ccu-sun9i-a80-de.o drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.o drivers/=
clk/sunxi-ng/lib.a drivers/clk/sunxi-ng/lib-ksyms.o
> >
> > This incremental link pulls in all your lib.a objects and links them
> > into built-in.o. They can no longer be selectively linked.
>=20
> I think the ARM defconfig actually needs all those objects because it
> enables all the high-level drivers. You could try disabling e.g. all exce=
pt
> CONFIG_SUN8I_DE2_CCU if you want the objects to actually becomes
> unused.

You can also disable MACH_SUN8I, it should disable a significant
number of the clocks driver.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--htz6dluaznhgng5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZS2E+AAoJEBx+YmzsjxAgLB4P/A0t6JpC3nBvlrbc2T0XQTeF
Ba3V6qjSNkMvf0L/nVplXMpkYU4AygVP84+jFsWOA1J9J0l9dL3Xq/1CP80aSmfR
wsCWc0soM2POYI+owky255dz5Ydi+tFo61W/1Yc6ksTKEnWLB/wtEyXEmqCftyIM
1q3njHMJ7ptZXKnAX1q1dteVBddTBju6P7WFUqCJ8aSYG+DU/QZoHNkmcbpSRddt
8k8343xeo32ZgIOduIxX8po8u6X0QSvzfWiLqED3ewD/wjS/v1gtRWPa4hv++j7H
yN9cdxE/LAkgMD1aJ8S4hGOY5Ee0Y4Fi87Cznul3Mr3YcAq9SlH9c9CLZ6RavnJi
TKLcLGoDYytl9QJJUFR6SFN9m67zEBbteZqxEFtb9TmEj0TMJBtgj2c4cGGqEBg4
OrELCYmlou+NcycciyFilyP5JwEpiAwqmd3dXPDRM9AK/0YM6lY+KPhQbv6HBWyw
EgZEQg6GMMWe3ldJkPEzeMS0HFQfssX7daXedwpA8ZRBQIdapqMKMiLY1olwIe6c
hcF7ScdydR0v4S0Eq2DKOvamAuD0rTADHYjhwE08syrK6Q5Vk6kpegewonJleBvQ
E2x8s287sjYDskj21D5VzPhbv5hDYiwLavQmPWWo3FlZ6oPFQPWqarGbOrzf2uex
zoX4MOrxop4LyAUJ27nB
=J5+f
-----END PGP SIGNATURE-----

--htz6dluaznhgng5h--
