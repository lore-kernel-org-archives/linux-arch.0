From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 21/25] mm: Add arch hooks for saving/restoring tags
Date: Wed, 24 Jun 2020 11:45:34 -0700
Message-ID: <20200624114534.9520ba5ed235bc32bf1af3a2@linux-foundation.org>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
        <20200624175244.25837-22-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405581AbgFXSph (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 14:45:37 -0400
In-Reply-To: <20200624175244.25837-22-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Steven Price <steven.price@arm.com>

On Wed, 24 Jun 2020 18:52:40 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> From: Steven Price <steven.price@arm.com>
> 
> Arm's Memory Tagging Extension (MTE) adds some metadata (tags) to
> every physical page, when swapping pages out to disk it is necessary to
> save these tags, and later restore them when reading the pages back.
> 
> Add some hooks along with dummy implementations to enable the
> arch code to handle this.
> 
> Three new hooks are added to the swap code:
>  * arch_prepare_to_swap() and
>  * arch_swap_invalidate_page() / arch_swap_invalidate_area().
> One new hook is added to shmem:
>  * arch_swap_restore_tags()
> 
> ...
>
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -631,6 +631,29 @@ static inline int arch_unmap_one(struct mm_struct *mm,
>  }
>  #endif
>  
> +#ifndef __HAVE_ARCH_PREPARE_TO_SWAP
> +static inline int arch_prepare_to_swap(struct page *page)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#ifndef __HAVE_ARCH_SWAP_INVALIDATE
> +static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
> +{
> +}
> +
> +static inline void arch_swap_invalidate_area(int type)
> +{
> +}
> +#endif
> +
> +#ifndef __HAVE_ARCH_SWAP_RESTORE_TAGS
> +static inline void arch_swap_restore_tags(swp_entry_t entry, struct page *page)
> +{
> +}
> +#endif

Presumably these three __HAVE_ARCH_ macros are to be defined in asm/pgtable.h?

Acked-by: Andrew Morton <akpm@linux-foundation.org>
