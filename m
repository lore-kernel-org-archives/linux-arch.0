From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 2/2] fix SMP data race in pagetable setup vs walking
Date: Mon, 5 May 2008 08:32:30 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805050828120.32269@woody.linux-foundation.org>
References: <20080505112021.GC5018@wotan.suse.de> <20080505121240.GD5018@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33584 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750940AbYEEPdA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 May 2008 11:33:00 -0400
In-Reply-To: <20080505121240.GD5018@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, linux-arch@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>, Paul McKenney <paulmck@us.ibm.com>



On Mon, 5 May 2008, Nick Piggin wrote:
> 
> Index: linux-2.6/include/asm-x86/pgtable_32.h
> ===================================================================
> --- linux-2.6.orig/include/asm-x86/pgtable_32.h
> +++ linux-2.6/include/asm-x86/pgtable_32.h
> @@ -133,7 +133,12 @@ extern int pmd_bad(pmd_t pmd);
>   * pgd_offset() returns a (pgd_t *)
>   * pgd_index() is used get the offset into the pgd page's array of pgd_t's;
>   */
> -#define pgd_offset(mm, address) ((mm)->pgd + pgd_index((address)))
> +#define pgd_offset(mm, address)						\
> +({									\
> +	pgd_t *ret = ((mm)->pgd + pgd_index((address)));		\
> +	smp_read_barrier_depends(); /* see mm/memory.c:__pte_alloc */	\
> +	ret;								\
> +})

Is there some fundamental reason this needs to be a macro?

It is really ugly, and it would be much nicer to make this an inline 
function if at all possible.

Yeah, maybe it requires some more #include's, but ..

(Especially since it apparently gets worse, and the pgd load needs a 
ACCESS_ONCE() too - the code generated is the same, but the source gets 
more and more involved)

That said, I *also* think that it's sad that you do this at all, since 
smp_read_barrier_depends() is a no-op on x86, so why should we have it in 
an x86-specific header file?

In short, I think the fixes are real, but the patch itself is really just 
confusing things for no apparent good reason.

		Linus
