Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8170381EB7;
	Fri, 17 Jul 2026 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784313079; cv=none; b=COMZp/56pook/tdNneOQQhbIICYOY/hCaFHftX6huTyKBDFnl7YdAEl2vO2uHn3rGoNX6tqGBNQPi5+SveXNZ7oGUt8W0IZDx49uIR8isVgrbJq5N7on7Mn0kRBnJ6BKvx9fumq48OWfMb/YGdmLvnCdwe2sP2bqNycAtdKuYJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784313079; c=relaxed/simple;
	bh=kg8dmHrx04NL9M/AELLM+nB/YWf4ZTb98P3P9QKjC1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAJ0PSWF6PCVApc/IIbLj24w9nKwR457/atSfAjrIqemrCXm97G5l82cVzQVPGAwHqpqBrszhOGLhp8cZlV37OiSiKzeOlgZdA/8mFKNmKxVXdWuSc0kmstPoaJekOelVadDcPzndw/xyKYrVGhvtZur6lBlLjgWzjSDatgUHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jgCSFcmV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jgCSFcmV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74AFA1476;
	Fri, 17 Jul 2026 11:31:11 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEE353F905;
	Fri, 17 Jul 2026 11:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784313075; bh=kg8dmHrx04NL9M/AELLM+nB/YWf4ZTb98P3P9QKjC1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgCSFcmVbWxN2tEPfTO+mAPkZF1Wl1hJ8mrMMjhG3gsa5eclTxUgXGdB3rozf8ZTb
	 +YJzdr66SJtRlV/IaSBcycJWviK+kXolDASNgEz2OSoC67bYrhGCsQBDHUgJus7KnK
	 iAkmFPubtHTZYRfRaX7eS74oiVrVd+Z5p25raMYM=
Date: Fri, 17 Jul 2026 19:31:09 +0100
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
Subject: Re: [PATCH v5 2/4] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
Message-ID: <alp07SOPOVKMQSzM@J2N7QTR9R3>
References: <20260717-tonyk-robust_arm-v5-0-ffd1ad318d17@igalia.com>
 <20260717-tonyk-robust_arm-v5-2-ffd1ad318d17@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717-tonyk-robust_arm-v5-2-ffd1ad318d17@igalia.com>

On Fri, Jul 17, 2026 at 11:41:41AM -0300, André Almeida wrote:
> Based on the x86 implementation, implement the vDSO function for unlocking
> a robust futex correctly.

Hi Andre,

As mentioned on the prior patch, it would be easier to review this if
all of the compat VDSO additions were in this patch, rather than half of
those being in the prior patch. I left some suggestions there as to how
to split that.

> Commit a2274cc0091e ("x86/vdso: Implement __vdso_futex_robust_try_unlock()")
> has the full explanation about why this mechanism is needed.

Can we please have a short explanation here? IIUC there's a race where
one thread has a dangling pending op for a VA, but another thread has
re-allocated that VA, and the kernel can corrupt the memory at that VA.

TBH, from reading a2274cc0091e I'm struggling to follow the race, and
how this mechanism helps, but that might just be due to my brain not
working at the end of the week.

> The unlock assembly sequence for arm64 is:
> 
> 	__vdso_futex_robust_list64_try_unlock:
> 	retry:
> 		ldxr	w8, [x0] // Load the value from *futex
> 		cmp	w1, w8   // Compare with TID
> 		b.ne	__vdso_futex_list64_try_unlock_cs_end
> 		stlxr	w3, wzr, [x0] // Try to zero *futex
> 	__vdso_futex_list64_try_unlock_cs_start:
> 		cbnz	w3, retry
> 		str	xzr, [x2] // After zeroing *futex, zero *op_pending
> 	__vdso_futex_list64_try_unlock_cs_end>:
> 
> The decision regarding if the pointer should be cleared or not lies on
> checking the w3 register:
> 
> 	return (regs->user_regs[3]) ? NULL : (void __user *)
> 		regs->user_regs.regs[2];

I don't think the description of the assembly helps without a complete
description of the problem, and it'd be best to just remove the assembly
from the commit message, and just describe what the kernel does
depending on whether the userspace cmpxchg (using LDXR + STLXR) succeded
or failed.

> If it's zero, that means that the exclusive store worked and the kernel
> should clear op_pending (if userspace didn't managed to) stored at x2.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> Notes:
>  - Only LL/SC for now but I can add LSE later if this looks good
> 
> v4:
>  - Guard makefile for vfutex.o with ifdef
>  - Moved _start label one instruction above
>  - Use results register (w3) to check for store success instead of using zero
>    flag
> 
> v3:
>  - Managed to get pop to always be stored at x2
> ---
>  arch/arm64/Kconfig                    |  1 +
>  arch/arm64/include/asm/futex_robust.h | 19 +++++++++++++++++++
>  arch/arm64/kernel/vdso/Makefile       | 10 ++++++++++
>  arch/arm64/kernel/vdso/vfutex.c       | 35 +++++++++++++++++++++++++++++++++++
>  4 files changed, 65 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b3afe0688919..0582172811d9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -221,6 +221,7 @@ config ARM64
>  	select HAVE_RELIABLE_STACKTRACE
>  	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
>  	select HAVE_FUNCTION_ARG_ACCESS_API
> +	select HAVE_FUTEX_ROBUST_UNLOCK
>  	select MMU_GATHER_RCU_TABLE_FREE
>  	select HAVE_RSEQ
>  	select HAVE_RUST if RUSTC_SUPPORTS_ARM64
> diff --git a/arch/arm64/include/asm/futex_robust.h b/arch/arm64/include/asm/futex_robust.h
> new file mode 100644
> index 000000000000..64f22166756a
> --- /dev/null
> +++ b/arch/arm64/include/asm/futex_robust.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM64_FUTEX_ROBUST_H
> +#define _ASM_ARM64_FUTEX_ROBUST_H
> +
> +#include <asm/ptrace.h>
> +
> +static __always_inline void __user *arm64_futex_robust_unlock_get_pop(struct pt_regs *regs)
> +{
> +	/*
> +	 * w3 is stores the result of the stlxr instruction. If it's zero, the then
> +	 * the ll/sc cmpxchg succeeded and the pending op pointer needs to be cleared.
> +	 */
> +	return (regs->user_regs.regs[3]) ? NULL : (void __user *) regs->user_regs.regs[2];
> +}
> +
> +#define arch_futex_robust_unlock_get_pop(regs)	\
> +	arm64_futex_robust_unlock_get_pop(regs)
> +
> +#endif /* _ASM_ARM64_FUTEX_ROBUST_H */
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 7dec05dd33b7..985346c7a0bb 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -11,6 +11,10 @@ include $(srctree)/lib/vdso/Makefile.include
>  
>  obj-vdso := vgettimeofday.o note.o sigreturn.o vgetrandom.o vgetrandom-chacha.o
>  
> +ifdef CONFIG_FUTEX_ROBUST_UNLOCK
> +  obj-vdso += vfutex.o
> +endif
> +
>  # Build rules
>  targets := $(obj-vdso) vdso.so vdso.so.dbg
>  obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
> @@ -45,9 +49,11 @@ CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables
>  
>  CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_REMOVE_VDSO)
>  CFLAGS_REMOVE_vgetrandom.o = $(CC_FLAGS_REMOVE_VDSO)
> +CFLAGS_REMOVE_vfutex.o = $(CC_FLAGS_REMOVE_VDSO)
>  
>  CFLAGS_vgettimeofday.o = $(CC_FLAGS_ADD_VDSO)
>  CFLAGS_vgetrandom.o = $(CC_FLAGS_ADD_VDSO)
> +CFLAGS_vfutex.o = $(CC_FLAGS_ADD_VDSO)
>  
>  ifneq ($(c-gettimeofday-y),)
>    CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
> @@ -57,6 +63,10 @@ ifneq ($(c-getrandom-y),)
>    CFLAGS_vgetrandom.o += -include $(c-getrandom-y)
>  endif
>  
> +ifneq ($(c-futex-y),)
> +  CFLAGS_vfutex.o += -include $(c-futex-y)
> +endif
> +
>  targets += vdso.lds
>  CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
>  
> diff --git a/arch/arm64/kernel/vdso/vfutex.c b/arch/arm64/kernel/vdso/vfutex.c
> new file mode 100644
> index 000000000000..4c69d92426fd
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso/vfutex.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/stringify.h>
> +#include <vdso/futex.h>
> +
> +#define LABEL(name, sz) __stringify(__futex_list##sz##_try_unlock_cs_##name)
> +
> +#define GLOBLS(sz) ".globl " LABEL(start, sz) ", " LABEL(success, sz) ", " LABEL(end, sz) "\n"

Since we don't share the assembly between native and compat, it would be
clearer to have these inline within the assembly block, and without the
'sz' parameter.

Using the full names would make this easier to grep for.

Mark.

> +
> +__u32 __vdso_futex_robust_list64_try_unlock(__u32 *lock, __u32 tid, __u64 *pop)
> +{
> +	register __u64 *pop_reg asm("x2") = pop;
> +	register __u32 result_reg asm("w3") = 0;
> +	__u32 val;
> +
> +	asm volatile (
> +		GLOBLS(64)
> +		"	prfm pstl1strm, %[lock]			\n"
> +		"retry:						\n"
> +		"	ldxr %w[val], %[lock]			\n"
> +		"	cmp %w[tid], %w[val]			\n"
> +		"	bne " LABEL(end, 64)"			\n"
> +		"	stlxr %w[result], wzr, %[lock]		\n"
> +		LABEL(start, 64)":				\n"
> +		"	cbnz %w[result], retry			\n"
> +		LABEL(success, 64)":				\n"
> +		"	str xzr, %[pop_reg]			\n"
> +		LABEL(end, 64)":				\n"
> +
> +		: [val] "=&r" (val), [result] "=&r" (result_reg)
> +		: [tid] "r" (tid), [lock] "Q" (*lock), [pop_reg] "Q" (*pop_reg)
> +		: "cc", "memory"
> +	);
> +
> +	return val;
> +}
> 
> -- 
> 2.55.0
> 
