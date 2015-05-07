From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 01/15] uaccess: count pagefault_disable() levels in
 pagefault_disabled
Date: Thu, 7 May 2015 12:50:53 +0200
Message-ID: <20150507125053.5d2e8f0a@thinkpad-w530>
References: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
	<1430934639-2131-2-git-send-email-dahi@linux.vnet.ibm.com>
	<20150507102254.GE23123@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20150507102254.GE23123@twins.programming.kicks-ass.net>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.orgtglx@linutronix.de
List-Id: linux-arch.vger.kernel.org

> On Wed, May 06, 2015 at 07:50:25PM +0200, David Hildenbrand wrote:
> > +/*
> > + * Is the pagefault handler disabled? If so, user access methods will not sleep.
> > + */
> > +#define pagefault_disabled() (current->pagefault_disabled != 0)
> 
> So -RT has:
> 
> static inline bool pagefault_disabled(void)
> {
> 	return current->pagefault_disabled || in_atomic();
> }
> 
> AFAICR we did this to avoid having to do both:
> 
> 	preempt_disable();
> 	pagefault_disable();
> 
> in a fair number of places -- just like this patch-set does, this is
> touching two cachelines where one would have been enough.
> 
> Also, removing in_atomic() from fault handlers like you did
> significantly changes semantics for interrupts (soft, hard and NMI).
> 
> So while I agree with most of these patches, I'm very hesitant on the
> above little detail.
> 

Just to make sure we have a common understanding (as written in my cover
letter):

Your suggestion won't work with !CONFIG_PREEMPT (!CONFIG_PREEMPT_COUNT). If
there is no preempt counter, in_atomic() won't work. So doing a
preempt_disable() instead of a pagefault_disable() is not going to work.
(not sure how -RT handles that - most probably with CONFIG_PREEMPT_COUNT being
enabled, due to atomic debug).

That's why I dropped that check for a reason.

So in my opinion, in_atomic() should never be used in any fault handler - it
has nothing to do with disabled pagefaults. It doesn't give us anything more
besides some false security for atomic environments.


This patchset is about decoupling both concept. (not ending up with to
mechanisms doing almost the same)

That's also what Thomas Gleixner suggested
https://lkml.org/lkml/2014/11/27/820 .


David

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
