Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34978 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbdC1GMZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2017 02:12:25 -0400
Date: Tue, 28 Mar 2017 08:11:21 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 5/8] x86/mm: Add basic defines/helpers for
 CONFIG_X86_5LEVEL
Message-ID: <20170328061121.GB20135@gmail.com>
References: <20170327162925.16092-1-kirill.shutemov@linux.intel.com>
 <20170327162925.16092-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170327162925.16092-6-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170328061121.1Ys9QKlpYRxxJonPp9rwuXM94OMEKQc60LtonrurQSo@z>


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> +#ifdef CONFIG_X86_5LEVEL
> +
> +/*
> + * PGDIR_SHIFT determines what a top-level page table entry can map
> + */
> +#define PGDIR_SHIFT	48
> +#define PTRS_PER_PGD	512
> +
> +/*
> + * 4rd level page in 5-level paging case

4th.

> + */
> +#define P4D_SHIFT	39
> +#define PTRS_PER_P4D	512
> +#define P4D_SIZE	(_AC(1, UL) << P4D_SHIFT)
> +#define P4D_MASK	(~(P4D_SIZE - 1))
> +
> +#else  /* CONFIG_X86_5LEVEL */

Single space suffices before teh comment.

> +
>  /*
>   * PGDIR_SHIFT determines what a top-level page table entry can map
>   */
>  #define PGDIR_SHIFT	39
>  #define PTRS_PER_PGD	512
>  
> +#endif  /* CONFIG_X86_5LEVEL */

Ditto.

> +#ifdef CONFIG_X86_5LEVEL
> +/**
> + * p4d_set_huge - setup kernel P4D mapping
> + *
> + * No 512GB pages yet -- always return 0
> + *
> + * Returns 1 on success and 0 on failure.
> + */
> +int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
> +{
> +	return 0;
> +}

The last comment line can be deleted I suppose.

Thanks,

	Ingo
