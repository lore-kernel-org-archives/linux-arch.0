Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 04A5D3240A4
	for <linux-arch@vger.kernel.org>; Sun,  5 Jun 2005 12:41:57 +0200 (CEST)
Date: Sun, 5 Jun 2005 12:42:46 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] spinlock consolidation, v2
Message-ID: <20050605104245.GA9303@elte.hu>
References: <20050603154029.GA2995@elte.hu> <20050604113809.GD19819@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050604113809.GD19819@infradead.org>
Resent-To: linux-arch@vger.kernel.org
Resent-Message-Id: <20050605104349.7355F1FC2@chiara.elte.hu>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@infradead.org>, Roman Zippel <zippel@linux-m68k.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Ingo Oeser <ioe-lkml@axxeo.de>, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, "David S. Miller" <davem@redhat.com>
List-ID: <linux-arch.vger.kernel.org>


* Christoph Hellwig <hch@infradead.org> wrote:

> > the latest version of the spinlock consolidation patch can be found at:
> > 
> >   http://redhat.com/~mingo/spinlock-patches/consolidate-spinlocks.patch
> > 
> > the patch is now complete in the sense that it does everything i wanted 
> > it to do. If you have any other suggestions (or i have missed to 
> > incorporate an earlier suggestion of yours), please yell.
> 
> Looks pretty nice, but your usage of asm-generic is totally wrong. 
> files in asm-generic must only ever be used for default 
> implementations of asm/ headers, and _never_ be included from common 
> code.  But your asm-generic files are only ever used from 
> linux/spinlock.h, so there's no point at all in splitting them out in 
> the first time. [...]

I see your point. My intention was to make the include file structure 
completely symmetric and thus easy to review. The following table 
illustrates how we build up the spinlock type and primitives in the SMP 
and UP cases:

   SMP                         |  UP
   ----------------------------|-----------------------------------
   asm/spinlock_types.h        |  asm-generic/spinlock_types_up.h
   linux/spinlock_types.h      |  linux/spinlock_types.h
   asm/spinlock.h              |  asm-generic/spinlock_up.h
   linux/spinlock_smp.h        |  linux/spinlock_up.h
   linux/spinlock.h            |  linux/spinlock.h

as you can see in the list above, whenever something comes from the asm 
directory, in the UP case we pick it from asm-generic. But i accept your 
point that the use of asm-generic/ for this is improper, and i've moved 
those files into include/linux/. (I also have renamed spinlock_smp.h and 
spinlock_up.h to spinlock_api_smp.h and spinlock_api_up.h, to avoid the 
filename clash.) The naming is still symmetric:

   SMP                         |  UP
   ----------------------------|-----------------------------------
   asm/spinlock_types_smp.h    |  linux/spinlock_types_up.h
   linux/spinlock_types.h      |  linux/spinlock_types.h
   asm/spinlock_smp.h          |  linux/spinlock_up.h
   linux/spinlock_api_smp.h    |  linux/spinlock_api_up.h
   linux/spinlock.h            |  linux/spinlock.h

all this splitup structure was created based on a pretty simple rule:
whenever some aspect is sufficiently dissimilar to be #ifdef
CONFIG_SMP-ed, it gets into separate _smp and _up files. If it's generic
and shared it gets into the main spinlock.h file. The splitups were only
done to enable this clean structure.

> Similarly there's no point in a separate linux/spinlock_smp.h and 
> linux/spinlock_up.h - it'll only cause some driver writers to include 
> either of them directly and break the build for either UP or SMP. If 
> you absolutely want to split them add an #error if not included from 
> spinlock.h

ok, i've added the #error protectors.

> Little nitpick no 2: please include linux/*.h always before asm/*.h 
> (in linux/jbd.h)

done.

you can find the latest patch with all these fixes included, at:

  http://redhat.com/~mingo/spinlock-patches/consolidate-spinlocks.patch

	Ingo
