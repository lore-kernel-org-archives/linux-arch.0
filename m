Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26097 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751077AbdAKS0N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Jan 2017 13:26:13 -0500
Subject: Re: [RFC, PATCHv2 29/29] mm, x86: introduce RLIMIT_VADDR
References: <20161227015413.187403-1-kirill.shutemov@linux.intel.com>
 <20161227015413.187403-30-kirill.shutemov@linux.intel.com>
 <5a3dcc25-b264-37c7-c090-09981b23940d@intel.com>
 <20170105192910.q26ozg4ci4i3j2ai@black.fi.intel.com>
 <161ece66-fbf4-cb89-3da6-91b4851af69f@intel.com>
 <CALCETrUQ2+P424d9MW-Dy2yQ0+EnMfBuY80wd8NkNmc8is0AUw@mail.gmail.com>
 <978d5f1a-ec4d-f747-93fd-27ecfe10cb88@intel.com>
 <20170111142904.GD4895@node.shutemov.name>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <3c886ad1-6c70-5875-1e69-4bcef4dbd881@intel.com>
Date: Wed, 11 Jan 2017 10:26:03 -0800
MIME-Version: 1.0
In-Reply-To: <20170111142904.GD4895@node.shutemov.name>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andy Lutomirski <luto@amacapital.net>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>
Message-ID: <20170111182603.q-RJf2uHtOK7Wx3iQ6UsVcmY_6Gy3fMBnHgt2OcMVQM@z>

On 01/11/2017 06:29 AM, Kirill A. Shutemov wrote:
> +#define mmap_max_addr() \
> +({									\
> +	unsigned long max_addr = min(TASK_SIZE, rlimit(RLIMIT_VADDR));	\
> +	/* At the moment, MPX cannot handle addresses above 47-bits */	\
> +	if (max_addr > USER_VADDR_LIM &&				\
> +			kernel_managing_mpx_tables(current->mm))	\
> + 		max_addr = USER_VADDR_LIM;				\
> + 	max_addr;							\
> +})

The bad part about this is that it adds code to a relatively fast path,
and the check that it's doing will not change its result for basically
the entire life of the process.

I'd much rather see this checking done at the point that MPX is enabled
and at the point the limit is changed.  Those are both super-rare paths.

>  extern u16 amd_get_nb_id(int cpu);
>  extern u32 amd_get_nodes_per_socket(void);
>  
> diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
> index 324e5713d386..04fa386a165a 100644
> --- a/arch/x86/mm/mpx.c
> +++ b/arch/x86/mm/mpx.c
> @@ -354,10 +354,22 @@ int mpx_enable_management(void)
>  	 */
>  	bd_base = mpx_get_bounds_dir();
>  	down_write(&mm->mmap_sem);
> +
> +	/*
> +	 * MPX doesn't support addresses above 47-bits yes.
> +	 * Make sure nothing is mapped there before enabling.
> +	 */
> +	if (find_vma(mm, 1UL << 47)) {
> +		pr_warn("%s (%d): MPX cannot handle addresses above 47-bits. "
> +				"Disabling.", current->comm, current->pid);
> +		ret = -ENXIO;
> +		goto out;
> +	}

I don't think allowing userspace to spam unlimited amounts of message
into the kernel log is a good idea. :)  But a WARN_ONCE() might not kill
any puppies.

