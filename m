Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823D753D0BC;
	Wed, 16 Sep 2026 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568845; cv=none; b=hAiYpaRYf11lK6NIx1p1fABpfmZd3C+VwxluxFurwRAIugpMdH1yFFin0CbXlCpQrVcm6cSK7YTEd1/Duq+2GeYTY2ST/OQ8VR/8ZtojHXSoA+owXO6DM/PXA3cm0/Lk5vv48eJKQlXg+DktbyVxeoV4o5V0/31uUitpYXfq+HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568845; c=relaxed/simple;
	bh=kNIvL+nIWNr0wurdCoZif5oJnH852ZRM+p4L+qRjfqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6Zxinr1JrNJ+FZ4PMudou/hhDj5cwSJyU3eFdzDqhZIZdAOOvx7HVAbUgLEuid+5jsNyGzHyR+5XKdZDFAyCNZNWeY3YMpjwwZfArgH44PZT3F+pqZjTqFGplbgnu45y5zBE+f4gb99lH9RvDusuZC4w15Oc0tPeMQsSEiSexI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UGmFTW7s; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UGmFTW7s"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59227176A;
	Wed, 16 Sep 2026 07:27:19 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 430213F7B4;
	Wed, 16 Sep 2026 07:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789568842; bh=kNIvL+nIWNr0wurdCoZif5oJnH852ZRM+p4L+qRjfqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGmFTW7sn4XYhLhfxLemYUWKFqqyqor+Cx+FpVBNW9BMVrfNjysMoRrLxbazariuc
	 2qVtvOwGtrzkBNG0o4mbvCQeLQFzSBnkgEasNR8CZ5ZlpElZk/6bE088+e529o0cqB
	 YAN48wWAwTvOuhl952SbNTYnWX+otfGBTzkN/PfM=
Date: Wed, 16 Sep 2026 15:27:17 +0100
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
Subject: Re: [PATCH v8 2/4] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
Message-ID: <aqqkX8GyxgdtoOmc@J2N7QTR9R3>
References: <20260821-tonyk-robust_arm-v8-0-077707b6f1c7@igalia.com>
 <20260821-tonyk-robust_arm-v8-2-077707b6f1c7@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821-tonyk-robust_arm-v8-2-077707b6f1c7@igalia.com>

Hi André,

I have a few comments below. I'm not sure what the plan is for 32-bit
robust lists, and I think there are a few problems with the assembly.

On Fri, Aug 21, 2026 at 06:50:43PM -0300, André Almeida wrote:
> The futex's robust list uAPI has a struct robust_list_head::list_op_pending
> pointer used by userspace as a temporary variable while the mutex unlock is
> happening. User sets it to the futex address that's about to be released
> and removed from the robust list, and list_op_pending is cleared after.
> After a thread dies, the kernel checks it's list_op_pending and wakes the
> mutex in that address, to prevent starvation, and flip a bit in the mutex
> word (FUTEX_OWNER_DIED).
> 
> However, there's a critical section where the user thread dies after the
> mutex is released but before list_op_pending is cleared. If that happens,
> another thread can wake up, use the lock, release it, and free its
> memory. Now, if the robust list cleanup happens after this, the
> killed thread's list_op_pending becomes a dandling pointer. The
> kernel wrongly treats this address as a mutex, calls a futex_wake()
> on it and flips a bit, causing a memory corruption.
> 
> To avoid using the dangling pointer, implement
> __vdso_futex_robust_try_unlock() for arm64. Make the VDSO release the mutex
> and clear the list_op_pending fields, just as is done in userspace right
> now. But having it in a VDSO means that, in the case of a killed user
> thread, the kernel can know exactly in which part of the release process
> the thread was interrupt, check the registers for the operation success and
> clears the list_op_pending on behalf of the user thread to prevent the
> use-after-free bug.
> 
> The need for checking the instructions addresses and the register makes
> this mechanism arch-dependent. Implement it using LL/SC semantics. If the
> user instruction pointer is between the labels
> __futex_list64_try_unlock_cs_start and __futex_list64_try_unlock_cs_end,
> the critical section was interrupted. The kernel checks for the result
> register (always w3) of the stlxr instruction used for atomically releasing
> the mutex. If it's 0, the release happened and the kernel should clear the
> list_op_pending field (always stored at x2).
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> v7:
>  - Typo in message: success result for stlex is 0, not 1
>  - pop_reg is read afterwards so define it as an output parameter "+Q"
> 
> v6:
>  - Complete reword of commit message to make it clear
>  - Better commit split, only the specific aarch64 things here
>  - Use explicity labels instead of macros
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
>  arch/arm64/Kconfig                |  1 +
>  arch/arm64/kernel/vdso.c          | 17 +++++++++++++++--
>  arch/arm64/kernel/vdso/Makefile   | 10 ++++++++++
>  arch/arm64/kernel/vdso/vdso.lds.S |  9 +++++++++
>  arch/arm64/kernel/vdso/vfutex.c   | 35 +++++++++++++++++++++++++++++++++++
>  5 files changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a269f73b7653..55932c0cd109 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -222,6 +222,7 @@ config ARM64
>  	select HAVE_RELIABLE_STACKTRACE
>  	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
>  	select HAVE_FUNCTION_ARG_ACCESS_API
> +	select HAVE_FUTEX_ROBUST_UNLOCK
>  	select MMU_GATHER_RCU_TABLE_FREE
>  	select HAVE_RSEQ
>  	select HAVE_RUST if RUSTC_SUPPORTS_ARM64
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 3ef331b5b240..dc6b582736d0 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -69,16 +69,27 @@ static inline void __vdso_futex_update_ips(struct mm_struct *mm, bool is_32bit,
>  	futex_set_vdso_cs_range(fd, is_32bit ? 1 : 0, start, end, is_32bit);
>  }
>  
> +static inline void vdso_futex_update_ips(struct mm_struct *mm)
> +{
> +	unsigned long vdso = (unsigned long) mm->context.vdso;

Nit: no space for the cast, please.

> +
> +	__vdso_futex_update_ips(mm, false,
> +				VDSO_SYMBOL(vdso, futex_list64_try_unlock_cs_start),
> +				VDSO_SYMBOL(vdso, futex_list64_try_unlock_cs_end));
> +}
> +
>  #else
> -static inline void __vdso_futex_update_ips(struct mm_struct *mm, bool is_32bit, void *startp,
> -					   void *endp)
> +static inline void vdso_futex_update_ips(struct mm_struct *mm) {}
>  #endif /* CONFIG_FUTEX_ROBUST_UNLOCK */
>  
> +
>  static int vdso_mremap(const struct vm_special_mapping *sm,
>  		struct vm_area_struct *new_vma)
>  {
>  	current->mm->context.vdso = (void *)new_vma->vm_start;
>  
> +	vdso_futex_update_ips(current->mm);
> +
>  	return 0;
>  }
>  
> @@ -366,5 +377,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  	ret = __setup_additional_pages(VDSO_ABI_AA64, mm, bprm, uses_interp);
>  	mmap_write_unlock(mm);
>  
> +	vdso_futex_update_ips(mm);
> +
>  	return ret;
>  }
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
> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
> index 52314be29191..225f59bb81d1 100644
> --- a/arch/arm64/kernel/vdso/vdso.lds.S
 +++ b/arch/arm64/kernel/vdso/vdso.lds.S
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

I was under the impression that you wanted to be able to use a 32-bit
list on arm64 for emulated 32-bit code. Am I mistaken, or missing
something? On arm64, you won't be able to call the 32-bit VDSO as you
could on x86-64.

> diff --git a/arch/arm64/kernel/vdso/vfutex.c b/arch/arm64/kernel/vdso/vfutex.c
> new file mode 100644
> index 000000000000..ae7b653c1554
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso/vfutex.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/stringify.h>
> +#include <vdso/futex.h>
> +
> +__u32 __vdso_futex_robust_list64_try_unlock(__u32 *lock, __u32 tid, __u64 *pop)
> +{

It would be good to have a comment here saying that
arm64_futex_robust_unlock_get_pop() depends on these register
allocations.

> +	register __u64 *pop_reg asm("x2") = pop;
> +	register __u32 result_reg asm("w3") = 0;
> +	__u32 val;
> +
> +	asm volatile (
> +		".globl						  "
> +		"__futex_list64_try_unlock_cs_start,		  "
> +		"__futex_list64_try_unlock_cs_success,		  "
> +		"__futex_list64_try_unlock_cs_end		\n"

Sorry, when I mentioned putting these within the assembly, I meant doing
something like:

| #define LABEL(l)						\
| 	"	.globl " #l "\n"				\
| 	#l ":\n"

... and within the asssembly, having:

| 	"	insn1					\n"
| 	"	insn2					\n"
| 	LABEL(__futex_list64_try_unlock_cs_start)
| 	"	insn2					\n"
| 	LABEL(__futex_list64_try_unlock_cs_start)
| 	"	insn4					\n"
| 	LABEL(__futex_list64_try_unlock_cs_success)
| 	"	insn5					\n"

That way we use the full strings, which are easy to grep for, and we
only have to define each label string once.

> +
> +		"	prfm pstl1strm, %[lock]			\n"
> +		"retry:						\n"
> +		"	ldxr %w[val], %[lock]			\n"
> +		"	cmp %w[tid], %w[val]			\n"
> +		"	bne __futex_list64_try_unlock_cs_end	\n"

The 'bne' here should be 'b.ne'. IIUC assemblers accept the former by
historical accident, and 'b.<cond>' is the architecturally defined
mnemonic.

As general thing, we format assembly with a tab between the instruction
and first operand, so the above should be:

| 	"	prfm	pstl1strm, %[lock]			\n"
| 	"retry:							\n"
| 	"	ldxr	%w[val], %[lock]			\n"
| 	"	cmp	%w[tid], %w[val]			\n"
| 	"	b.ne	__futex_list64_try_unlock_cs_end	\n"

> +		"	stlxr %w[result], wzr, %[lock]		\n"
> +		"__futex_list64_try_unlock_cs_start:		\n"
> +		"	cbnz %w[result], retry			\n"
> +		"__futex_list64_try_unlock_cs_success:		\n"
> +		"	str xzr, %[pop_reg]			\n"
> +		"__futex_list64_try_unlock_cs_end:		\n"
> +
> +		: [val] "=&r" (val), [result] "=&r" (result_reg), [pop_reg] "+Q" (*pop_reg)
> +		: [tid] "r" (tid), [lock] "Q" (*lock)
> +		: "cc", "memory"
> +	);

As a general note, for assembly constaints, please put each constraint
on its own line, e.g.

	: [val] "=&r" (val),
	  [result] "=&r" (result_reg),
	  [pop_reg] "+Q" (*pop_reg)
	: [tid] "r" (tid),
	  [lock] "Q" (*lock)
	: "cc", "memory"

That formatting makes it much easier to read each constraint
individually, and it makes it easier to review changes to individual
constaints.

Generally, for asm we have a preferred style:

	asm volatile(
	"	// string starts aligned with 'asm'	\n"
	"	// with 1 tab indend within that.	\n"
	"						\n"
	"	insn	operand1, operand2		\n"
	"label:						\n"
	"	insn	operand1, operand2		\n"
	: [output1] "=r" (...),
	  [output2] "=r" (...)
	: [input1] "r" (...).
	  [input2] "r" (...)
	: "clobbers"
	);

I see a couple of problems with the constraints as-is.

Firstly, the constraints for [pop_reg] doesn't guarantee that x2 is
used. The "+Q" constraint takes a memory operand (in this case the
location pointed to by 'pop_reg', and limits the addressing mode to a
single base register with no offset. The operand is the memroy location,
not the register holding the memory location, so this constraint won't
necessarily use x2. Unless 'pop_reg' itself is passed into a register
constraint, the compiler might not ensure that 'x2' is populated.

For example:

| [mark@gravadlaks:~/tests/asm-operands-q-reg]% cat test.c
| unsigned long foo(unsigned long *ptr)
| {
|         register unsigned long *ptr_reg asm("x2") = ptr;
|         unsigned long val;
| 
|         asm volatile(
|         "       ldr     %[val], %[qptr]\n"
|         : [val] "=&r" (val)
|         : [qptr] "Q" (*ptr_reg)
|         );
| 
|         return val;
| }
| [mark@gravadlaks:~/tests/asm-operands-q-reg]% usekorg 16.2.0 aarch64-linux-gcc -c test.c -O2
| [mark@gravadlaks:~/tests/asm-operands-q-reg]% usekorg 16.2.0 aarch64-linux-objdump -d test.o
| 
| test.o:     file format elf64-littleaarch64
| 
| 
| Disassembly of section .text:
| 
| 0000000000000000 <foo>:
|    0:   f9400001        ldr     x1, [x0]
|    4:   aa0103e0        mov     x0, x1
|    8:   d65f03c0        ret

We will need an "r" input constraint for 'pop_reg' to ensure that x2 is
allocated. Either in addition to an "=Q" output constraint for the
actual memory write, or we rely on the memory clobber to hazaard against
other memory accesses.

Secondly, the "Q" input constaint for 'lock' looks inaccurate, given
that we both read and write to 'lock'. Either that should be a "+Q"
output constraint, or we rely on the memory clobber to hazard against
other memory accesses.

Mark.

> +
> +	return val;
> +}
> 
> -- 
> 2.55.0
> 
