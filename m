From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 04/23] locking: Convert raw_spinlock to arch_spinlock
Date: Sun, 6 Dec 2009 10:10:43 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912061004580.3560@localhost.localdomain>
References: <20091206110944.492100233@linutronix.de> <20091206111957.454670287@linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56854 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934065AbZLFSL0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2009 13:11:26 -0500
In-Reply-To: <20091206111957.454670287@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Linux-Arch <linux-arch@vger.kernel.org>



On Sun, 6 Dec 2009, Thomas Gleixner wrote:
>
> Linus suggested to convert the raw_ to arch_ locks and cleanup the
> name space instead of using an artifical name like core_spin,
> atomic_spin or whatever
> 
> No functional change.

Ok, I'm obviously biased, since I suggested this as a possible solution to 
the naming wars, but I have to say that I like this patch regardless of 
any of the other patches in the series. IOW, even without any issue of 
then re-using 'raw_spinlock' for the non-preemptable one, I like how this 
kind of change JustMakesSense(tm):

> --- linux-2.6-tip.orig/arch/alpha/include/asm/spinlock_types.h
> +++ linux-2.6-tip/arch/alpha/include/asm/spinlock_types.h
> @@ -7,7 +7,7 @@
>  
>  typedef struct {
>  	volatile unsigned int lock;
> -} raw_spinlock_t;
> +} arch_spinlock_t;
>  
>  #define __RAW_SPIN_LOCK_UNLOCKED	{ 0 }
>  

ie I just think that even just looking at the patch, this kind of change 
simply makes sense. The architectures declare their own per-architecture 
"arch_spinlock", and we can then do whatever we want at a higher level 
around that notion.

That said, it _is_ 

	 51 files changed, 164 insertions(+), 164 deletions(-)

but it seems to really be mainly the obvious arch header files and the 
tracing infrastructure, so while it's 51 files, the impact seems to be 
reasonably well-contained. 

So I like it, but maybe the arch people hate it?

			Linus
