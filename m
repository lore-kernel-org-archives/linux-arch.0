From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 1/6] hardirq: Make hardirq bits generic
Date: Tue, 17 Sep 2013 23:24:49 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1309172315550.4089@ionos.tec.linutronix.de>
References: <20130917082838.218329307@infradead.org> <20130917182350.449685712@linutronix.de> <20130917183628.534494408@linutronix.de> <CAMuHMdWgrQf+ULDrZyY5R+vT3GtiWEgpsWxmfk0b5pivN7wBmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWgrQf+ULDrZyY5R+vT3GtiWEgpsWxmfk0b5pivN7wBmg@mail.gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Linux-Arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andi Kleen <ak@linux.intel.com>, Peter Anvin <hpa@zytor.com>, Mike Galbraith <bitbucket@online.de>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, Linux/m68k <linux-m68k@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, 17 Sep 2013, Geert Uytterhoeven wrote:

> On Tue, Sep 17, 2013 at 8:53 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > --- linux-2.6.orig/arch/m68k/include/asm/hardirq.h
> > +++ linux-2.6/arch/m68k/include/asm/hardirq.h
> > @@ -5,17 +5,6 @@
> >  #include <linux/cache.h>
> >  #include <asm/irq.h>
> >
> > -#define HARDIRQ_BITS   8
> 
> > --- linux-2.6.orig/include/linux/preempt_mask.h
> > +++ linux-2.6/include/linux/preempt_mask.h
> > @@ -11,36 +11,22 @@
> >   * - bits 0-7 are the preemption count (max preemption depth: 256)
> >   * - bits 8-15 are the softirq count (max # of softirqs: 256)
> >   *
> > - * The hardirq count can in theory reach the same as NR_IRQS.
> > - * In reality, the number of nested IRQS is limited to the stack
> > - * size as well. For archs with over 1000 IRQS it is not practical
> > - * to expect that they will all nest. We give a max of 10 bits for
> > - * hardirq nesting. An arch may choose to give less than 10 bits.
> > - * m68k expects it to be 8.
> 
> m68k needs some changes in arch/m68k/kernel/entry.S, cfr. this check
> in arch/m68k/kernel/ints.c:
> 
>         /* assembly irq entry code relies on this... */
>         if (HARDIRQ_MASK != 0x00ff0000) {
>                 extern void hardirq_mask_is_broken(void);
>                 hardirq_mask_is_broken();
>         }
> 
> Haven't looked into the details yet...

Whee. Did not notice that one. Though I can't find anything
interesting in the low level entry code... Looks like some more
histerical left overs.

Thanks,

	tglx
