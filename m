From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 32/40] i8042: don't build on METAG
Date: Fri, 16 Nov 2012 15:20:03 +0000
Message-ID: <201211161520.03974.arnd@arndb.de>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <201211091428.42998.arnd@arndb.de> <50A61E51.8000306@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61432 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab2KPPUK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Nov 2012 10:20:10 -0500
In-Reply-To: <50A61E51.8000306@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org

On Friday 16 November 2012, James Hogan wrote:
> On 09/11/12 14:28, Arnd Bergmann wrote:
> > On Wednesday 31 October 2012, James Hogan wrote:
> >> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> >> index 55f2c22..60b2a09 100644
> >> --- a/drivers/input/serio/Kconfig
> >> +++ b/drivers/input/serio/Kconfig
> >> @@ -22,7 +22,7 @@ config SERIO_I8042
> >>         tristate "i8042 PC Keyboard controller" if EXPERT || !X86
> >>         default y
> >>         depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && \
> >> -                  (!SUPERH || SH_CAYMAN) && !M68K && !BLACKFIN
> >> +                  (!SUPERH || SH_CAYMAN) && !M68K && !BLACKFIN && !METAG
> >>         help
> >>           i8042 is the chip over which the standard AT keyboard and PS/2
> >>           mouse are connected to the computer. If you use these devices,
> > 
> > Maybe you can turn that list around and introduce a new symbol
> > ARCH_HAS_SERIO_I8042 or similar that architectures can select.
> > I suspect that actually most don't have this, but they have not
> > bothered to update this list.
> 
> Hi Arnd,
> 
> I've starting writing some patches along these lines (for the various PC
> style devices). They all seem to have slightly different rules though so
> I think to be safe we need separate Kconfig symbols for each one.

First of all, thank you very much for your investigation so far!

I think a lot can be done with one Kconfig symbol, if each of the users
lists the difference from the way the generic one is described, e.g.

config SERIO_I8042
	depends on HAVE_LEGACY_PC_IO && !M68K || ARCH_SHARK || FOOTBRIDGE_HOST

to define one that can be set on anything that generally is PC compatible
with the exception of all M68K but also including some ARM platforms.

> With SERIO_I8042 I'm completely guessing. It defaults to y, but the only
> ones I know for certain shouldn't select it are the ones currently
> excluded (parisc, arm (unless shark, footbridge), superh (unless
> cayman), m68k, blackfin, metag). A few I know should allow it due to
> special casing of io operations (mips (jazz, sgi_has_i8042, sni_rm),
> ppc, sparc, x86, ia64, unicore32). Is it okay in this case to select it
> for pretty much all of the arches not excluded and let the maintainers
> NAK if they don't want it?

Yes, that sounds good. You can even do that patch to change over the other
architectures straight away and let the ones that don't actually want it
send a separate patch. Note that S390 and UML can't select SERIO because
they disable INPUT altogether.

It's probably a good idea to separate the inversion of the logic from
any policy change and put those into separate patches.

> PARPORT_PC isn't too difficult (and defaults to n), I can select
> HAVE_PARPORT_PC from any arch that provides asm/parport.h or
> conditionally allowed it before:
> alpha, arm, ia64, m68k (if ISA), microblaze, mips, parisc, powerpc, sh,
> sparc (if PCI), tile, unicore32, x86

Ok. I think in general, we want to enable this one for anything
that has PCI, because the driver also supports parallel ports
on an extension card, not just those with a hardwired address.

> VGA_CONSOLE isn't too bad either (but it does default to y), I can
> select HAVE_VGA_CONSOLE if the arch declares a screen_info struct (which
> is the link error I get on metag):
> alpha, arm (only ARCH_INTEGRATOR, ARCH_FOOTBRIDGE, ARCH_NETWINDER),
> cris, ia64, m32r, mips, PPC (!4xx && !8xx), score, x86, xtensa

Ok. I don't think we can actually support it on m32r or score, but it
doesn't hurt to enable it.

> RTC defaults to n, but I've narrowed it down to alpha, m32r, mips
> (MACH_LOONSON), mn10300, and x86 which provide asm/mc146818rtc.h.
> 
> GEN_RTC defaults to n, and I've narrowed to alpha, m68k, mn10300,
> parisc, ppc, x86 which provide asm/rtc.h.

It's amazing that those are still around after we've had RTC_LIB
for so long. The "modern" driver that is supposed to replace these
two is RTC_DRV_CMOS, which currently builds for X86 || ALPHA || 
ARM || M32R || ATARI || PPC || MIPS || SPARC64.

There is also the nvram driver that is tightly coupled to the RTC
support and that can build only on x86, m68k (atari) and
ARM (if RTC_DRV_CMOS is on).

I think the baseline should be:

config LEGACY_PC_IO
	bool
	# selected by X86 || ALPHA || SPARC || M32R ||
	# (PPC && !4xx && !8xx) || 
        # (ARM && (ARCH_FOOTBRIDGE || ARCH_NETWINDER) ||
	# (M68K && (Q40 || SUN3X)) ||
	# (MIPS && (JAZZ || MALTA || SNI_RM))

config ARCH_MAY_HAVE_PC_FDC
	def_bool LEGACY_PC_IO && !M32R && (!PPC || (PCI && !PPC_PSERIES))
	# selected by ARCH_RPC

config HAVE_PARPORT_PC
	def_bool LEGACY_PC_IO || PCI

config HAVE_VGA_CONSOLE
	def_bool LEGACY_PC_IO
	# selected by ARCH_INTEGRATOR || CRIS || IA64 || MIPS || SCORE || XTENSA

config HAVE_RTC_DRV_CMOS
	def_bool LEGACY_PC_IO
	# selected by ARM || ATARI || PPC || MIPS || SPARC64

config HAVE_RTC_CMOS_LEGACY
	bool
	# selected by MACH_LOONSON || MN10300 || X86 || ALPHA || MN10300 || M32R

config HAVE_GEN_RTC_LEGACY
	def_bool LEGACY_PC_IO && !(ARM || M32R || SPARC)
	# selected by M68K || MN10300 || PARISC || PPC


	Arnd
