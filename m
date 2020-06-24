From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 06/25] mm: Add PG_ARCH_2 page flag
Date: Wed, 24 Jun 2020 11:33:07 -0700
Message-ID: <20200624113307.6165b3db2404c9d37b870a90@linux-foundation.org>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
        <20200624175244.25837-7-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405820AbgFXSdJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 14:33:09 -0400
In-Reply-To: <20200624175244.25837-7-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Steven Price <steven.price@arm.com>

On Wed, 24 Jun 2020 18:52:25 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> From: Steven Price <steven.price@arm.com>
> 
> For arm64 MTE support it is necessary to be able to mark pages that
> contain user space visible tags that will need to be saved/restored e.g.
> when swapped out.
> 
> To support this add a new arch specific flag (PG_ARCH_2) that arch code
> can opt into using ARCH_USES_PG_ARCH_2.
> 
> ...
>
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -217,6 +217,9 @@ u64 stable_page_flags(struct page *page)
>  	u |= kpf_copy_bit(k, KPF_PRIVATE_2,	PG_private_2);
>  	u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
>  	u |= kpf_copy_bit(k, KPF_ARCH,		PG_arch_1);
> +#ifdef CONFIG_ARCH_USES_PG_ARCH_2
> +	u |= kpf_copy_bit(k, KPF_ARCH_2,	PG_arch_2);
> +#endif

Do we need CONFIG_ARCH_USES_PG_ARCH_2?  What would be the downside to
giving every architecture a PG_arch_2, but only arm64 uses it (at
present)?
