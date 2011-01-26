From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC][PATCH 26/25] mm, arch: Convert ia64, arm, sh to generic
	tlb
Date: Wed, 26 Jan 2011 20:19:33 +0100
Message-ID: <20110126191901.GA3434@merkur.ravnborg.org>
References: <20110125173111.720927511@chello.nl> <1296047601.28776.1162.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:43783 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027Ab1AZTTe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jan 2011 14:19:34 -0500
Content-Disposition: inline
In-Reply-To: <1296047601.28776.1162.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

> Index: linux-2.6/include/asm-generic/tlb.h
> ===================================================================
> --- linux-2.6.orig/include/asm-generic/tlb.h
> +++ linux-2.6/include/asm-generic/tlb.h
> @@ -79,6 +79,10 @@ struct mmu_gather {
>  				fast_mode  : 1; /* No batching   */
>  	unsigned int		fullmm;		/* Flush full mm */
>  
> +#ifdef CONFIG_HAVE_MMU_GATHER_RANGE
> +	unsigned long		start, end;
> +#endif
> +
>  	struct mmu_gather_batch *active;
>  	struct mmu_gather_batch	local;
>  	struct page		*__pages[8];

Not related to this patch per see.

But if you anyway touch this header could you then fix
following comment:

/* Users of the generic TLB shootdown code must declare this storage space. */
DECLARE_PER_CPU(struct mmu_gather, mmu_gathers);

If I understand this correct then this should read:

/*
 * Users of the generic TLB shootdown
 * must define mmu_gathers like this:
 * DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 */

The main difference is "declare" => "define".

If you already updated this in you serie then please ignore this mail.

	Sam
