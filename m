From: Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH 09/13] mm, powerpc: Move the RCU page-table freeing
 into generic code
Date: Fri, 9 Apr 2010 13:35:32 +1000
Message-ID: <20100409033532.GI5683@laptop>
References: <20100408191737.296180458@chello.nl>
 <20100408192722.987227219@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:53747 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753362Ab0DIDfj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 8 Apr 2010 23:35:39 -0400
Content-Disposition: inline
In-Reply-To: <20100408192722.987227219@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>

On Thu, Apr 08, 2010 at 09:17:46PM +0200, Peter Zijlstra wrote:
> Index: linux-2.6/include/asm-generic/tlb.h
> ===================================================================
> --- linux-2.6.orig/include/asm-generic/tlb.h
> +++ linux-2.6/include/asm-generic/tlb.h
> @@ -27,6 +27,49 @@
>    #define tlb_fast_mode(tlb) 1
>  #endif
>  
> +#ifdef HAVE_ARCH_RCU_TABLE_FREE
> +/*
> + * Semi RCU freeing of the page directories.
> + *
> + * This is needed by some architectures to implement gup_fast().

Really? I see the comment in the powerpc code, but powerpc was already
using RCU before gup_fast(), and AFAIKS it is indeed using it so that
it can handle faults by getting the linux pte with find_linux_pte ?

I would have thought this should be a well used method for handling
software TLB faults.

But anyway this looks like a nice abstraction.
