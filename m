From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC][PATCH] kmap_atomic_push
Date: Thu, 08 Oct 2009 23:12:41 +0100
Message-ID: <13417.1255039961@redhat.com>
References: <1255016123.17055.17.camel@laptop>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759681AbZJHWOD@vger.kernel.org>
In-Reply-To: <1255016123.17055.17.camel@laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: dhowells@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "hugh.dickins" <hugh.dickins@tiscali.co.uk>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Peter Zijlstra <peterz@infradead.org> wrote:

> The below patchlet changes the kmap_atomic interface to a stack based
> one that doesn't require the KM_types anymore.
> 
> This significantly simplifies some code (more still than are present in
> this patch -- ie. pte_map_nested can go now)
> ...
> What do people think?

Brrr.

This makes FRV much worse.  kmap_atomic() used to take a compile-time constant
value - which meant that the switch-statement inside it was mostly optimised
away.  kmap_atomic() would be rendered down to very few instructions.  Now
it'll be a huge jump table plus all those few instructions repeated because
the selector is now dynamic.

What I would prefer to see is something along the lines of local_irq_save()
and local_irq_restore(), where the displaced value gets stored on the machine
stack.  In FRV, I could then represent kmap_atomic() as:

	static inline void *kmap_atomic_push(struct page *page,
					     kmap_save_t *save)
	{
		unsigned long paddr, damlr, dampr;
		int type;

		pagefault_disable();

		dampr = page_to_phys(page);
		dampr |= xAMPRx_L | xAMPRx_M | xAMPRx_S | xAMPRx_SS_16Kb | xAMPRx_V;
		asm volatile("movgs dampr6,%0	\n"
			     "movgs %0,dampr6"
			     : "=r"(save->dampr) : "r"(dampr) : "memory");
		asm("movsg damlr6,%0" : "=r"(damlr));
		return (void *) damlr;
	}

However, since we occasionally want a second kmap slot, we could also add:

	typedef struct { unsigned long dampr; } kmap_save_t;

	static inline void *kmap2_atomic_push(struct page *page,
					      kmap_save_t *save)
	{
		unsigned long paddr, damlr, dampr;
		int type;

		pagefault_disable();

		dampr = page_to_phys(page);
		dampr |= xAMPRx_L | xAMPRx_M | xAMPRx_S | xAMPRx_SS_16Kb | xAMPRx_V;
		asm volatile("movgs dampr7,%0	\n"
			     "movgs %0,dampr7"
			     : "=r"(save->dampr) : "r"(dampr) : "memory");
		asm("movsg damlr7,%0" : "=r"(damlr));
		return (void *) damlr;
	}

And the reverse ops would be:

	static inline void kmap_atomic_pop(kmap_save_t *save)
	{
		asm volatile("movgs %0,dampr6"
			     :: "r"(save->dampr) : "memory");
		pagefault_enable();
	}

	static inline void kmap2_atomic_pop(kmap_save_t *save)
	{
		asm volatile("movgs %0,dampr7"
			     :: "r"(save->dampr) : "memory");
		pagefault_enable();
	}

And I would avoid the need to lock fake TLB entries in the shallow TLB.

If it's too much trouble for an arch to extract the current kmap setting from
the MMU or the page tables, *those* could be mirrored in per-CPU data.

Do we have any code that uses two slots and then calls more code that
ultimately requires further slots?  In other words, do we need more than two
slots?

> David, frv has a 'funny' issue in that it treats __KM_CACHE special from
> the other ones, something which isn't possibly anymore. Do you see
> another option than to add kmap_atomic_push_cache() for frv?

The four __KM_xxx slots are special and must not be committed to this stack.
They're used by assembly code directly for certain tasks, such as maintaining
the TLB-lookup state.  Your changes are guaranteed to break MMU-mode FRV.

That said, there's no reason these four slots *have* to be administered
through kmap_atomic().  A kmap_frv() could be made instead for them.

David
