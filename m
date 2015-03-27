From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/5] Reenable might_sleep() checks for might_fault()
Date: Fri, 27 Mar 2015 16:40:50 +0100
Message-ID: <20150327164050.04693bff@thinkpad-w530>
References: <1418221414-60110-1-git-send-email-dahi@linux.vnet.ibm.com>
	<20150112151911.4a51f09d@thinkpad-w530>
	<20150209144217.GT5029@twins.programming.kicks-ass.net>
	<20150219154805.2651257d@thinkpad-w530>
	<20150219150723.GF21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150219150723.GF21418@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz
List-Id: linux-arch.vger.kernel.org

> On Thu, Feb 19, 2015 at 03:48:05PM +0100, David Hildenbrand wrote:
> > Downside is that now that I have to touch all fault handlers, I have to go
> > through all archs again.
> 
> You should be able to borrow from the -rt patches there. They have all
> that.
> 

Hi Peter,

I hadn't much time to work on this lately, and it seems like this will be much
bigger that I expected.

We have various places in the code that rely on pagefault_disable() to also
disable preemtpion. Most of these places were ignored on -rt, because not
supported.

One of these places is e.g. powerpc's vmx based usercopy. While these places
are easy to handle, I was struggeling e.g. with asm-generic futex functions.

e.g. futex_atomic_op_inuser(): easy to fix, add preempt_enable/disable
respectively.

e.g. futex_atomic_cmpxchg_inatomic(): not so easy / nice to fix.

The "inatomic" variants rely on the caller to make sure that preemption is
disabled.

        pagefault_disable();
        ret = futex_atomic_cmpxchg_inatomic(curval, uaddr, uval, newval);
        pagefault_enable();

1. We could simply add preempt_disable/enable to the calling code. However that
results in _all_ futex_atomic_cmpxchg_inatomic() running with disabled
preemption, although the implementation doesn't really need it. So there is not
really a "decoupling", but to counters to set.

2. We could add the preempt_disable/enable to the implementations that only
need it, leaving calling code as is. However, then the name
"futex_atomic_cmpxchg_inatomic" is misleading, because it has nothing to do
with "inatomic" anymore.

3. We could move the pagefault_ calls into the implementation and add
the preempt_ calls to the calling code. Once again, functions that don't rely
on preemption have it disabled.

The "inatomic" part is now somewhat wrong. Because they can't be called from
atomic context. They have to be called from a pagefault-disabled
environment.The preemption part is implementation specific.
So I wonder if what we really want is something like

/* can be called from atomic context, but it's not required */
int futex_atomic_cmpxchg_nopfault(...) {
	int ret;

	pagefault_disable();
	ret = futex_atomic_cmpxchg_disabled_pfault(...)
	pagefault_enable();
	return ret;	
}

/* has to be called with disabled pagefaults */
int futex_atomic_cmpxchg_disabled_pfault(...) {
	int ret;

	/* do architecture specific stuff */

	return ret;	
}

/* has to be called with disabled pagefaults */
int futex_atomic_cmpxchg_disabled_pfault(...) {
	int ret;

	preempt_disable()
	/* do architecture common stuff as default */
	preempt_enable()

	return ret;	
}

The same applies to other "inatomic" functions. I think most of these functions
rely on pagefaults to be disabled in order to work correctly, not disabled
preemption.

Any idea how to fix this or what would be the way to go?

Thanks!

David
