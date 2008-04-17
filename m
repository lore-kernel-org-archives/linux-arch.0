Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54086 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934078AbYDQP1U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Apr 2008 11:27:20 -0400
Date: Thu, 17 Apr 2008 08:25:30 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 2/2]: introduce fast_gup
In-Reply-To: <1208444605.7115.2.camel@twins>
Message-ID: <alpine.LFD.1.00.0804170814090.2879@woody.linux-foundation.org>
References: <20080328025455.GA8083@wotan.suse.de>  <20080328030023.GC8083@wotan.suse.de> <1208444605.7115.2.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, shaggy@austin.ibm.com, axboe@kernel.dk, linux-mm@kvack.org, linux-arch@vger.kernel.org, Clark Williams <williams@redhat.com>, Ingo Molnar <mingo@elte.hu>
Message-ID: <20080417152530.k3-s-AklkaEKuE3V7Qw36Ah7hlq08_3mZeqMSkP4OGk@z>



On Thu, 17 Apr 2008, Peter Zijlstra wrote:
> 
> Would this be sufficient to address that comment's conern?

It would be nicer to just add a "native_get_pte()" to x86, to match the 
already-existing "native_set_pte()".

And that "barrier()" should b "smp_rmb()". They may be the same code 
sequence, but from a conceptual angle, "smp_rmb()" makes a whole lot more 
sense.

Finally, I don't think that comment is correct in the first place. It's 
not that simple. The thing is, even *with* the memory barrier in place, we 
may have:

	CPU#1			CPU#2
	=====			=====

	fast_gup:
	 - read low word

				native_set_pte_present:
				 - set low word to 0
				 - set high word to new value

	 - read high word

				- set low word to new value

and so you read a low word that is associated with a *different* high 
word! Notice?

So trivial memory ordering is _not_ enough.

So I think the code literally needs to be something like this

	#ifdef CONFIG_X86_PAE

	static inline pte_t native_get_pte(pte_t *ptep)
	{
		pte_t pte;

	retry:
		pte.pte_low = ptep->pte_low;
		smp_rmb();
		pte.pte_high = ptep->pte_high;
		smp_rmb();
		if (unlikely(pte.pte_low != ptep->pte_low)
			goto retry;
		return pte;
	}

	#else

	#define native_get_pte(ptep) (*(ptep))

	#endif

but I have admittedly not really thought it fully through.

		Linus
