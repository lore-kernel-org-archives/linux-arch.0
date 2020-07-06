From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 06/26] mm: Add PG_arch_2 page flag
Date: Mon, 6 Jul 2020 10:24:04 +0200
Message-ID: <27fe044a-8315-5394-575e-8f763696b0cd@redhat.com>
References: <20200703153718.16973-1-catalin.marinas@arm.com>
 <20200703153718.16973-7-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31221 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726277AbgGFIYT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jul 2020 04:24:19 -0400
In-Reply-To: <20200703153718.16973-7-catalin.marinas@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Price <steven.price@arm.com>

On 03.07.20 17:36, Catalin Marinas wrote:
> From: Steven Price <steven.price@arm.com>
> 
> For arm64 MTE support it is necessary to be able to mark pages that
> contain user space visible tags that will need to be saved/restored e.g.
> when swapped out.
> 
> To support this add a new arch specific flag (PG_arch_2). This flag is
> only available on 64-bit architectures due to the limited number of
> spare page flags on the 32-bit ones.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> [catalin.marinas@arm.com: use CONFIG_64BIT for guarding this new flag]
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
> Notes:
>     v6:
>     - Using CONFIG_64BIT instead of a new CONFIG_ARCH_USES_PG_ARCH_2 option.
>     
>     New in v4.
> 
>  fs/proc/page.c                    | 3 +++
>  include/linux/kernel-page-flags.h | 1 +
>  include/linux/page-flags.h        | 3 +++
>  include/trace/events/mmflags.h    | 9 ++++++++-
>  tools/vm/page-types.c             | 2 ++
>  5 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index f909243d4a66..9f1077d94cde 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -217,6 +217,9 @@ u64 stable_page_flags(struct page *page)
>  	u |= kpf_copy_bit(k, KPF_PRIVATE_2,	PG_private_2);
>  	u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
>  	u |= kpf_copy_bit(k, KPF_ARCH,		PG_arch_1);
> +#ifdef CONFIG_64BIT
> +	u |= kpf_copy_bit(k, KPF_ARCH_2,	PG_arch_2);
> +#endif
>  
>  	return u;
>  };
> diff --git a/include/linux/kernel-page-flags.h b/include/linux/kernel-page-flags.h
> index abd20ef93c98..eee1877a354e 100644
> --- a/include/linux/kernel-page-flags.h
> +++ b/include/linux/kernel-page-flags.h
> @@ -17,5 +17,6 @@
>  #define KPF_ARCH		38
>  #define KPF_UNCACHED		39
>  #define KPF_SOFTDIRTY		40
> +#define KPF_ARCH_2		41
>  
>  #endif /* LINUX_KERNEL_PAGE_FLAGS_H */
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 6be1aa559b1e..276140c94f4a 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -135,6 +135,9 @@ enum pageflags {
>  #if defined(CONFIG_IDLE_PAGE_TRACKING) && defined(CONFIG_64BIT)
>  	PG_young,
>  	PG_idle,
> +#endif
> +#ifdef CONFIG_64BIT
> +	PG_arch_2,
>  #endif
>  	__NR_PAGEFLAGS,

People are usually *very* picky when it comes to new page flags. It
somewhat concerns me that we bump up __NR_PAGEFLAGS for any 64bit arch.
That feels wrong.


-- 
Thanks,

David / dhildenb
