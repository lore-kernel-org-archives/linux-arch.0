From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642] d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date: Fri, 29 Jan 2016 22:54:02 +0100
Message-ID: <4727572.ddrMioV3Fi@wuerfel>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com> <19656457.qoKNGRmV4Q@wuerfel> <CAMuHMdW1_of2Dw29=8VdhD0hstgvTh-CfATdLAiu5ZrwRRP77Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:59039 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756854AbcA2Vyt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2016 16:54:49 -0500
In-Reply-To: <CAMuHMdW1_of2Dw29=8VdhD0hstgvTh-CfATdLAiu5ZrwRRP77Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Fengguang Wu <fengguang.wu@intel.com>, Linux-Arch <linux-arch@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, James Hogan <james.hogan@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, linux-kbuild <linux-kbuild@vger.kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, Michal Marek <mmarek@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Friday 29 January 2016 22:24:31 Geert Uytterhoeven wrote:
> > diff --git a/arch/arm/include/debug/8250.S b/arch/arm/include/debug/8250.S
> > index 7f7446f6f806..1191b1458586 100644
> > --- a/arch/arm/include/debug/8250.S
> > +++ b/arch/arm/include/debug/8250.S
> > @@ -9,6 +9,9 @@
> >   */
> >  #include <linux/serial_reg.h>
> >
> > +#if CONFIG_DEBUG_UART_PHYS == 0xdeadbeef || CONFIG_DEBUG_UART_VIRT < 0xe0000000
> 
> Any special reason for 0xe0000000 vs ...
> 
> > --- a/arch/arm/include/debug/efm32.S
> > +++ b/arch/arm/include/debug/efm32.S
> > @@ -6,6 +6,9 @@
> >   * it under the terms of the GNU General Public License version 2 as
> >   * published by the Free Software Foundation.
> >   */
> > +#if CONFIG_DEBUG_UART_PHYS == 0xdeadbeef || CONFIG_DEBUG_UART_VIRT < 0xf0000000
> 
> 0xf0000000?

We have one platform that uses a 8250 at address 0xe0010fe0, and one using
the netx UART at virtual address 0xe0000a00, everything else uses 0xf0000000
or higher.

The 0xf0000000 address seems like a better default cutoff, because that
is close to the VMALLOC_START value for systems with 768MB of RAM or more.
Picking a lower number can easily get you in trouble here.

Now that I think about it, I guess platforms that use values above
0xfee00000 can also easily get into trouble as that conflicts with the
PCI I/O space, the fixmap or other special areas documented in
Documentation/arm/memory.txt. We have a bunch of those:

        default 0xfee003f8 if DEBUG_FOOTBRIDGE_COM1
        default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
        default 0xfee82340 if ARCH_IOP13XX
        default 0xfef00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
        default 0xfef00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
        default 0xfef36000 if DEBUG_HIGHBANK_UART
        default 0xfefb0000 if DEBUG_OMAP1UART1 || DEBUG_OMAP7XXUART1
        default 0xfefb0800 if DEBUG_OMAP1UART2 || DEBUG_OMAP7XXUART2
        default 0xfefb9800 if DEBUG_OMAP1UART3 || DEBUG_OMAP7XXUART3
        default 0xfefff700 if ARCH_IOP33X
        default 0xff003000 if DEBUG_U300_UART
        default 0xffd01000 if DEBUG_HIP01_UART

The HIP01 is the only one that looks actively dangerous here (clashes with
fixmap), the others are probably all fine but it would be nice to stay out
of that area completely.

	Arnd
