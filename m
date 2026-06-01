Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A03B3ACF0E
	for <linux-arch@vger.kernel.org>; Mon,  1 Jun 2026 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321624; cv=none; b=iTVGNDfsPefjhwbykAd/Y2H2acT5IZ+6OgdPTSjJlARoIc9ZEutHgNTw5IsFSEheXmMQ/2bdlMFM2XJlWvVdZ9yGNS8Nb2fMAbMqrcjoFokpqVGxrZuBmSd55GU6dWby/uqL1lCHEN1qE1NhQSr86fay7U7egCWTDwg3rid/ZHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321624; c=relaxed/simple;
	bh=sNxKoCHtaQHjooWXE5msYQ8XpPeBdUokNP4VpfDNJCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2I8CW7Ojo3zXs44rVs0H8zbDw8fwu+544Dd/CamuE0Y7rMyh1TwPLXpoRofz6NgiUw3SlVtquvfdKpP4qhP3PrRScWMxEZmdSs2kmgC5LbyY4iazHy0un1xTHLq9Y7knjCaS8sC31Gu1+eIOh/Ula7/8ku9MWbBoRIwogBmvME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e386a6yo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e386a6yo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46411F0089B
	for <linux-arch@vger.kernel.org>; Mon,  1 Jun 2026 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780321621;
	bh=A45zwgLDvye6TEegvl1U4QSxvenm+a7HwzCRUpJ1vug=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=e386a6yo6rXnY2N0CMclUYFSOPrN9T2e9FpcVzJ6X3fpvNGsr9G7AWNgWJQaWXUbz
	 cjpfkV00DgP6zK0vPX57MXQ1eaNVAIQebT2vtegKx33L71BMcUdIY7hMORAdSgeCnv
	 kXNTKnyMtLYlVi+XYWjoOPoYSX8v6RJROcCy457LlVynfceOoyQRbgxOQGE68rqxfH
	 Cq9F14yp4OkWmlW06mObud6qCxTXi4AY6aGzJ2wYj9INlb0u1uULP8X3KgVS/KnK9S
	 aSBk26Vy4dxjHOggyogmNOvutz7CGhOLxZxf4SWGbkWoSEhOr8PPM7C5uL92ywS4FM
	 9gryrk1D+wGJw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bec3ffb95dbso200180966b.0
        for <linux-arch@vger.kernel.org>; Mon, 01 Jun 2026 06:47:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+PvxPeZrJyQjBsZn5U8u4NRYDStJQLf68+iK94fY6Cet6EsWfzdJzrlEWyorlbzAUNtZFmN9WJhZwd@vger.kernel.org
X-Gm-Message-State: AOJu0YxPKrLR71bm/Q8oJTzaYHJX48CIZ9T8FTksNbgEguUV4XJfsSOA
	gYnYW1/HQ35CaTKdIUKZ08iyxVTgIf0yboKAybAhJAQdnQZixxK79aTDMl5pHFhMC0H8czcMmum
	znDkAtTRg/tP+XxW3Nwk0+ccYxTakcbc=
X-Received: by 2002:a17:907:e143:b0:beb:7b50:3a7b with SMTP id
 a640c23a62f3a-beb7b505c83mr250887766b.6.1780321620095; Mon, 01 Jun 2026
 06:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428072021.7289-1-yangtiezhu@loongson.cn> <20260428072021.7289-2-yangtiezhu@loongson.cn>
In-Reply-To: <20260428072021.7289-2-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 1 Jun 2026 21:46:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5tLpXtnMJOx=b5MCDY71jMNkQ5pv1YhgCf72FV=ewcxg@mail.gmail.com>
X-Gm-Features: AVHnY4KVpcGmTAOt7WrIRLWPhtbWdlDJc7dmEVNTSn_uZS12VezuLxly93RKS5s
Message-ID: <CAAhV-H5tLpXtnMJOx=b5MCDY71jMNkQ5pv1YhgCf72FV=ewcxg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu,

On Tue, Apr 28, 2026 at 3:20=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Like other architectures such as x86, arm64, riscv, powerpc and s390,
> select THREAD_INFO_IN_TASK for LoongArch to move thread_info off the
> stack into task_struct. This follows modern kernel standards and also
> makes the system more secure.
>
> With this patch, thread_info is included in task_struct at an offset
> of 0 instead of being placed at the bottom of the kernel stack. Thus,
> the $tp register points to both thread_info and task_struct.
>
> To support this, introduce a per-CPU variable __entry_task to store
> the pointer to the current task_struct. This decouples the recovery
> of the $tp register from the stack pointer during exception entry.
> Relying on SP for task identification is insecure since the SP can be
> controlled or corrupted by userspace.
>
> Then initialize __entry_task for both the primary and secondary CPUs
> during arch-specific setup and SMP boot paths, modify SAVE_SOME and
> handle_syscall to restore the $tp register from __entry_task, and use
> la_abs absolute addressing for __entry_task access in assembly to
> bypass relocation limits within exception handling sections. Also,
> add entry_task_switch() to update __entry_task during switch_to().
>
> Additionally, add reg02 ($tp) to thread_struct and initialize it in
> both INIT_THREAD and copy_thread() to ensure that the "current" task
> pointer is correctly set up for the initial idle task and all future
> child processes. While __switch_to() directly updates $tp from a1 for
> efficiency, storing it in thread_struct ensures correct restoration
> for new processes and in non-standard switch paths.
>
> Furthermore, initialize reg03 ($sp) in INIT_THREAD to set the initial
> kernel stack pointer for the idle task. This ensures the idle task has
> a valid stack to use when the system first starts or whenever it is
> switched back to.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/Kconfig                   |  1 +
>  arch/loongarch/include/asm/current.h     | 22 ++++++++++++
>  arch/loongarch/include/asm/processor.h   | 44 +++---------------------
>  arch/loongarch/include/asm/ptrace.h      |  6 ----
>  arch/loongarch/include/asm/smp.h         |  3 +-
>  arch/loongarch/include/asm/stackframe.h  |  9 +++--
>  arch/loongarch/include/asm/switch_to.h   | 15 ++++++--
>  arch/loongarch/include/asm/thread_info.h | 13 +------
>  arch/loongarch/kernel/asm-offsets.c      |  7 ++--
>  arch/loongarch/kernel/entry.S            |  7 ++--
>  arch/loongarch/kernel/head.S             | 18 ++++++----
>  arch/loongarch/kernel/process.c          |  6 ++++
>  arch/loongarch/kernel/relocate.c         |  2 +-
>  arch/loongarch/kernel/setup.c            |  3 ++
>  arch/loongarch/kernel/smp.c              |  8 +++--
>  arch/loongarch/kernel/switch.S           |  9 ++---
>  16 files changed, 89 insertions(+), 84 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/current.h
First of all, you should update
Documentation/features/core/thread-info-in-task/arch-support.txt
together.

>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 3b042dbb2c41..ea29d5d17588 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -210,6 +210,7 @@ config LOONGARCH
>         select SYSCTL_ARCH_UNALIGN_NO_WARN
>         select SYSCTL_EXCEPTION_TRACE
>         select SWIOTLB if 64BIT
> +       select THREAD_INFO_IN_TASK
>         select TRACE_IRQFLAGS_SUPPORT
>         select USE_PERCPU_NUMA_NODE_ID
>         select USER_STACKTRACE_SUPPORT
> diff --git a/arch/loongarch/include/asm/current.h b/arch/loongarch/includ=
e/asm/current.h
> new file mode 100644
> index 000000000000..c03cf0abb863
> --- /dev/null
> +++ b/arch/loongarch/include/asm/current.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_LOONGARCH_CURRENT_H
> +#define __ASM_LOONGARCH_CURRENT_H
> +
> +#include <linux/compiler.h>
> +
> +#ifndef __ASSEMBLER__
> +
> +struct task_struct;
> +
> +register struct task_struct *current_thread_pointer __asm__("$tp");
> +
> +static __always_inline struct task_struct *get_current(void)
> +{
> +       return current_thread_pointer;
> +}
> +
> +#define current get_current()
> +
> +#endif /* __ASSEMBLER__ */
> +
> +#endif /* __ASM_LOONGARCH_CURRENT_H */
> diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/incl=
ude/asm/processor.h
> index ce8b953f8c79..df927a4318cc 100644
> --- a/arch/loongarch/include/asm/processor.h
> +++ b/arch/loongarch/include/asm/processor.h
> @@ -109,7 +109,7 @@ struct loongarch_vdso_info;
>   */
>  struct thread_struct {
>         /* Main processor registers. */
> -       unsigned long reg01, reg03, reg22; /* ra sp fp */
> +       unsigned long reg01, reg02, reg03, reg22; /* ra tp sp fp */
>         unsigned long reg23, reg24, reg25, reg26; /* s0-s3 */
>         unsigned long reg27, reg28, reg29, reg30, reg31; /* s4-s8 */
>
> @@ -145,45 +145,9 @@ struct thread_struct {
>  #define thread_saved_ra(tsk)   (tsk->thread.sched_ra)
>  #define thread_saved_fp(tsk)   (tsk->thread.sched_cfa)
>
> -#define INIT_THREAD  {                                         \
> -       /*                                                      \
> -        * Main processor registers                             \
> -        */                                                     \
> -       .reg01                  =3D 0,                            \
> -       .reg03                  =3D 0,                            \
> -       .reg22                  =3D 0,                            \
> -       .reg23                  =3D 0,                            \
> -       .reg24                  =3D 0,                            \
> -       .reg25                  =3D 0,                            \
> -       .reg26                  =3D 0,                            \
> -       .reg27                  =3D 0,                            \
> -       .reg28                  =3D 0,                            \
> -       .reg29                  =3D 0,                            \
> -       .reg30                  =3D 0,                            \
> -       .reg31                  =3D 0,                            \
> -       .sched_ra               =3D 0,                            \
> -       .sched_cfa              =3D 0,                            \
> -       .csr_crmd               =3D 0,                            \
> -       .csr_prmd               =3D 0,                            \
> -       .csr_euen               =3D 0,                            \
> -       .csr_ecfg               =3D 0,                            \
> -       .csr_badvaddr           =3D 0,                            \
> -       /*                                                      \
> -        * Other stuff associated with the process              \
> -        */                                                     \
> -       .trap_nr                =3D 0,                            \
> -       .error_code             =3D 0,                            \
> -       /*                                                      \
> -        * FPU & vector registers                               \
> -        */                                                     \
> -       .fpu                    =3D {                             \
> -               .fcc            =3D 0,                            \
> -               .fcsr           =3D 0,                            \
> -               .ftop           =3D 0,                            \
> -               .fpr            =3D {{{0,},},},                   \
> -       },                                                      \
> -       .hbp_break              =3D {0},                          \
> -       .hbp_watch              =3D {0},                          \
> +#define INIT_THREAD  {                                                 \
> +       .reg02 =3D (unsigned long)&init_task,                            =
 \
> +       .reg03 =3D (unsigned long)&init_stack + sizeof(init_stack),      =
 \
>  }
Don't remove the old code, just adding reg02 is enough. Though the
result is the same, explicitly initialization can give more
information.

>
>  struct task_struct;
> diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include=
/asm/ptrace.h
> index e5d21e836d99..37f53629d3c7 100644
> --- a/arch/loongarch/include/asm/ptrace.h
> +++ b/arch/loongarch/include/asm/ptrace.h
> @@ -170,12 +170,6 @@ static inline void die_if_kernel(const char *str, st=
ruct pt_regs *regs)
>                 die(str, regs);
>  }
>
> -#define current_pt_regs()                                              \
> -({                                                                     \
> -       unsigned long sp =3D (unsigned long)__builtin_frame_address(0);  =
 \
> -       (struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1) - 1;           \
> -})
> -
This is still correct after CONFIG_THREAD_INFO_IN_TASK, so please keep
it. Especially CONFIG_THREAD_INFO_IN_TASK increases the cost of
exception/syscalls, keeping this can minimize the performance
impaction.

>  /* Helpers for working with the user stack pointer */
>
>  static inline unsigned long user_stack_pointer(struct pt_regs *regs)
> diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/as=
m/smp.h
> index 3a47f52959a8..761cc0016df8 100644
> --- a/arch/loongarch/include/asm/smp.h
> +++ b/arch/loongarch/include/asm/smp.h
> @@ -82,7 +82,8 @@ struct seq_file;
>
>  struct secondary_data {
>         unsigned long stack;
> -       unsigned long thread_info;
> +       unsigned long task;
> +       unsigned long offset;
>  };
>  extern struct secondary_data cpuboot_data;
>
> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/inc=
lude/asm/stackframe.h
> index ecc8e50fffa8..eeda5dcc982e 100644
> --- a/arch/loongarch/include/asm/stackframe.h
> +++ b/arch/loongarch/include/asm/stackframe.h
> @@ -191,8 +191,13 @@
>         andi    t0, t0, 0x3     /* extract pplv bit */
>         beqz    t0, 9f
>
> -       LONG_LI tp, ~_THREAD_MASK
> -       and     tp, tp, sp
> +       la_abs      t1, __entry_task
> +#ifdef CONFIG_SMP
> +       csrrd       t0, PERCPU_BASE_KS
> +       LONG_ADD    t1, t1, t0
> +#endif
> +       LONG_L      tp, t1, 0
> +
>         cfi_st  u0, PT_R21, \docfi
>         csrrd   u0, PERCPU_BASE_KS
Move these lines near to "cfi_st  fp, PT_R22, \docfi", then the above
"csrrd       t0, PERCPU_BASE_KS" can be removed.

>  9:
> diff --git a/arch/loongarch/include/asm/switch_to.h b/arch/loongarch/incl=
ude/asm/switch_to.h
> index 5b225aff3ba2..9932429cfe17 100644
> --- a/arch/loongarch/include/asm/switch_to.h
> +++ b/arch/loongarch/include/asm/switch_to.h
> @@ -5,17 +5,25 @@
>  #ifndef _ASM_SWITCH_TO_H
>  #define _ASM_SWITCH_TO_H
>
> +#include <linux/percpu.h>
> +
>  #include <asm/cpu-features.h>
>  #include <asm/fpu.h>
>  #include <asm/lbt.h>
>
>  struct task_struct;
>
> +DECLARE_PER_CPU(struct task_struct *, __entry_task);
> +
> +static inline void entry_task_switch(struct task_struct *next)
> +{
> +       __this_cpu_write(__entry_task, next);
> +}
I love the UML naming, which means rename __entry_task to cpu_tasks
and rename entry_task_switch() to set_current(), then move them to
current.h.

> +
>  /**
>   * __switch_to - switch execution of a task
>   * @prev:      The task previously executed.
>   * @next:      The task to begin executing.
> - * @next_ti:   task_thread_info(next).
>   * @sched_ra:  __schedule return address.
>   * @sched_cfa: __schedule call frame address.
>   *
> @@ -23,7 +31,7 @@ struct task_struct;
>   * the context of next. Returns prev.
>   */
>  extern asmlinkage struct task_struct *__switch_to(struct task_struct *pr=
ev,
> -                       struct task_struct *next, struct thread_info *nex=
t_ti,
> +                       struct task_struct *next,
>                         void *sched_ra, void *sched_cfa);
>
>  /*
> @@ -37,7 +45,8 @@ do {                                                   =
                       \
>         lose_fpu_inatomic(1, prev);                                      =
       \
>         lose_lbt_inatomic(1, prev);                                      =
       \
>         hw_breakpoint_thread_switch(next);                               =
       \
> -       (last) =3D __switch_to(prev, next, task_thread_info(next),       =
         \
> +       entry_task_switch(next);                                         =
       \
> +       (last) =3D __switch_to(prev, next,                               =
         \
>                  __builtin_return_address(0), __builtin_frame_address(0))=
;      \
>  } while (0)
>
> diff --git a/arch/loongarch/include/asm/thread_info.h b/arch/loongarch/in=
clude/asm/thread_info.h
> index 4d7117fcdc78..2c95a5134976 100644
> --- a/arch/loongarch/include/asm/thread_info.h
> +++ b/arch/loongarch/include/asm/thread_info.h
> @@ -22,9 +22,7 @@
>   *   must also be changed
>   */
>  struct thread_info {
> -       struct task_struct      *task;          /* main task structure */
>         unsigned long           flags;          /* low level flags */
> -       unsigned long           tp_value;       /* thread pointer */
Don't remove tp_value, it has nothing to do with this patch, instead,
it is for future LBT tls.

>         __u32                   cpu;            /* current CPU */
>         int                     preempt_count;  /* 0 =3D> preemptible, <0=
 =3D> BUG */
>         struct pt_regs          *regs;
> @@ -37,20 +35,11 @@ struct thread_info {
>   */
>  #define INIT_THREAD_INFO(tsk)                  \
>  {                                              \
> -       .task           =3D &tsk,                 \
> -       .flags          =3D _TIF_FIXADE,          \
> +       .flags          =3D 0,                    \
Don't change flags.

>         .cpu            =3D 0,                    \
>         .preempt_count  =3D INIT_PREEMPT_COUNT,   \
>  }
>
> -/* How to get the thread information struct from C. */
> -register struct thread_info *__current_thread_info __asm__("$tp");
> -
> -static inline struct thread_info *current_thread_info(void)
> -{
> -       return __current_thread_info;
> -}
> -
>  register unsigned long current_stack_pointer __asm__("$sp");
>
>  #endif /* !__ASSEMBLER__ */
> diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/=
asm-offsets.c
> index 2cc953f113ac..55f4ffc1aca5 100644
> --- a/arch/loongarch/kernel/asm-offsets.c
> +++ b/arch/loongarch/kernel/asm-offsets.c
> @@ -70,7 +70,7 @@ static void __used output_task_defines(void)
>  {
>         COMMENT("LoongArch task_struct offsets.");
>         OFFSET(TASK_STATE, task_struct, __state);
> -       OFFSET(TASK_THREAD_INFO, task_struct, stack);
> +       OFFSET(TASK_STACK, task_struct, stack);
>         OFFSET(TASK_FLAGS, task_struct, flags);
>         OFFSET(TASK_MM, task_struct, mm);
>         OFFSET(TASK_PID, task_struct, pid);
> @@ -84,9 +84,7 @@ static void __used output_task_defines(void)
>  static void __used output_thread_info_defines(void)
>  {
>         COMMENT("LoongArch thread_info offsets.");
> -       OFFSET(TI_TASK, thread_info, task);
>         OFFSET(TI_FLAGS, thread_info, flags);
> -       OFFSET(TI_TP_VALUE, thread_info, tp_value);
>         OFFSET(TI_CPU, thread_info, cpu);
>         OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
>         OFFSET(TI_REGS, thread_info, regs);
> @@ -267,7 +265,8 @@ static void __used output_smpboot_defines(void)
>  {
>         COMMENT("Linux smp cpu boot offsets.");
>         OFFSET(CPU_BOOT_STACK, secondary_data, stack);
> -       OFFSET(CPU_BOOT_TINFO, secondary_data, thread_info);
> +       OFFSET(CPU_BOOT_TASK, secondary_data, task);
> +       OFFSET(CPU_BOOT_OFFSET, secondary_data, offset);
>         BLANK();
>  }
>  #endif
> diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.=
S
> index b53d333a7c42..b099672eab60 100644
> --- a/arch/loongarch/kernel/entry.S
> +++ b/arch/loongarch/kernel/entry.S
> @@ -67,8 +67,11 @@ SYM_CODE_START(handle_syscall)
>  #endif
>
>         move            u0, t0
> -       LONG_LI         tp, ~_THREAD_MASK
> -       and             tp, tp, sp
> +       la_abs          t1, __entry_task
> +#ifdef CONFIG_SMP
> +       LONG_ADD        t1, t1, u0
> +#endif
> +       LONG_L          tp, t1, 0
>
>         move            a0, sp
>         bl              do_syscall
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index 4eed7bc312a8..ec67faab907b 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -74,10 +74,11 @@ SYM_CODE_START(kernel_entry)                        #=
 kernel entry point
>         /* GPR21 used for percpu base (runtime), initialized as 0 */
>         move            u0, zero
>
> -       la.pcrel        tp, init_thread_union
> -       /* Set the SP after an empty pt_regs.  */
> -       PTR_LI          sp, (_THREAD_SIZE - PT_SIZE)
> -       PTR_ADD         sp, sp, tp
> +       la.pcrel        tp, init_task
> +       la.pcrel        t0, init_stack
> +       PTR_LI          t1, _THREAD_SIZE
> +       PTR_ADD         t0, t0, t1
> +       PTR_ADDI        sp, t0, -PT_SIZE
>         set_saved_sp    sp, t0, t1
>
>  #ifdef CONFIG_RELOCATABLE
> @@ -86,8 +87,10 @@ SYM_CODE_START(kernel_entry)                 # kernel =
entry point
>
>  #ifdef CONFIG_RANDOMIZE_BASE
>         /* Repoint the sp into the new kernel */
> -       PTR_LI          sp, (_THREAD_SIZE - PT_SIZE)
> -       PTR_ADD         sp, sp, tp
> +       LONG_LPTR       t0, tp, TASK_STACK
> +       PTR_LI          t1, _THREAD_SIZE
> +       PTR_ADD         t0, t0, t1
> +       PTR_ADDI        sp, t0, -PT_SIZE
>         set_saved_sp    sp, t0, t1
>
>         /* Jump to the new kernel: new_pc =3D current_pc + random_offset =
*/
> @@ -128,7 +131,8 @@ SYM_CODE_START(smpboot_entry)
>  #endif
>         la.pcrel        t0, cpuboot_data
>         ld.d            sp, t0, CPU_BOOT_STACK
> -       ld.d            tp, t0, CPU_BOOT_TINFO
> +       ld.d            tp, t0, CPU_BOOT_TASK
> +       ld.d            u0, t0, CPU_BOOT_OFFSET
>
>         bl              start_secondary
>         ASM_BUG()
> diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/proc=
ess.c
> index 5505fc355e1b..71c9c6468e60 100644
> --- a/arch/loongarch/kernel/process.c
> +++ b/arch/loongarch/kernel/process.c
> @@ -54,6 +54,9 @@
>  #include <asm/vdso.h>
>  #include <asm/vdso/vdso.h>
>
> +DEFINE_PER_CPU(struct task_struct *, __entry_task);
> +EXPORT_PER_CPU_SYMBOL_GPL(__entry_task);
> +
>  #ifdef CONFIG_STACKPROTECTOR
>  #include <linux/stackprotector.h>
>  unsigned long __stack_chk_guard __read_mostly;
> @@ -223,6 +226,9 @@ int copy_thread(struct task_struct *p, const struct k=
ernel_clone_args *args)
>         if (clone_flags & CLONE_SETTLS)
>                 childregs->regs[2] =3D tls;
>
> +       /* Set tp to the new task structure for context switching */
> +       p->thread.reg02 =3D (unsigned long)p;
This should be before "if (unlikely(args->fn))" for kernel thread.

> +
>  out:
>         ptrace_hw_copy_thread(p);
>         clear_tsk_thread_flag(p, TIF_USEDFPU);
> diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/rel=
ocate.c
> index 16f6a9b39659..a9ef38459629 100644
> --- a/arch/loongarch/kernel/relocate.c
> +++ b/arch/loongarch/kernel/relocate.c
> @@ -263,7 +263,7 @@ unsigned long __init relocate_kernel(void)
>                 reloc_offset +=3D random_offset;
>
>                 /* The current thread is now within the relocated kernel =
*/
> -               __current_thread_info =3D RELOCATED_KASLR(__current_threa=
d_info);
> +               current_thread_pointer =3D RELOCATED_KASLR(current_thread=
_pointer);
>
>                 update_reloc_offset(&reloc_offset, random_offset);
>         }
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index 839b23edee87..5d434c5612ab 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -46,6 +46,7 @@
>  #include <asm/pgalloc.h>
>  #include <asm/sections.h>
>  #include <asm/setup.h>
> +#include <asm/switch_to.h>
>  #include <asm/time.h>
>  #include <asm/unwind.h>
>
> @@ -617,4 +618,6 @@ void __init setup_arch(char **cmdline_p)
>  #ifdef CONFIG_KASAN
>         kasan_init();
>  #endif
> +
> +       entry_task_switch(&init_task);
This should be as early as possible, I suggest moving it after unwind_init(=
).

>  }
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index 64a048f1b880..e8b0d2fc2a9a 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -34,6 +34,7 @@
>  #include <asm/paravirt.h>
>  #include <asm/processor.h>
>  #include <asm/setup.h>
> +#include <asm/switch_to.h>
>  #include <asm/time.h>
>
>  int __cpu_number_map[NR_CPUS];   /* Map physical to logical */
> @@ -400,8 +401,9 @@ void loongson_boot_secondary(int cpu, struct task_str=
uct *idle)
>         pr_info("Booting CPU#%d...\n", cpu);
>
>         entry =3D __pa_symbol((unsigned long)&smpboot_entry);
> -       cpuboot_data.stack =3D (unsigned long)__KSTK_TOS(idle);
> -       cpuboot_data.thread_info =3D (unsigned long)task_thread_info(idle=
);
> +       cpuboot_data.stack =3D (unsigned long)task_pt_regs(idle);
> +       cpuboot_data.task =3D (unsigned long)idle;
> +       cpuboot_data.offset =3D per_cpu_offset(cpu);
>
>         csr_mail_send(entry, cpu_logical_map(cpu), 0);
>
> @@ -686,6 +688,8 @@ asmlinkage void start_secondary(void)
>          */
>         complete(&cpu_running);
>
> +       entry_task_switch(current);
This should be as early as possible, I suggest moving it after cpu_probe().

> +
>         /*
>          * irq will be enabled in loongson_smp_finish(), enabling it too
>          * early is dangerous.
> diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switc=
h.S
> index f377d8f5c51a..644348e05f6a 100644
> --- a/arch/loongarch/kernel/switch.S
> +++ b/arch/loongarch/kernel/switch.S
> @@ -12,7 +12,7 @@
>
>  /*
>   * task_struct *__switch_to(task_struct *prev, task_struct *next,
> - *                         struct thread_info *next_ti, void *sched_ra, =
void *sched_cfa)
> + *                         void *sched_ra, void *sched_cfa)
>   */
>         .align  5
>  SYM_FUNC_START(__switch_to)
> @@ -33,11 +33,12 @@ SYM_FUNC_START(__switch_to)
>         LONG_SPTR       t8, t7, 0
>  #endif
>
> -       move    tp, a2
> +       move    tp, a1
>         cpu_restore_nonscratch a1
>
> -       li.w            t0, _THREAD_SIZE
> -       PTR_ADD         t0, t0, tp
> +       LONG_LPTR       t0, tp, TASK_STACK
This should be "LONG_LPTR       t0, tp, (TASK_STACK -
TASK_STRUCT_OFFSET)", otherwise it is wrong for 32BIT.

Huacai
> +       PTR_LI          t1, _THREAD_SIZE
> +       PTR_ADD         t0, t0, t1
>         set_saved_sp    t0, t1, t2
>
>         LONG_LPTR       t1, a1, (THREAD_CSRPRMD - TASK_STRUCT_OFFSET)
> --
> 2.42.0
>
>
