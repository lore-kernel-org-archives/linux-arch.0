Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45814 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfBGTsn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Feb 2019 14:48:43 -0500
Date: Thu, 7 Feb 2019 20:48:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH-tip 04/22] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190207194828.GC32534@hirez.programming.kicks-ass.net>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <1549566446-27967-5-git-send-email-longman@redhat.com>
 <20190207193656.GF32511@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207193656.GF32511@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <20190207194828.DxmfUYwrmqMXsyNDXq3UO_bQTkCryWUdaUrFYi-S6vA@z>

On Thu, Feb 07, 2019 at 08:36:56PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 07, 2019 at 02:07:08PM -0500, Waiman Long wrote:
> 
> > +static inline int __down_read_trylock(struct rw_semaphore *sem)
> > +{
> > +	long tmp;
> > +
> > +	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
> > +		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
> > +				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
> > +			return 1;
> > +		}
> > +	}
> 
> Nah, you're supposed to write that like:
> 
> 	for (;;) {
> 		val = atomic_long_cond_read_relaxed(&sem->count, VAL < 0);
> 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &val,
> 						    val + RWSEM_ACTIVE_READ_BIAS))
> 			break;
> 	}

N/m that's not in fact the same...

> > +	return 0;
> > +}
> 
> 
> Anyway, yuck, you're keeping all that BIAS nonsense :/ I was so hoping
> for a rwsem implementation without that impenetrable crap.
