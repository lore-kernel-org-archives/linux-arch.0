From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/5] Reenable might_sleep() checks for might_fault()
Date: Fri, 27 Mar 2015 17:15:36 +0100
Message-ID: <20150327161536.GH23123@twins.programming.kicks-ass.net>
References: <1418221414-60110-1-git-send-email-dahi@linux.vnet.ibm.com>
 <20150112151911.4a51f09d@thinkpad-w530>
 <20150209144217.GT5029@twins.programming.kicks-ass.net>
 <20150219154805.2651257d@thinkpad-w530>
 <20150219150723.GF21418@twins.programming.kicks-ass.net>
 <20150327164050.04693bff@thinkpad-w530>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:42519 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbbC0QPt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2015 12:15:49 -0400
Content-Disposition: inline
In-Reply-To: <20150327164050.04693bff@thinkpad-w530>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz

On Fri, Mar 27, 2015 at 04:40:50PM +0100, David Hildenbrand wrote:
> e.g. futex_atomic_op_inuser(): easy to fix, add preempt_enable/disable
> respectively.
> 
> e.g. futex_atomic_cmpxchg_inatomic(): not so easy / nice to fix.
> 
> The "inatomic" variants rely on the caller to make sure that preemption is
> disabled.
> 
>         pagefault_disable();
>         ret = futex_atomic_cmpxchg_inatomic(curval, uaddr, uval, newval);
>         pagefault_enable();

Typically the _inatomic() variants of functions have the exception
tables required for fixups and can return -EFAULT. In that regard the
futex_atomic_cmpxchg_inatomic() is consistently named.

In specific the above is taken from cmpxchg_futex_value_locked(), which
is private to futex.c, so we don't really need to worry about it.

Furthermore, the futex.c helpers that wrap them in pagefault_disable()
do so because they want to handle the fault themselves. I don't think we
need to worry about that.

> 1. We could simply add preempt_disable/enable to the calling code. However that
> results in _all_ futex_atomic_cmpxchg_inatomic() running with disabled
> preemption, although the implementation doesn't really need it. So there is not
> really a "decoupling", but to counters to set.

Not really needed, the few callsites where they are not already under a
lock is where we want to explicitly handle the -EFAULT case ourselves.

> 2. We could add the preempt_disable/enable to the implementations that only
> need it, leaving calling code as is. However, then the name
> "futex_atomic_cmpxchg_inatomic" is misleading, because it has nothing to do
> with "inatomic" anymore.

The _inatomic() naming is because it _can_ be called from atomic
context, like __copy_to_user_inatomic(). It doesn't mean it has to.
These functions work just fine outside of atomic regions.

And they still can be used in atomic regions, but now
pagefault_disable() will also trigger the exception fixup.

I don't think we should worry too much about this.

> The same applies to other "inatomic" functions. I think most of these functions
> rely on pagefaults to be disabled in order to work correctly, not disabled
> preemption.
> 
> Any idea how to fix this or what would be the way to go?

I have the feeling you're over thinking this. _inatomic() has exception
fixups and will return -EFAULT when it cannot do the pagefault in place,
for whatever reason -- traditionally because of atomic context, now also
pagefault_disable().

And esp. things like futexes have been extensively used under -rt and
are known good.
