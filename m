Return-Path: <SRS0=WXCa=4P=vger.kernel.org=linux-doc-owner@kernel.org>
Subject: Re: [RFC PATCH v9 17/27] x86/cet/shstk: User-mode Shadow Stack
 support
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-18-yu-cheng.yu@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <9847845a-749d-47a3-2a1d-bcc7c35f1bdd@intel.com>
Date: Wed, 26 Feb 2020 16:55:56 -0800
MIME-Version: 1.0
In-Reply-To: <20200205181935.3712-18-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-doc-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200227005556.M6JfyS7A-waEEbweWZe5rQ672PzLHZM98hYQod4AXF0@z>

On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> This patch adds basic Shadow Stack (SHSTK) enabling/disabling routines.
> A task's SHSTK is allocated from memory with VM_SHSTK flag and read-only
> protection.  It has a fixed size of RLIMIT_STACK.
> 
> v9:
> - Change cpu_feature_enabled() to static_cpu_has().
> - Merge cet_disable_shstk to cet_disable_free_shstk.
> - Remove the empty slot at the top of the SHSTK, as it is not needed.
> - Move do_mmap_locked() to alloc_shstk(), which is a static function.
> 
> v6:
> - Create a function do_mmap_locked() for SHSTK allocation.
> 
> v2:
> - Change noshstk to no_cet_shstk.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/cet.h                    |  31 +++++
>  arch/x86/include/asm/disabled-features.h      |   8 +-
>  arch/x86/include/asm/processor.h              |   5 +
>  arch/x86/kernel/Makefile                      |   2 +
>  arch/x86/kernel/cet.c                         | 121 ++++++++++++++++++
>  arch/x86/kernel/cpu/common.c                  |  25 ++++
>  arch/x86/kernel/process.c                     |   1 +
>  .../arch/x86/include/asm/disabled-features.h  |   8 +-
>  8 files changed, 199 insertions(+), 2 deletions(-)
>  create mode 100644 arch/x86/include/asm/cet.h
>  create mode 100644 arch/x86/kernel/cet.c
> 
> diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
> new file mode 100644
> index 000000000000..c44c991ca91f
> --- /dev/null
> +++ b/arch/x86/include/asm/cet.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_CET_H
> +#define _ASM_X86_CET_H
> +
> +#ifndef __ASSEMBLY__
> +#include <linux/types.h>
> +
> +struct task_struct;
> +/*
> + * Per-thread CET status
> + */
> +struct cet_status {
> +	unsigned long	shstk_base;
> +	unsigned long	shstk_size;
> +	unsigned int	shstk_enabled:1;
> +};

Just out of curiosity, what's the theoretical size limit of shadow
stacks?  Is there one?

Also, not to nitpick too much, but you could pretty easily save the
storage of shstk_enabled by using 0 for the size.

> +#ifdef CONFIG_X86_INTEL_CET
> +int cet_setup_shstk(void);
> +void cet_disable_free_shstk(struct task_struct *p);
> +#else
> +static inline void cet_disable_free_shstk(struct task_struct *p) {}
> +#endif
> +
> +#define cpu_x86_cet_enabled() \
> +	(static_cpu_has(X86_FEATURE_SHSTK) || \
> +	 static_cpu_has(X86_FEATURE_IBT))
> +
> +#endif /* __ASSEMBLY__ */

You don't need the #ifdef if you stick the X86_FEATUREs in
disabled-features.h properly.

> diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
> new file mode 100644
> index 000000000000..b4c7d88e9a8f
> --- /dev/null
> +++ b/arch/x86/kernel/cet.c
> @@ -0,0 +1,121 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * cet.c - Control-flow Enforcement (CET)
> + *
> + * Copyright (c) 2019, Intel Corporation.
> + * Yu-cheng Yu <yu-cheng.yu@intel.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/mm.h>
> +#include <linux/mman.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/sched/signal.h>
> +#include <linux/compat.h>
> +#include <asm/msr.h>
> +#include <asm/user.h>
> +#include <asm/fpu/internal.h>
> +#include <asm/fpu/xstate.h>
> +#include <asm/fpu/types.h>
> +#include <asm/cet.h>
> +
> +static void start_update_msrs(void)
> +{
> +	fpregs_lock();
> +	if (test_thread_flag(TIF_NEED_FPU_LOAD))
> +		__fpregs_load_activate();
> +}
> +
> +static void end_update_msrs(void)
> +{
> +	fpregs_unlock();
> +}
> +
> +static unsigned long cet_get_shstk_addr(void)
> +{
> +	struct fpu *fpu = &current->thread.fpu;
> +	unsigned long ssp = 0;
> +
> +	fpregs_lock();
> +
> +	if (fpregs_state_valid(fpu, smp_processor_id())) {
> +		rdmsrl(MSR_IA32_PL3_SSP, ssp);
> +	} else {
> +		struct cet_user_state *p;
> +
> +		p = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
> +		if (p)
> +			ssp = p->user_ssp;
> +	}
> +
> +	fpregs_unlock();
> +	return ssp;
> +}
> +
> +static unsigned long alloc_shstk(unsigned long size)
> +{
> +	struct mm_struct *mm = current->mm;
> +	unsigned long addr, populate;
> +
> +	down_write(&mm->mmap_sem);
> +	addr = do_mmap(NULL, 0, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE,
> +		       VM_SHSTK, 0, &populate, NULL);
> +	up_write(&mm->mmap_sem);
> +
> +	if (populate)
> +		mm_populate(addr, populate);
> +
> +	return addr;
> +}
> +
> +int cet_setup_shstk(void)
> +{
> +	unsigned long addr, size;
> +	struct cet_status *cet = &current->thread.cet;
> +
> +	if (!static_cpu_has(X86_FEATURE_SHSTK))
> +		return -EOPNOTSUPP;
> +
> +	size = rlimit(RLIMIT_STACK);

This doesn't seem right.  In general, I thought you could have disabled
rlimits, which would mean a size of -1:
	
	#define RLIM64_INFINITY         (~0ULL)

Or is there something special about stacks that I'm missing?

Also, does size need to be page aligned?

> +	addr = alloc_shstk(size);
> +
> +	if (IS_ERR((void *)addr))
> +		return PTR_ERR((void *)addr);
> +
> +	cet->shstk_base = addr;
> +	cet->shstk_size = size;
> +	cet->shstk_enabled = 1;
> +
> +	start_update_msrs();
> +	wrmsrl(MSR_IA32_PL3_SSP, addr + size);
> +	wrmsrl(MSR_IA32_U_CET, MSR_IA32_CET_SHSTK_EN);

Doesn't MSR_IA32_U_CET have lots of bits?  Won't this blow away other bits?

> +	end_update_msrs();
> +	return 0;
> +}
> +
> +void cet_disable_free_shstk(struct task_struct *tsk)
> +{
> +	struct cet_status *cet = &tsk->thread.cet;
> +
> +	if (!static_cpu_has(X86_FEATURE_SHSTK) ||
> +	    !cet->shstk_enabled || !cet->shstk_base)
> +		return;

This seems to indicate that you can have ->shstk_base set without it
being enabled.  But I don't see any spots in the code that do that.
Confused.

> +	if (!tsk->mm || (tsk->mm != current->mm))
> +		return;
> +
> +	if (tsk == current) {
> +		u64 msr_val;
> +
> +		start_update_msrs();
> +		rdmsrl(MSR_IA32_U_CET, msr_val);
> +		wrmsrl(MSR_IA32_U_CET, msr_val & ~MSR_IA32_CET_SHSTK_EN);
> +		end_update_msrs();
> +	}
> +
> +	vm_munmap(cet->shstk_base, cet->shstk_size);

What about vm_munmap() failure?
