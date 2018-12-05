From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: split compat syscall table out from native table
Date: Wed, 05 Dec 2018 23:24:16 +1100
Message-ID: <87pnugkvpr.fsf@concordia.ellerman.id.au>
References: <CAK8P3a2SP0eX50NoFKaM2N85mgSejToQkD9ZOE_7V_RT__BCvg@mail.gmail.com> <20181204212340.3915309-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204212340.3915309-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: firoz.khan@linaro.org
Cc: y2038@lists.linaro.org, linux-arch@vger.kernel.org, deepa.kernel@gmail.com, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> PowerPC uses a syscall table with native and compat calls interleaved,
> which is a slightly simpler way to define two matching tables.
>
> As we move to having the tables generated, that advantage is no longer
> important, but the interleaved table gets in the way of using the
> same scripts as on the other architectures.
>
> Split out a new compat_sys_call_table symbol that contains all the
> compat calls, and leave the main table for the native calls, to more
> closely match the method we use everywhere else.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This is completely untested, it's just for illustration and to
> get comments about whether this is a good idea.

Seems like a good idea to me.

The code's not much more complicated, in fact it's probably clearer
except for the extra macros.

It's more cache efficient too, though it probably doesn't really matter.

cheers

> Firoz, can you try to get this working?
> ---
>  arch/powerpc/include/asm/syscall.h |  3 +--
>  arch/powerpc/kernel/entry_64.S     |  7 ++++--
>  arch/powerpc/kernel/systbl.S       | 37 ++++++++++++++++++++++++------
>  arch/powerpc/kernel/vdso.c         |  7 ++++--
>  4 files changed, 41 insertions(+), 13 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index ab9f3f0a8637..1a0e7a8b1c81 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -18,9 +18,8 @@
>  #include <linux/thread_info.h>
>  
>  /* ftrace syscalls requires exporting the sys_call_table */
> -#ifdef CONFIG_FTRACE_SYSCALLS
>  extern const unsigned long sys_call_table[];
> -#endif /* CONFIG_FTRACE_SYSCALLS */
> +extern const unsigned long compat_sys_call_table[];
>  
>  static inline int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
>  {
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 7b1693adff2a..5574d92646f1 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -54,6 +54,9 @@
>  SYS_CALL_TABLE:
>  	.tc sys_call_table[TC],sys_call_table
>  
> +COMPAT_SYS_CALL_TABLE:
> +	.tc compat_sys_call_table[TC],compat_sys_call_table
> +
>  /* This value is used to mark exception frames on the stack. */
>  exception_marker:
>  	.tc	ID_EXC_MARKER[TC],STACK_FRAME_REGS_MARKER
> @@ -173,7 +176,7 @@ system_call:			/* label this so stack traces look sane */
>  	ld	r11,SYS_CALL_TABLE@toc(2)
>  	andis.	r10,r10,_TIF_32BIT@h
>  	beq	15f
> -	addi	r11,r11,8	/* use 32-bit syscall entries */
> +	ld	r11,COMPAT_SYS_CALL_TABLE@toc(2)
>  	clrldi	r3,r3,32
>  	clrldi	r4,r4,32
>  	clrldi	r5,r5,32
> @@ -181,7 +184,7 @@ system_call:			/* label this so stack traces look sane */
>  	clrldi	r7,r7,32
>  	clrldi	r8,r8,32
>  15:
> -	slwi	r0,r0,4
> +	slwi	r0,r0,3
>  
>  	barrier_nospec_asm
>  	/*
> diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
> index 919a32746ede..883b8e36964c 100644
> --- a/arch/powerpc/kernel/systbl.S
> +++ b/arch/powerpc/kernel/systbl.S
> @@ -17,13 +17,13 @@
>  #include <asm/ppc_asm.h>
>  
>  #ifdef CONFIG_PPC64
> -#define SYSCALL(func)		.8byte	DOTSYM(sys_##func),DOTSYM(sys_##func)
> -#define COMPAT_SYS(func)	.8byte	DOTSYM(sys_##func),DOTSYM(compat_sys_##func)
> -#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func),DOTSYM(ppc_##func)
> -#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall),DOTSYM(sys_ni_syscall)
> -#define SYS32ONLY(func)		.8byte	DOTSYM(sys_ni_syscall),DOTSYM(compat_sys_##func)
> -#define PPC64ONLY(func)		.8byte	DOTSYM(ppc_##func),DOTSYM(sys_ni_syscall)
> -#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f),DOTSYM(f3264)
> +#define SYSCALL(func)		.8byte	DOTSYM(sys_##func)
> +#define COMPAT_SYS(func)	.8byte	DOTSYM(sys_##func)
> +#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func)
> +#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall)
> +#define SYS32ONLY(func)		.8byte	DOTSYM(sys_ni_syscall)
> +#define PPC64ONLY(func)		.8byte	DOTSYM(ppc_##func)
> +#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f)
>  #else
>  #define SYSCALL(func)		.long	sys_##func
>  #define COMPAT_SYS(func)	.long	sys_##func
> @@ -48,3 +48,26 @@
>  sys_call_table:
>  
>  #include <asm/systbl.h>
> +
> +#undef SYSCALL
> +#undef COMPAT_SYS
> +#undef PPC_SYS
> +#undef OLDSYS
> +#undef SYS32ONLY
> +#undef PPC64ONLY
> +#undef SYSX
> +
> +#ifdef CONFIG_COMPAT
> +#define SYSCALL(func)		.8byte	DOTSYM(sys_##func)
> +#define COMPAT_SYS(func)	.8byte	DOTSYM(compat_sys_##func)
> +#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func)
> +#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall)
> +#define SYS32ONLY(func)		.8byte	DOTSYM(compat_sys_##func)
> +#define PPC64ONLY(func)		.8byte	DOTSYM(sys_ni_syscall)
> +#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f3264)
> +
> +.globl compat_sys_call_table
> +compat_sys_call_table:
> +
> +#include <asm/systbl.h>
> +#endif
> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
> index 65b3bdb99f0b..7725a9714736 100644
> --- a/arch/powerpc/kernel/vdso.c
> +++ b/arch/powerpc/kernel/vdso.c
> @@ -671,15 +671,18 @@ static void __init vdso_setup_syscall_map(void)
>  {
>  	unsigned int i;
>  	extern unsigned long *sys_call_table;
> +#ifdef CONFIG_PPC64
> +	extern unsigned long *compat_sys_call_table;
> +#endif
>  	extern unsigned long sys_ni_syscall;
>  
>  
>  	for (i = 0; i < NR_syscalls; i++) {
>  #ifdef CONFIG_PPC64
> -		if (sys_call_table[i*2] != sys_ni_syscall)
> +		if (sys_call_table[i] != sys_ni_syscall)
>  			vdso_data->syscall_map_64[i >> 5] |=
>  				0x80000000UL >> (i & 0x1f);
> -		if (sys_call_table[i*2+1] != sys_ni_syscall)
> +		if (compat_sys_call_table[i] != sys_ni_syscall)
>  			vdso_data->syscall_map_32[i >> 5] |=
>  				0x80000000UL >> (i & 0x1f);
>  #else /* CONFIG_PPC64 */
> -- 
> 2.18.0
