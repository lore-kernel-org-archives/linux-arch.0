From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V5 06/30] csky: Cache and TLB routines
Date: Thu, 27 Sep 2018 09:08:59 +0200
Message-ID: <20180927070859.GC5254@hirez.programming.kicks-ass.net>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <7cd7abcd2acf5c61435589338ff80a75a13173ca.1537789737.git.ren_guo@c-sky.com>
 <20180925072407.GA6999@hirez.programming.kicks-ass.net>
 <20180927052737.GA28407@guoren>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180927052737.GA28407@guoren>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, palmer@sifive.com
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 27, 2018 at 01:27:38PM +0800, Guo Ren wrote:
> On Tue, Sep 25, 2018 at 09:24:07AM +0200, Peter Zijlstra wrote:
> > On Mon, Sep 24, 2018 at 10:36:22PM +0800, Guo Ren wrote:
> > > diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/abi/cacheflush.h
> > > new file mode 100644
> > > index 0000000..f0de49c
> > > --- /dev/null
> > > +++ b/arch/csky/abiv1/inc/abi/cacheflush.h

> > > +#define flush_cache_range(mm,start,end)	cache_wbinv_range(start, end)
> >                              ^^^ should be vma
> Yes, I'll change it to:
> #define flush_cache_range(mm,start,end)	cache_wbinv_all()
> 
> I'll improve it later after test.

That's not what I meant; I meant you need something like:

#define flush_cache_range(vma, start, end) cache_wbinv_range(start, end) 

The first argument is a vma, not an mm.

> > > +#endif /* __ABI_CSKY_CACHEFLUSH_H */
> > 
> > 
> > > diff --git a/arch/csky/abiv1/inc/abi/tlb.h b/arch/csky/abiv1/inc/abi/tlb.h
> > > new file mode 100644
> > > index 0000000..6d461f3
> > > --- /dev/null
> > > +++ b/arch/csky/abiv1/inc/abi/tlb.h
> > > @@ -0,0 +1,12 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> > > +
> > > +#ifndef __ABI_CSKY_TLB_H
> > > +#define __ABI_CSKY_TLB_H
> > > +
> > > +#define tlb_start_vma(tlb, vma) \
> > > +	do { \
> > > +		if (!tlb->fullmm) \
> > > +			cache_wbinv_all(); \
> > > +	}  while (0)
> > > +#endif /* __ABI_CSKY_TLB_H */
> > 
> > That should be:
> > 
> > 	if (!tlb->fullmm)
> > 		flush_cache_range(vma, vma->vm_start, vma->vm_end);
> > 
> > Because as per the whole abiv1 vs abiv2, you don't need write back
> > invalidation for v2 at all, also, you only need to invalidate the vma
> > range, no reason to shoot everything down.
> > 
> > Also, I'll be shortly removing this:
> > 
> >   https://lkml.kernel.org/r/20180913092812.071989585@infradead.org
> Ok, I'll follow the rules.


> > > diff --git a/arch/csky/abiv2/inc/abi/cacheflush.h b/arch/csky/abiv2/inc/abi/cacheflush.h
> > > new file mode 100644
> > > index 0000000..756beb7
> > > --- /dev/null
> > > +++ b/arch/csky/abiv2/inc/abi/cacheflush.h
> > > @@ -0,0 +1,40 @@

> > > +#define flush_cache_range(vma, start, end)	do { } while (0)
> >                              ^^^ like here..
> #define flush_cache_range(vma, start, end) \
> 	do { \
> 		if (vma->vm_flags & VM_EXEC) \
> 			icache_inv_all(); \
> 	}
> 
> Hmm ?
> 

For v2, which IIUC is PIPT (as opposed to v1 which is VIPT), what you
had was correct.

I was merely pointing out that the flush_cache_range() definition was
inconsitent between v1 and v2; v1 using @mm and v2 using @vma for the
first argument.
