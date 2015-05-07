From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC 01/15] uaccess: count pagefault_disable() levels in
 pagefault_disabled
Date: Thu, 7 May 2015 12:22:54 +0200
Message-ID: <20150507102254.GE23123@twins.programming.kicks-ass.net>
References: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
 <1430934639-2131-2-git-send-email-dahi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1430934639-2131-2-git-send-email-dahi@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, May 06, 2015 at 07:50:25PM +0200, David Hildenbrand wrote:
> +/*
> + * Is the pagefault handler disabled? If so, user access methods will not sleep.
> + */
> +#define pagefault_disabled() (current->pagefault_disabled != 0)

So -RT has:

static inline bool pagefault_disabled(void)
{
	return current->pagefault_disabled || in_atomic();
}

AFAICR we did this to avoid having to do both:

	preempt_disable();
	pagefault_disable();

in a fair number of places -- just like this patch-set does, this is
touching two cachelines where one would have been enough.

Also, removing in_atomic() from fault handlers like you did
significantly changes semantics for interrupts (soft, hard and NMI).

So while I agree with most of these patches, I'm very hesitant on the
above little detail.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
