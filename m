From: Luis Machado <luis.machado@linaro.org>
Subject: Re: [PATCH v5 19/25] arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS
 support
Date: Thu, 25 Jun 2020 14:10:10 -0300
Message-ID: <7fd536af-f9fa-aa10-a4c3-001e80dd7d7b@linaro.org>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
 <20200624175244.25837-20-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406608AbgFYRKT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jun 2020 13:10:19 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E281C08C5C1
        for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2020 10:10:19 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id k18so6049458qke.4
        for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2020 10:10:19 -0700 (PDT)
In-Reply-To: <20200624175244.25837-20-catalin.marinas@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Andrew Morton <akpm@linux-foundation.org>, Alan Hayward <Alan.Hayward@arm.com>, Omair Javaid <omair.javaid@linaro.org>

Hi Catalin,

I have one point below I wanted to clarify regarding 
PEEKMTETAGS/POKEMTETAGS.

But before that, I've pushed v2 of the MTE series for GDB here:

https://sourceware.org/git/?p=binutils-gdb.git;a=shortlog;h=refs/heads/users/luisgpm/aarch64-mte-v2

That series adds sctlr and gcr registers to the NT_ARM_MTE (still using 
a dummy value of 0x407) register set. It would be nice if the Linux 
Kernel and the debuggers were in sync in terms of supporting this new 
register set. GDB assumes the register set exists if HWCAP2_MTE is there.

So, if we want to adjust the register set, we should probably consider 
doing that now. That prevents the situation where debuggers would need 
to do another check to confirm NT_ARM_MTE is exported. I'd rather avoid 
that.

What do you think?


On 6/24/20 2:52 PM, Catalin Marinas wrote:
> Add support for bulk setting/getting of the MTE tags in a tracee's
> address space at 'addr' in the ptrace() syscall prototype. 'data' points
> to a struct iovec in the tracer's address space with iov_base
> representing the address of a tracer's buffer of length iov_len. The
> tags to be copied to/from the tracer's buffer are stored as one tag per
> byte.
> 
> On successfully copying at least one tag, ptrace() returns 0 and updates
> the tracer's iov_len with the number of tags copied. In case of error,
> either -EIO or -EFAULT is returned, trying to follow the ptrace() man
> page.
> 
> Note that the tag copying functions are not performance critical,
> therefore they lack optimisations found in typical memory copy routines.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Alan Hayward <Alan.Hayward@arm.com>
> Cc: Luis Machado <luis.machado@linaro.org>
> Cc: Omair Javaid <omair.javaid@linaro.org>
> ---
> 
> Notes:
>      v4:
>      - Following the change to only clear the tags in a page if it is mapped
>        to user with PROT_MTE, ptrace() now will refuse to access tags in
>        pages not previously mapped with PROT_MTE (PG_mte_tagged set). This is
>        primarily to avoid leaking uninitialised tags to user via ptrace().
>      - Fix SYM_FUNC_END argument typo.
>      - Rename MTE_ALLOC_* to MTE_GRANULE_*.
>      - Use uao_user_alternative for the user access in case we ever want to
>        call mte_copy_tags_* with a kernel buffer. It also matches the other
>        uaccess routines in the kernel.
>      - Simplify arch_ptrace() slightly.
>      - Reorder down_write_killable() with access_ok() in
>        __access_remote_tags().
>      - Handle copy length 0 in mte_copy_tags_{to,from}_user().
>      - Use put_user() instead of __put_user().
>      
>      New in v3.
> 
>   arch/arm64/include/asm/mte.h         |  17 ++++
>   arch/arm64/include/uapi/asm/ptrace.h |   3 +
>   arch/arm64/kernel/mte.c              | 139 +++++++++++++++++++++++++++
>   arch/arm64/kernel/ptrace.c           |   7 ++
>   arch/arm64/lib/mte.S                 |  53 ++++++++++
>   5 files changed, 219 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index c93047eff9fe..5fe9678d2e14 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -5,6 +5,11 @@
>   #ifndef __ASM_MTE_H
>   #define __ASM_MTE_H
>   
> +#define MTE_GRANULE_SIZE	UL(16)
> +#define MTE_GRANULE_MASK	(~(MTE_GRANULE_SIZE - 1))
> +#define MTE_TAG_SHIFT		56
> +#define MTE_TAG_SIZE		4
> +
>   #ifndef __ASSEMBLY__
>   
>   #include <linux/page-flags.h>
> @@ -12,6 +17,10 @@
>   #include <asm/pgtable-types.h>
>   
>   void mte_clear_page_tags(void *addr);
> +unsigned long mte_copy_tags_from_user(void *to, const void __user *from,
> +				      unsigned long n);
> +unsigned long mte_copy_tags_to_user(void __user *to, void *from,
> +				    unsigned long n);
>   
>   #ifdef CONFIG_ARM64_MTE
>   
> @@ -25,6 +34,8 @@ void mte_thread_switch(struct task_struct *next);
>   void mte_suspend_exit(void);
>   long set_mte_ctrl(unsigned long arg);
>   long get_mte_ctrl(void);
> +int mte_ptrace_copy_tags(struct task_struct *child, long request,
> +			 unsigned long addr, unsigned long data);
>   
>   #else
>   
> @@ -54,6 +65,12 @@ static inline long get_mte_ctrl(void)
>   {
>   	return 0;
>   }
> +static inline int mte_ptrace_copy_tags(struct task_struct *child,
> +				       long request, unsigned long addr,
> +				       unsigned long data)
> +{
> +	return -EIO;
> +}
>   
>   #endif
>   
> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> index 06413d9f2341..758ae984ff97 100644
> --- a/arch/arm64/include/uapi/asm/ptrace.h
> +++ b/arch/arm64/include/uapi/asm/ptrace.h
> @@ -76,6 +76,9 @@
>   /* syscall emulation path in ptrace */
>   #define PTRACE_SYSEMU		  31
>   #define PTRACE_SYSEMU_SINGLESTEP  32
> +/* MTE allocation tag access */
> +#define PTRACE_PEEKMTETAGS	  33
> +#define PTRACE_POKEMTETAGS	  34
>   
>   #ifndef __ASSEMBLY__
>   
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 09cf76fc1090..3e08aea56e7a 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -4,14 +4,18 @@
>    */
>   
>   #include <linux/bitops.h>
> +#include <linux/kernel.h>
>   #include <linux/mm.h>
>   #include <linux/prctl.h>
>   #include <linux/sched.h>
> +#include <linux/sched/mm.h>
>   #include <linux/string.h>
>   #include <linux/thread_info.h>
> +#include <linux/uio.h>
>   
>   #include <asm/cpufeature.h>
>   #include <asm/mte.h>
> +#include <asm/ptrace.h>
>   #include <asm/sysreg.h>
>   
>   void mte_sync_tags(pte_t *ptep, pte_t pte)
> @@ -173,3 +177,138 @@ long get_mte_ctrl(void)
>   
>   	return ret;
>   }
> +
> +/*
> + * Access MTE tags in another process' address space as given in mm. Update
> + * the number of tags copied. Return 0 if any tags copied, error otherwise.
> + * Inspired by __access_remote_vm().
> + */
> +static int __access_remote_tags(struct task_struct *tsk, struct mm_struct *mm,
> +				unsigned long addr, struct iovec *kiov,
> +				unsigned int gup_flags)
> +{
> +	struct vm_area_struct *vma;
> +	void __user *buf = kiov->iov_base;
> +	size_t len = kiov->iov_len;
> +	int ret;
> +	int write = gup_flags & FOLL_WRITE;
> +
> +	if (!access_ok(buf, len))
> +		return -EFAULT;
> +
> +	if (mmap_read_lock_killable(mm))
> +		return -EIO;
> +
> +	while (len) {
> +		unsigned long tags, offset;
> +		void *maddr;
> +		struct page *page = NULL;
> +
> +		ret = get_user_pages_remote(tsk, mm, addr, 1, gup_flags,
> +					    &page, &vma, NULL);
> +		if (ret <= 0)
> +			break;
> +
> +		/*
> +		 * Only copy tags if the page has been mapped as PROT_MTE
> +		 * (PG_mte_tagged set). Otherwise the tags are not valid and
> +		 * not accessible to user. Moreover, an mprotect(PROT_MTE)
> +		 * would cause the existing tags to be cleared if the page
> +		 * was never mapped with PROT_MTE.
> +		 */
> +		if (!test_bit(PG_mte_tagged, &page->flags)) {
> +			ret = -EOPNOTSUPP;
> +			put_page(page);
> +			break;
> +		}
> +
> +		/* limit access to the end of the page */
> +		offset = offset_in_page(addr);
> +		tags = min(len, (PAGE_SIZE - offset) / MTE_GRANULE_SIZE);
> +
> +		maddr = page_address(page);
> +		if (write) {
> +			tags = mte_copy_tags_from_user(maddr + offset, buf, tags);
> +			set_page_dirty_lock(page);
> +		} else {
> +			tags = mte_copy_tags_to_user(buf, maddr + offset, tags);
> +		}
> +		put_page(page);
> +
> +		/* error accessing the tracer's buffer */
> +		if (!tags)
> +			break;
> +
> +		len -= tags;
> +		buf += tags;
> +		addr += tags * MTE_GRANULE_SIZE;
> +	}
> +	mmap_read_unlock(mm);
> +
> +	/* return an error if no tags copied */
> +	kiov->iov_len = buf - kiov->iov_base;
> +	if (!kiov->iov_len) {
> +		/* check for error accessing the tracee's address space */
> +		if (ret <= 0)
> +			return -EIO;
> +		else
> +			return -EFAULT;
> +	}
> +
> +	return 0;
> +}

My understanding is that both the PEEKMTETAGS and POKEMTETAGS can 
potentially read/write less tags than requested, right? The iov_len 
field will be updated accordingly.

So the ptrace caller would need to loop and make sure all the tags were 
read/written, right?

I'm considering the situation where the kernel reads/writes 0 tags (when 
requested to read/write 1 or more tags) an error we can't recover from. 
So this may indicate a page without PROT_MTE or an invalid address.

Does that make sense?
