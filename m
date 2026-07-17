Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E9927AC4C;
	Fri, 17 Jul 2026 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311527; cv=none; b=agi3DWekvDEsKyGu0ReAox/PBdhVIbVltCKF5naEfoB5pF+bwa5XqmdnkFUtKjfPNGYZPW/CSSoYAbUnOUcPeCXZKwOB/xzG7Ie6+w+81OiL9tMAaHaKaUQyc5RY7KvpogZsLaeONWu6nyCIzZgh6MwJOCzxUIH+JSp07iVXCss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311527; c=relaxed/simple;
	bh=3cwl4ifFjBgo6FPuzW0/twAl0OunmfLripziCFm2lCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArIaM+OVlnWw9eEKtVWAWE1h3PnhFRzz7hkjSB9zCstbnVMlK6QC8JXBZ1JW5CLhTw7gUZ7zvC8NlsFTtGBEUaA9UmeBIU17K/uSHity+0oH2WA6Bzp8Z5ZtyM4PEavyqmQ3DznBBLGUy4zJz+m1xuHjnPjZDT7Dftc5anQfu/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Yup8Qa8y; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Yup8Qa8y"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CD8B1476;
	Fri, 17 Jul 2026 11:05:20 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72A7A3F905;
	Fri, 17 Jul 2026 11:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784311524; bh=3cwl4ifFjBgo6FPuzW0/twAl0OunmfLripziCFm2lCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yup8Qa8yYUlKCLIrDPdJmdDtINkGZzVaaJS6/HVRI7O7r2dgfBKP60YMTux8+f8SC
	 J3corhTbJb2XKXv4GBTf2L+wmrqL8TtfaEA6OVC77tgVzhvcSsvE7W6LBu07PRE3nC
	 dtNr6m9guZbdn+MaeQleQkL4BR4O4pjtgBoyZsg0=
Date: Fri, 17 Jul 2026 19:05:14 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Carlos O'Donell <carlos@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Florian Weimer <fweimer@redhat.com>,
	Rich Felker <dalias@aerifal.cx>,
	Torvald Riegel <triegel@redhat.com>,
	Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
	Uros Bizjak <ubizjak@gmail.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v5 1/4] arm64: vdso: Prepare for robust futex unlock
 support
Message-ID: <alpu2j7gcrgd70Xk@J2N7QTR9R3>
References: <20260717-tonyk-robust_arm-v5-0-ffd1ad318d17@igalia.com>
 <20260717-tonyk-robust_arm-v5-1-ffd1ad318d17@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717-tonyk-robust_arm-v5-1-ffd1ad318d17@igalia.com>

Hi Andre,
On Fri, Jul 17, 2026 at 11:41:40AM -0300, André Almeida wrote:
> There will be a VDSO function to unlock non-contended robust futexes in
> user space. The unlock sequence is racy vs. clearing the list_pending_op
> pointer in the task's robust list head. To plug this race the kernel needs
> to know the critical section window so it can clear the pointer when the
> task is interrupted within that race window. The window is determined by
> labels in the inline assembly.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>

I think this patch is confusing, because half of the additions are
tightly coupled with the AArch64-specific changes in the second patch.

I think it would be better to have preparatory patches which:

(1) Split vdso_mremap() into vdso_mremap(), and aarch32_mremap(). No
    functional change, no other additions. Possibly have a common
    __vdso_mremap() helper.

(2) If necessary, add only the common helper function(s) here, no native
    symbols, etc. anything specific to the native vDSO should be in the
    next patch, which adds the assembly etc.

See below for more on that.

> ---
> v4:
> - Guard symbols from vdso.lds.S with ifdef
> - drop update_ips() from sigpage remap function
> 
> v3:
>  - Fix adding vdso base addr twice
>  - Call vdso_futex_robust_unlock_update_ips() on remap as well
> v2:
>  - Fixed linker not finding VDSO symbols
> ---
>  arch/arm64/kernel/vdso.c          | 35 ++++++++++++++++++++++++++++++++++-
>  arch/arm64/kernel/vdso/vdso.lds.S |  9 +++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 592dd8668de4..ff43b74e514e 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -11,6 +11,7 @@
>  #include <linux/clocksource.h>
>  #include <linux/elf.h>
>  #include <linux/err.h>
> +#include <linux/futex.h>
>  #include <linux/errno.h>
>  #include <linux/gfp.h>
>  #include <linux/kernel.h>
> @@ -57,11 +58,41 @@ static struct vdso_abi_info vdso_info[] __ro_after_init = {
>  #endif /* CONFIG_COMPAT_VDSO */
>  };
>  
> +#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
> +static void vdso_futex_robust_unlock_update_ips(enum vdso_abi abi, struct mm_struct *mm)
> +{
> +	unsigned long vdso = (unsigned long) mm->context.vdso;
> +	struct futex_mm_data *fd = &mm->futex;
> +	uintptr_t success, end;
> +
> +	if (abi == VDSO_ABI_AA64) {
> +		success = (uintptr_t) VDSO_SYMBOL(vdso, futex_list64_try_unlock_cs_start);
> +		end = (uintptr_t) VDSO_SYMBOL(vdso, futex_list64_try_unlock_cs_end);

Is this supposed to be the success label, or the start label?

I see x86 uses 'start', so I assume s/success/start/ here.

> +
> +		futex_set_vdso_cs_range(fd, 0, success, end, false);
> +	}
> +}

I think it would be better to have a structure of functions along the
lines of a common helper:

| static inline void __vdso_futex_update_ips(struct mm_struct *mm, bool is_32bit,
| 					   void *startp,
| 					   void *endp)
| {
| 	unsigned long start = (unsigned long)startp;
| 	unsigned long end = (unsigned long)endp;
| 
| 	struct futex_mm_data *fd = &mm->futex;
| 	futex_set_vdso_cs_range(fd, 0, start, end, is_32bit);
| }

... and then subsequent patches can add the native/compat cases as
callers of that common helper:

| static inline void vdso_futex_update_ips(struct mm_struct *mm)
| {
| 	unsigned long vdso = (unsigned long)mm->context.vdso;
| 	__vdso_futex_update_ips(mm, false,
| 				VDSO_SYMBOL(vdso, futex_list64_try_unlock_cs_start),
| 				VDSO_SYMBOL(vdso, futex_list64_try_unlock_cs_end));
| 
| }
| 
| static inline void aarch32_vdso_futex_update_ips(struct mm_struct *mm)
| {
| 	unsigned long vdso = (unsigned long)mm->context.vdso;
| 	__vdso_futex_update_ips(mm, true,
| 				VDSO_SYMBOL(vdso, futex_list32_try_unlock_cs_start),
| 				VDSO_SYMBOL(vdso, futex_list32_try_unlock_cs_end));
| 
| }

> +#else
> +static inline void vdso_futex_robust_unlock_update_ips(enum vdso_abi abi, struct mm_struct *mm) { }
> +#endif /* CONFIG_FUTEX_ROBUST_UNLOCK */
> +
>  static int vdso_mremap(const struct vm_special_mapping *sm,
>  		struct vm_area_struct *new_vma)
>  {
>  	current->mm->context.vdso = (void *)new_vma->vm_start;
>  
> +	vdso_futex_robust_unlock_update_ips(VDSO_ABI_AA64, current->mm);
> +
> +	return 0;
> +}
> +
> +static int vdso32_mremap(const struct vm_special_mapping *sm,
> +		struct vm_area_struct *new_vma)
> +{
> +	current->mm->context.vdso = (void *)new_vma->vm_start;
> +
> +	vdso_futex_robust_unlock_update_ips(VDSO_ABI_AA32, current->mm);
> +
>  	return 0;
>  }

As above, I think we should introduce this as a separate patch, and for
consistency with other parts of this file, the prefix should be
'aarch32_' rather than 'vdso32_'

>  
> @@ -134,6 +165,8 @@ static int __setup_additional_pages(enum vdso_abi abi,
>  	if (IS_ERR(ret))
>  		goto up_fail;
>  
> +	vdso_futex_robust_unlock_update_ips(abi, mm);
> +

As above, I think this shouldn't be called here.

The call for the native vdso should be added to
arch_setup_additional_pages() along with the other additions for the
native vdso. The call for the compat vdso should be added to
aarch32_setup_additional_pages().

[...]  

> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
> index 52314be29191..225f59bb81d1 100644
> --- a/arch/arm64/kernel/vdso/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> @@ -104,6 +104,9 @@ VERSION
>  		__kernel_clock_gettime;
>  		__kernel_clock_getres;
>  		__kernel_getrandom;
> +#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
> +		__vdso_futex_robust_list64_try_unlock;
> +#endif
>  	local: *;
>  	};
>  }
> @@ -112,3 +115,9 @@ VERSION
>   * Make the sigreturn code visible to the kernel.
>   */
>  VDSO_sigtramp		= __kernel_rt_sigreturn;
> +
> +#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
> +VDSO_futex_list64_try_unlock_cs_start = __futex_list64_try_unlock_cs_start;
> +VDSO_futex_list64_try_unlock_cs_success = __futex_list64_try_unlock_cs_success;
> +VDSO_futex_list64_try_unlock_cs_end = __futex_list64_try_unlock_cs_end;
> +#endif

These additions should all be in the next patch which actually adds the
native implementation.

Mark.
