From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Add ARCH_MIGHT_HAVE_VGA_CONSOLE
Date: Mon, 02 Feb 2015 21:11:50 +0100
Message-ID: <3429563.4px2PR9Zmy@wuerfel>
References: <877fw093oa.wl-ysato@users.sourceforge.jp> <CAMuHMdV8hyDWwz8V5rvrthcV8NyNk4J+9Opmxt3opqi5rtQoJw@mail.gmail.com> <87pp9s48mz.wl-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:55712 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762AbbBBULz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Feb 2015 15:11:55 -0500
In-Reply-To: <87pp9s48mz.wl-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Tuesday 03 February 2015 00:48:20 Yoshinori Sato wrote:
> At Mon, 2 Feb 2015 09:10:06 +0100,
> Geert Uytterhoeven wrote:
> > 
> > Hi Sato-san,
> > 
> > 
> > On Mon, Feb 2, 2015 at 8:24 AM, Yoshinori Sato
> > <ysato@users.sourceforge.jp> wrote:
> > > The dependence of VGA_CONSOLE is complicated.
> > > We need clean up.
> > 
> > Thanks!
> > 
> > > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > >
> > > ---
> > >  arch/alpha/Kconfig            | 1 +
> > >  arch/arc/Kconfig              | 1 +
> > >  arch/arm/Kconfig              | 1 +
> > >  arch/c6x/Kconfig              | 1 +
> > >  arch/hexagon/Kconfig          | 1 +
> > >  arch/ia64/Kconfig             | 1 +
> > >  arch/m32r/Kconfig             | 1 +
> > >  arch/metag/Kconfig            | 1 +
> > >  arch/microblaze/Kconfig       | 1 +
> > >  arch/mips/Kconfig             | 1 +
> > >  arch/nios2/Kconfig            | 1 +
> > >  arch/openrisc/Kconfig         | 1 +
> > >  arch/powerpc/Kconfig          | 1 +
> > >  arch/s390/Kconfig             | 1 +
> > >  arch/score/Kconfig            | 1 +
> > >  arch/tile/Kconfig             | 1 +
> > >  arch/um/Kconfig.common        | 1 +
> > >  arch/unicore32/Kconfig        | 1 +
> > >  arch/x86/Kconfig              | 1 +
> > >  arch/xtensa/Kconfig           | 1 +
> > 
> > While I know you just kept the existing logic from
> > drivers/video/console/kconfig,
> > I doubt all of the architectures listed above do support VGA.
> > I guest most of them were just too lazy to update the dependency list.
> > 
> > I think only alpha, arm, ia64, mips, powerpc, and x86 can have VGA.

The list looks right to me too. We could be more specific in case of ARM,
MIPS and PowerPC and move the symbols into the individual platforms that
do support it, but it's fine to leave this up to the architecture
maintainers.

> Hmm...
> If require, Add this flag.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Please add this patch to your series with my Reviewed-by line added.

except for one thing:

> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -76,6 +76,7 @@ config ARM
>        select PERF_USE_VMALLOC
>        select RTC_LIB
>        select SYS_SUPPORTS_APM_EMULATION
>+       select ARCH_MIGHT_HAVE_VGA_CONSOLE if ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER
>        # Above selects are sorted alphabetically; please add new ones
>        # according to that.  Thanks.
>        help

You did not read the comment in the patch context: This list of selects is
sorted alphabetically in order to avoid merge conflicts. Please keep it this
way.

Thanks,

	Arnd
