From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] arm64: fix current_thread_info()->addr_limit setup
Date: Thu, 12 May 2016 18:22:03 +0100
Message-ID: <20160512172203.GL11226@e104818-lin.cambridge.arm.com>
References: <1463069163-374-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60261 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402AbcELRWI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 May 2016 13:22:08 -0400
Content-Disposition: inline
In-Reply-To: <1463069163-374-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, May 12, 2016 at 07:06:03PM +0300, Yury Norov wrote:
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index 24ed037..fda75ce 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -138,7 +138,10 @@ typedef struct user_fpsimd_state elf_fpregset_t;
>   */
>  #define ELF_PLAT_INIT(_r, load_addr)	(_r)->regs[0] = 0
>  
> -#define SET_PERSONALITY(ex)		clear_thread_flag(TIF_32BIT);
> +#define SET_PERSONALITY(ex) do {					\
> +	clear_thread_flag(TIF_32BIT);					\
> +	set_fs(TASK_SIZE_64);						\
> +} while (0)
>  
>  #define ARCH_DLINFO							\
>  do {									\
> @@ -181,7 +184,11 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
>  					 ((x)->e_flags & EF_ARM_EABI_MASK))
>  
>  #define compat_start_thread		compat_start_thread
> -#define COMPAT_SET_PERSONALITY(ex)	set_thread_flag(TIF_32BIT);
> +#define COMPAT_SET_PERSONALITY(ex) do {					\
> +	set_thread_flag(TIF_32BIT);					\
> +	set_fs(TASK_SIZE_32);						\
> +} while (0)
> +
>  #define COMPAT_ARCH_DLINFO
>  extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
>  				      int uses_interp);
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 0685d74..5b269e6 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -60,7 +60,7 @@ extern int fixup_exception(struct pt_regs *regs);
>  #define KERNEL_DS	(-1UL)
>  #define get_ds()	(KERNEL_DS)
>  
> -#define USER_DS		TASK_SIZE_64
> +#define USER_DS		TASK_SIZE

We can avoid the USER_DS change as long as SET_PERSONALITY updates the
thread's addr_limit. There are very few explicit set_fs(USER_DS) calls
and they are on the thread exit path (or exec).

That's unless we try to make a generic set_fs(USER_DS) addition to
something like setup_new_exec() and we wouldn't need the SET_PERSONALITY
changes:

diff --git a/fs/exec.c b/fs/exec.c
index c4010b8207a1..54cc537f5986 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1226,6 +1226,9 @@ EXPORT_SYMBOL(would_dump);
 
 void setup_new_exec(struct linux_binprm * bprm)
 {
+	/* set the address limit for the new executable */
+	set_fs(USER_DS);
+
 	arch_pick_mmap_layout(current->mm);
 
 	/* This is the point of no return */

>  #define get_fs()	(current_thread_info()->addr_limit)
>  
>  static inline void set_fs(mm_segment_t fs)
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 8062482..2b25930 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -211,17 +211,13 @@ static void tls_thread_flush(void)
>  {
>  	asm ("msr tpidr_el0, xzr");
>  
> -	if (is_compat_task()) {
> -		current->thread.tp_value = 0;
> -
> -		/*
> -		 * We need to ensure ordering between the shadow state and the
> -		 * hardware state, so that we don't corrupt the hardware state
> -		 * with a stale shadow state during context switch.
> -		 */
> -		barrier();
> -		asm ("msr tpidrro_el0, xzr");
> -	}
> +	/*
> +	 * We need to ensure ordering between the shadow state and the
> +	 * hardware state, so that we don't corrupt the hardware state
> +	 * with a stale shadow state during context switch.
> +	 */
> +	barrier();
> +	asm ("msr tpidrro_el0, xzr");
>  }

Why did you dropped tp_value initialisation? Context switching on native
64-bit tasks rely on copying the tpidr_el0 in and out of tp_value.
However, compat tasks use the read-only tpidrro_el0 register set
explicitly via a system call. Until this call happens, the TLS register
would contain some garbage after the thread has been switched back in.

-- 
Catalin
