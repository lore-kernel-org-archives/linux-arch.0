From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: using IS_ENABLED(CONFIG_xyz) effectively
Date: Mon, 16 Nov 2015 09:52:16 +0100
Message-ID: <4200245.e01Ct9ua6M@wuerfel>
References: <5613F3DE.4010406@suse.cz>
 <CAMuHMdVEK041TFY3JJ1kvYE_e_C72+FcRu3ewDipLPi-kN-h=A@mail.gmail.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44D1969@IN01WEMBXA.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F44D1969@IN01WEMBXA.internal.synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Michal Marek <mmarek@suse.cz>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, arcml <linux-snps-arc@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

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
