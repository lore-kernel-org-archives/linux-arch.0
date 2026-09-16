Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673EB511238;
	Wed, 16 Sep 2026 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568905; cv=none; b=m5NT6uYhdfR0w/j9xX/+rd3986cp16WKFV2UpJbe+28Lav9CNhb6mRk/qvTD9F6kWhn8Evf+0acK3WjzfU7vWJ5SUzNZOvt7w95aDtbdoQ92HM5fmMZl4Jmot26iXiTNZfWRyRpxoabLTfYKE79Kx11DIPhApdL4CZSXGu8xKOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568905; c=relaxed/simple;
	bh=spNPD9k6Nx8PbLEKYN8+WDsvPmPgkuszTarX6izkHIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDls5eIpaYHy0FcoJyOwDU/9r/IN2z5rJoPSTeIvFNPo9GyRHd+MQx+JRa+YPKgBOw0MhNlFyEVaDRumYvvXmCB8LlkMB4vRhHVaKulxyND47Cfl8bk96hc9gnU7irHIUdUT75Dqlsfkxg0LKrWRf4Opvcg2YNIg3WoD8ZI88Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=syNLQ6zB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="syNLQ6zB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5439176A;
	Wed, 16 Sep 2026 07:28:17 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C1383F7B4;
	Wed, 16 Sep 2026 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789568901; bh=spNPD9k6Nx8PbLEKYN8+WDsvPmPgkuszTarX6izkHIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=syNLQ6zBnM1gt+74Ot0yxpVXugmjywzlyYa0Y4SMoh089PhsftIdlhEyUiuHdpw/p
	 8j18sZ84YHcwZ4wx2N3C8ItSn/iYaDMUYNb+m1mp/PBK9o1z2BHBWV7fzKo2cptBHl
	 HEakV4AtFAP8iLh9d8zNfp8KVg3Nh1blHLuEenc8=
Date: Wed, 16 Sep 2026 15:28:16 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Florian Weimer <fweimer@redhat.com>,
	Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
	Uros Bizjak <ubizjak@gmail.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v8 4/4] arm64: vdso32: Implement
 __vdso_futex_robust_try_unlock()
Message-ID: <aqqngEKC_CsrS62n@J2N7QTR9R3>
References: <20260821-tonyk-robust_arm-v8-0-077707b6f1c7@igalia.com>
 <20260821-tonyk-robust_arm-v8-4-077707b6f1c7@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821-tonyk-robust_arm-v8-4-077707b6f1c7@igalia.com>

On Fri, Aug 21, 2026 at 06:50:45PM -0300, André Almeida wrote:
> Based on aarch64 implementation, provide a 32 bit entry point for
> this vDSO.
> 
> In order to keep compatibility with arm64_futex_robust_unlock_get_pop(),
> make sure to store the pop address at r2 and the compare result value
> at r3.

Before we add this to the compat vdso, we'll need to implement this on
arch/arm/.

Otherwise, my comments on the patch for the native vdso functions apply
here too.

Mark.

> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> v7:
>  - The store needs to be a release store, so s/strex/stlex/
>  - result reg clobber modified to "=&r" to make sure the compiler don't use
>  the r3 reg for something else
>  - pop_reg will be read after the execution so it should be an output
>  parameter with "+Q"
> ---
>  arch/arm64/kernel/vdso.c            | 15 ++++++++++++++-
>  arch/arm64/kernel/vdso32/Makefile   |  4 ++++
>  arch/arm64/kernel/vdso32/vdso.lds.S |  9 +++++++++
>  arch/arm64/kernel/vdso32/vfutex.c   | 34 ++++++++++++++++++++++++++++++++++
>  4 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index dc6b582736d0..5cae9c17ec72 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -78,11 +78,19 @@ static inline void vdso_futex_update_ips(struct mm_struct *mm)
>  				VDSO_SYMBOL(vdso, futex_list64_try_unlock_cs_end));
>  }
>  
> +static inline void aarch32_vdso_futex_update_ips(struct mm_struct *mm)
> +{
> +	unsigned long vdso = (unsigned long) mm->context.vdso;
> +
> +	__vdso_futex_update_ips(mm, true,
> +				VDSO_SYMBOL(vdso, futex_list32_try_unlock_cs_start),
> +				VDSO_SYMBOL(vdso, futex_list32_try_unlock_cs_end));
> +}
>  #else
>  static inline void vdso_futex_update_ips(struct mm_struct *mm) {}
> +static inline void aarch32_vdso_futex_update_ips(struct mm_struct *mm) {}
>  #endif /* CONFIG_FUTEX_ROBUST_UNLOCK */
>  
> -
>  static int vdso_mremap(const struct vm_special_mapping *sm,
>  		struct vm_area_struct *new_vma)
>  {
> @@ -195,6 +203,8 @@ static int aarch32_mremap(const struct vm_special_mapping *sm,
>  {
>  	current->mm->context.vdso = (void *)new_vma->vm_start;
>  
> +	aarch32_vdso_futex_update_ips(current->mm);
> +
>  	return 0;
>  }
>  
> @@ -327,6 +337,7 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
>  	return PTR_ERR_OR_ZERO(ret);
>  }
>  
> +
>  int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  {
>  	struct mm_struct *mm = current->mm;
> @@ -347,6 +358,8 @@ int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  	}
>  
>  	ret = aarch32_sigreturn_setup(mm);
> +
> +	aarch32_vdso_futex_update_ips(mm);
>  out:
>  	mmap_write_unlock(mm);
>  	return ret;
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 4bd60f059f4a..f3190125c68b 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -97,6 +97,10 @@ munge := ../../../arm/vdso/vdsomunge
>  hostprogs := $(munge)
>  
>  c-obj-vdso := note.o
> +ifdef CONFIG_FUTEX_ROBUST_UNLOCK
> +  c-obj-vdso += vfutex.o
> +endif
> +
>  c-obj-vdso-gettimeofday := vgettimeofday.o
>  
>  ifneq ($(c-gettimeofday-y),)
> diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
> index 12bfc39e8aab..52ced27d6045 100644
> --- a/arch/arm64/kernel/vdso32/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso32/vdso.lds.S
> @@ -89,6 +89,15 @@ VERSION
>  #endif /* CONFIG_COMPAT_32BIT_TIME */
>  		__vdso_clock_gettime64;
>  		__vdso_clock_getres_time64;
> +#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
> +		__vdso_futex_robust_list32_try_unlock;
> +#endif
>  	local: *;
>  	};
>  }
> +
> +#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
> +VDSO_futex_list32_try_unlock_cs_success = __futex_list32_try_unlock_cs_success;
> +VDSO_futex_list32_try_unlock_cs_start = __futex_list32_try_unlock_cs_start;
> +VDSO_futex_list32_try_unlock_cs_end = __futex_list32_try_unlock_cs_end;
> +#endif
> diff --git a/arch/arm64/kernel/vdso32/vfutex.c b/arch/arm64/kernel/vdso32/vfutex.c
> new file mode 100644
> index 000000000000..0d9080b17965
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso32/vfutex.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/stringify.h>
> +#include <vdso/futex.h>
> +
> +__u32 __vdso_futex_robust_list32_try_unlock(__u32 *lock, __u32 tid, __u32 *pop)
> +{
> +	register __u32 *pop_reg asm("r2") = pop, result_reg asm("r3") = 0;
> +	__u32 val, zero = 0;
> +
> +	asm volatile (
> +		".globl						  "
> +		"__futex_list32_try_unlock_cs_start,		  "
> +		"__futex_list32_try_unlock_cs_success,		  "
> +		"__futex_list32_try_unlock_cs_end		\n"
> +
> +		"retry:						\n"
> +		"	ldrex %[val], %[lock]			\n"
> +		"	cmp %[tid], %[val]			\n"
> +		"	bne __futex_list32_try_unlock_cs_end	\n"
> +		"	stlex %[result], %[zero], %[lock]	\n"
> +		"__futex_list32_try_unlock_cs_start:		\n"
> +		"	cmp %[result], #0			\n"
> +		"	bne retry				\n"
> +		"__futex_list32_try_unlock_cs_success:		\n"
> +		"	str %[zero], %[pop_reg]			\n"
> +		"__futex_list32_try_unlock_cs_end:		\n"
> +
> +		: [val] "=&r" (val), [result] "=&r" (result_reg), [pop_reg] "+Q" (*pop_reg)
> +		: [tid] "r" (tid), [lock] "Q" (*lock), [zero] "r" (zero)
> +		: "cc", "memory"
> +	);
> +
> +	return val;
> +}
> 
> -- 
> 2.55.0
> 
