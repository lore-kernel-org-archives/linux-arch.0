Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:54035 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbbKPIyT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2015 03:54:19 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: using IS_ENABLED(CONFIG_xyz) effectively
Date: Mon, 16 Nov 2015 09:52:16 +0100
Message-ID: <4200245.e01Ct9ua6M@wuerfel>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F44D1969@IN01WEMBXA.internal.synopsys.com>
References: <5613F3DE.4010406@suse.cz> <CAMuHMdVEK041TFY3JJ1kvYE_e_C72+FcRu3ewDipLPi-kN-h=A@mail.gmail.com> <C2D7FE5348E1B147BCA15975FBA23075F44D1969@IN01WEMBXA.internal.synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Paul Gortmaker <paul.gortmaker@windriver.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Michal Marek <mmarek@suse.cz>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>
Message-ID: <20151116085216.Zc2aApAw47sH_OE4KEmWpnOu5RyUxhUPx6J4WFStJCQ@z>

On Monday 16 November 2015 08:35:05 Vineet Gupta wrote:
> Hi Geert,
> 
> On Monday 16 November 2015 01:58 PM, Geert Uytterhoeven wrote:
> > Hi Vineet,
> >
> > On Mon, Nov 16, 2015 at 9:00 AM, Vineet Gupta
> > <Vineet.Gupta1@synopsys.com> wrote:
> >> I've been using IS_ENABLED for some time and once in a while run into an issue
> >> which prevents seamless use. Hence posing this question to experts in the area.
> >>
> >> C macro processor evaluates the ensuing control block even if IS_ENABLED evaluates
> >> to false. This requires dummy #defines or worse still removing usage of IS_ENABLED
> >> altogether.
> >>
> >> e.g. In example below even for ARCOMPACT builds, we need the ARCV2 specific define
> >> ARCV2_IRQ_DEF_PRIO.
> >>
> >> void arch_cpu_idle(void)
> >> {
> >>         if (is_isa_arcompact()) {    <---- IS_ENABLED(CONFIG_ISA_ARCOMPACT)
> >>                 __asm__("sleep 0x3");
> >>         } else {
> >>                 const int arg = 0x10 | ARCV2_IRQ_DEF_PRIO;
> >>                __asm__("sleep 0x10");
> >>         }
> >> }
> >>
> >> One could argue that the interface needs to be cleanly defined to not have such
> >> specific #defines in common code in first place. However sometime that becomes
> >> just too tedious.
> >>
> >> Is there a way to get around by this ?
> > Use #ifdef CONFIG_...?
> >
> > The advantage of IS_ENABLED() over #ifdef is that it allows compile-testing of
> > the disabled code path. Of course it should only be compiled if it makes
> > sense. And that's exactly what you're running into.
> 
> And I thought it was to de-uglify the code with same semantics - which doesn't
> seem to be the case !

I would still try to do this with if(IS_ENABLED()) or another macro
like you have above. The problem you ran into with the macro definitions
is that you have conflicting header files:

#ifdef CONFIG_ISA_ARCOMPACT
#include <asm/irqflags-compact.h>
#else
#include <asm/irqflags-arcv2.h>
#endif

This has other (small) problems too, because you get possibly conflicting
symbols (e.g. arch_local_irq_enable but also the register names) that
make it harder to follow what's going on when reading the code.
If you prefix all the defines in the two headers with the respective name,
you can just include both headers and avoid this:

static inline void arch_local_irq_enable(void)
{
	if (IS_ENABLED(CONFIG_ISA_ARCCOMPACT))
		return arccompact_local_irq_enable();
	else
		return arcv2_local_irq_enable();
}

	Arnd
