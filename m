From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 13/25] mm: Introduce arch_validate_flags()
Date: Wed, 24 Jun 2020 11:37:46 -0700
Message-ID: <20200624113746.589b6af7779f39eee846ea74@linux-foundation.org>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
        <20200624175244.25837-14-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405914AbgFXShr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 14:37:47 -0400
In-Reply-To: <20200624175244.25837-14-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>

On Wed, 24 Jun 2020 18:52:32 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> Similarly to arch_validate_prot() called from do_mprotect_pkey(), an
> architecture may need to sanity-check the new vm_flags.
> 
> Define a dummy function always returning true. In addition to
> do_mprotect_pkey(), also invoke it from mmap_region() prior to updating
> vma->vm_page_prot to allow the architecture code to veto potentially
> inconsistent vm_flags.
> 
> ...
>
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -103,6 +103,19 @@ static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
>  #define arch_validate_prot arch_validate_prot
>  #endif
>  
> +#ifndef arch_validate_flags
> +/*
> + * This is called from mmap() and mprotect() with the updated vma->vm_flags.
> + *
> + * Returns true if the VM_* flags are valid.
> + */
> +static inline bool arch_validate_flags(unsigned long flags)
> +{
> +	return true;
> +}
> +#define arch_validate_flags arch_validate_flags
> +#endif

Again, please let's nail down where the arch should define this.

Otherwise, Acked-by: Andrew Morton <akpm@linux-foundation.org>
