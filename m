From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
Date: Mon, 7 Feb 2011 13:40:28 +0100
Message-ID: <AANLkTimxpRHW2TPwSnufpoeOHoEtkz1iaR3-VsC1qM4j@mail.gmail.com>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-embedded@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 7, 2011 at 13:22, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> It is very rare to find a current system which is both sufficiently
> resource constrained to want to compile out power management support
> and sufficiently power insensitive to be able to tolerate doing so.

Hmmm...

> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -1,23 +1,6 @@
> =C2=A0config PM
> - =C2=A0 =C2=A0 =C2=A0 bool "Power Management support"
> - =C2=A0 =C2=A0 =C2=A0 depends on !IA64_HP_SIM
> - =C2=A0 =C2=A0 =C2=A0 ---help---
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Power Management" means that parts of =
your computer are shut
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 off or put into a power conserving "sle=
ep" mode if they are not
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 being used. =C2=A0There are two competi=
ng standards for doing this: APM
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 and ACPI. =C2=A0If you want to use eith=
er one, say Y here and then also
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 to the requisite support below.

Good to see the PC-centric comments are going away :-)

> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 Power Management is most important for =
battery powered laptop
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 computers; if you have a laptop, check =
out the Linux Laptop home
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 page on the WWW at <http://www.linux-on=
-laptops.com/> or
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tuxmobil - Linux on Mobile Computers at=
 <http://www.tuxmobil.org/>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 and the Battery Powered Linux mini-HOWT=
O, available from
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 <http://www.tldp.org/docs.html#howto>.
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 Note that, even if you say N here, Linu=
x on the x86 architecture
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 will issue the hlt instruction if nothi=
ng is to be done, thereby
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 sending the processor to sleep and savi=
ng power.
> + =C2=A0 =C2=A0 =C2=A0 bool
> + =C2=A0 =C2=A0 =C2=A0 default y if !IA64_HP_SIM

The following architectures do not source "kernel/power/Kconfig":

alpha
cris
h8300
Kconfig
m32r
m68k
m68knommu
microblaze
parisc
score
sparc
tile
um
xtensa

Which means that (for now) I don't have to care that CONFIG_PM becomes
unclearable. Other people may care, though...

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
