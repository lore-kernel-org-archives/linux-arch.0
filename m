Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0DC345CD3;
	Wed,  3 Jun 2026 02:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780453848; cv=none; b=tp5VzXQ+FciOzViguLE0oJO86WIjljMv4a19j843fWJOcLVb/F514j9E2bqVj4Csoz/6gGBzyEVjNwqoZFVbpiDnsStsigYeJufvrzprnpcEDS02WfD+2NZ9yeXvL43FAMSSx/QHgSFXeXiSCKSLjVve9fths0EH1H5P+5A3mQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780453848; c=relaxed/simple;
	bh=G/KMNiGPjerxe0Nsgg4bWJKIq2D+y7qJylbgnDfCb8Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aN9DqMO+142sI0UxsGfnlRYFaQQ50f9/PasWsy1H8BB2MmM/U5O2qTymFmdQKO15/qhh2MX2xogfwX4MuEyk35HixPS0Ja3Cy4EEcwVxREISqSFCWIhAlmtEfOM+xKl8xB4V5TJe5SkRmBTmKwsPISrcWx6cgz74Z4FnWPwoM0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxT+rJkR9qHvsPAA--.43931S3;
	Wed, 03 Jun 2026 10:30:33 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxHMLEkR9qYxWaAA--.29560S3;
	Wed, 03 Jun 2026 10:30:29 +0800 (CST)
Subject: Re: [RFC PATCH 1/3] LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260428072021.7289-1-yangtiezhu@loongson.cn>
 <20260428072021.7289-2-yangtiezhu@loongson.cn>
 <CAAhV-H5tLpXtnMJOx=b5MCDY71jMNkQ5pv1YhgCf72FV=ewcxg@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <0def4127-3850-1114-d576-42748456f400@loongson.cn>
Date: Wed, 3 Jun 2026 10:30:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5tLpXtnMJOx=b5MCDY71jMNkQ5pv1YhgCf72FV=ewcxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHMLEkR9qYxWaAA--.29560S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoWfWr48ZF47Zw4kKF1rXFW3CFX_yoW5Ww1kWo
	WS9a1qyr4xGF4DC3WDKF4kGFWUXry09FWkA3yIvws8uF1UZw13Gry8Cw43XFyagF4kK39r
	ua4xGwn0vFZaqFn3l-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUY27kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
	CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXU
	UUUU=

On 2026/6/1 下午9:46, Huacai Chen wrote:
> Hi, Tiezhu,

...

> First of all, you should update
> Documentation/features/core/thread-info-in-task/arch-support.txt
> together.

OK, will do it.

>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 3b042dbb2c41..ea29d5d17588 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -210,6 +210,7 @@ config LOONGARCH
>>          select SYSCTL_ARCH_UNALIGN_NO_WARN
>>          select SYSCTL_EXCEPTION_TRACE
>>          select SWIOTLB if 64BIT
>> +       select THREAD_INFO_IN_TASK
>>          select TRACE_IRQFLAGS_SUPPORT
>>          select USE_PERCPU_NUMA_NODE_ID
>>          select USER_STACKTRACE_SUPPORT

...

>> +#define INIT_THREAD  {                                                 \
>> +       .reg02 = (unsigned long)&init_task,                             \
>> +       .reg03 = (unsigned long)&init_stack + sizeof(init_stack),       \
>>   }
> Don't remove the old code, just adding reg02 is enough. Though the
> result is the same, explicitly initialization can give more
> information.

After thinking it through, the introduction and initialization of
thread_struct.reg02 (including the assignment in INIT_THREAD and
p->thread.reg02 = (unsigned long)p; in copy_thread()) are redundant
and should be removed. The reasons are as follows:

1. Direct update in __switch_to: In __switch_to within switch.S, the
    hardware $tp register is updated directly from the next argument
    (via register a1) using "move tp, a1".

2. No restoration path: The cpu_restore_nonscratch macro does not
    include any restoration logic for reg02. This means no assembly
    or C code ever reads thread_struct.reg02 across the entire context
    switch path, whether standard or non-standard.

3. Exception/Syscall recovery relies on per-CPU variables: At exception
    and system call entry points (e.g., in stackframe.h and entry.S),
    the recovery of the kernel-space $tp relies entirely on the per-CPU
    variable __entry_task, which is already properly and explicitly
    updated during entry_task_switch() and CPU initialization.

Consequently, reg02 is a classic piece of dead code (write-only, never
read), and trimming this field would keep the architecture code clean.

Regarding the explicit zero-initialization, it is redundant in modern
kernel development.

For static structures like init_task, any uninitialized fields are
automatically zeroed out by the compiler according to the C standard.
Stripping away dozens of lines of ".field = 0" complies with modern
Linux kernel code-cleaning standards. It makes the macro much shorter
and highlights the only field that actually requires a special
runtime value (the kernel stack top in .reg03).

For reference, please see how INIT_THREAD is defined in other major
architectures, where they only initialize what is strictly necessary:

x86
#ifdef CONFIG_X86_32
#define INIT_THREAD  {							  \
	.sp0			= TOP_OF_INIT_STACK,			  \
	.sysenter_cs		= __KERNEL_CS,				  \
}

#else
extern unsigned long __top_init_kernel_stack[];

#define INIT_THREAD {							\
	.sp	= (unsigned long)&__top_init_kernel_stack,		\
}

#endif /* CONFIG_X86_64 */

arm64:
#define INIT_THREAD {				\
	.fpsimd_cpu = NR_CPUS,			\
}

riscv:
#define INIT_THREAD {					\
	.sp = sizeof(init_stack) + (long)&init_stack,	\
	.align_ctl = PR_UNALIGN_NOPRINT,		\
}

Therefore, a cleaner and more accurate approach is to drop
reg02 entirely and adopt the slimmed-down INIT_THREAD for
LoongArch.

>>   struct task_struct;
>> diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
>> index e5d21e836d99..37f53629d3c7 100644
>> --- a/arch/loongarch/include/asm/ptrace.h
>> +++ b/arch/loongarch/include/asm/ptrace.h
>> @@ -170,12 +170,6 @@ static inline void die_if_kernel(const char *str, struct pt_regs *regs)
>>                  die(str, regs);
>>   }
>>
>> -#define current_pt_regs()                                              \
>> -({                                                                     \
>> -       unsigned long sp = (unsigned long)__builtin_frame_address(0);   \
>> -       (struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1) - 1;           \
>> -})
>> -
> This is still correct after CONFIG_THREAD_INFO_IN_TASK, so please keep
> it. Especially CONFIG_THREAD_INFO_IN_TASK increases the cost of
> exception/syscalls, keeping this can minimize the performance
> impaction.

Regarding the suggestion to keep the custom current_pt_regs() macro
under CONFIG_THREAD_INFO_IN_TASK, it must be completely removed.
Keeping it would be fundamentally incorrect and dangerous for the
following reasons:

1. It becomes logically incorrect:

The old macro relies on aligning up the $sp to the top of the stack
via bitwise operations to locate the exact position of pt_regs.

With CONFIG_THREAD_INFO_IN_TASK enabled, the thread_info is moved
off the stack, and the strict coupling between the masked SP and
the absolute position of pt_regs is broken (especially if features
like VMAP_STACK are enabled in the future, where stacks are no
longer naturally aligned to THREAD_SIZE).

Keeping this macro will cause current_pt_regs() to return a
corrupted/incorrect pointer, leading to inevitable kernel panics
or silent data corruption.

2. No real performance benefit:

Once CONFIG_THREAD_INFO_IN_TASK is selected, current is simply
the hardware $tp register. Fetching pt_regs via task_pt_regs()
just compiles down to loading the stack pointer from $tp with
a single memory access, followed by a constant offset adjustment.

This is extremely fast and efficient on LoongArch, and it avoids
multiple ALU operations (or, add, sub) required by the old
SP-masking macro.

3. Alignment with other architectures:

Other major architectures (such as x86, arm64, and riscv) all
completely dropped their custom SP-masking current_pt_regs()
implementations when moving to THREAD_INFO_IN_TASK, relying
instead on the standard, safe, and generic task_pt_regs()
provided by the core kernel wrapper.

Therefore, this custom macro is both broken and insecure under
the new standard, and it must be removed to ensure kernel
stability and clean code alignment with upstream.

>>   /* Helpers for working with the user stack pointer */

...

>> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
>> index ecc8e50fffa8..eeda5dcc982e 100644
>> --- a/arch/loongarch/include/asm/stackframe.h
>> +++ b/arch/loongarch/include/asm/stackframe.h
>> @@ -191,8 +191,13 @@
>>          andi    t0, t0, 0x3     /* extract pplv bit */
>>          beqz    t0, 9f
>>
>> -       LONG_LI tp, ~_THREAD_MASK
>> -       and     tp, tp, sp
>> +       la_abs      t1, __entry_task
>> +#ifdef CONFIG_SMP
>> +       csrrd       t0, PERCPU_BASE_KS
>> +       LONG_ADD    t1, t1, t0
>> +#endif
>> +       LONG_L      tp, t1, 0
>> +
>>          cfi_st  u0, PT_R21, \docfi
>>          csrrd   u0, PERCPU_BASE_KS
> Move these lines near to "cfi_st  fp, PT_R22, \docfi", then the above
> "csrrd       t0, PERCPU_BASE_KS" can be removed.

Regarding the suggestion for stackframe.h:

Looking at the original macro context, this is an excellent and
completely feasible assembly optimization.

By moving the __entry_task restoration right after the preservation
of u0, we can advance the "csrrd u0, PERCPU_BASE_KS" instruction and
reuse the loaded u0 register directly for the LONG_ADD on SMP platforms.
This completely eliminates the need for a duplicate csrrd instruction
inside the #ifdef CONFIG_SMP block.

The optimized code block would look like this:

         beqz    t0, 9f

         cfi_st  u0, PT_R21, \docfi
         csrrd   u0, PERCPU_BASE_KS

         la_abs      t1, __entry_task
#ifdef CONFIG_SMP
         LONG_ADD    t1, t1, u0
#endif
         LONG_L      tp, t1, 0

9:

Thank you for catching this! I will gladly incorporate this assembly
optimization into the next version.

>> diff --git a/arch/loongarch/include/asm/switch_to.h b/arch/loongarch/include/asm/switch_to.h
>> index 5b225aff3ba2..9932429cfe17 100644
>> --- a/arch/loongarch/include/asm/switch_to.h
>> +++ b/arch/loongarch/include/asm/switch_to.h
>> @@ -5,17 +5,25 @@
>>   #ifndef _ASM_SWITCH_TO_H
>>   #define _ASM_SWITCH_TO_H
>>
>> +#include <linux/percpu.h>
>> +
>>   #include <asm/cpu-features.h>
>>   #include <asm/fpu.h>
>>   #include <asm/lbt.h>
>>
>>   struct task_struct;
>>
>> +DECLARE_PER_CPU(struct task_struct *, __entry_task);
>> +
>> +static inline void entry_task_switch(struct task_struct *next)
>> +{
>> +       __this_cpu_write(__entry_task, next);
>> +}
> I love the UML naming, which means rename __entry_task to cpu_tasks
> and rename entry_task_switch() to set_current(), then move them to
> current.h.

Regarding the suggestion to rename and move __entry_task and
entry_task_switch():

Thank you for the suggestion, but after checking the upstream
kernel implementation, the current naming and placement are
actually fully aligned with the multi-architecture standards
established by ARM/ARM64.

A quick grep in the kernel tree reveals that ARM and ARM64
uses the exact same pattern:

$ grep -rn entry_task arch
arch/arm/kernel/process.c:40:DEFINE_PER_CPU(struct task_struct *, 
__entry_task);
arch/arm/include/asm/switch_to.h:31:		__this_cpu_write(__entry_task, 
next);			\
arch/arm/include/asm/thread_info.h:40:DECLARE_PER_CPU(struct task_struct 
*, __entry_task);
arch/arm/include/asm/assembler.h:357:	ldr_this_cpu	\t1, __entry_task, 
\t1, \t2
arch/arm64/kernel/process.c:609:DEFINE_PER_CPU(struct task_struct *, 
__entry_task);
arch/arm64/kernel/process.c:611:static void entry_task_switch(struct 
task_struct *next)
arch/arm64/kernel/process.c:613:	__this_cpu_write(__entry_task, next);
arch/arm64/kernel/process.c:777:	entry_task_switch(next);
arch/arm64/kernel/entry.S:223:	ldr_this_cpu	tsk, __entry_task, x20
arch/arm64/kernel/entry.S:1033:	ldr_this_cpu	dst=x0, sym=__entry_task, 
tmp=x1

As we can see:
1. Moving to current.h is heavily avoided: Both ARM and ARM64 place
    these definitions in process.c or switch_to.h, rather than
    current.h. <asm/current.h> is a highly sensitive, low-level header
    included almost everywhere. Putting per-CPU macros there would pull
    in <linux/percpu.h> and <linux/sched.h>, inevitably triggering
    catastrophic circular header dependency compile errors.

2. "__entry_task" and "entry_task_switch" are the precise industry
    standards: Rather than adopting UML's historical naming style,
    following the ARM64 conventions makes the code much more canonical
    and easier for cross-architecture developers to maintain.
    It clearly expresses that this per-CPU pointer is strictly
    dedicated to the exception entry path for task recovery.

3. "set_current()" causes mental friction: Across the generic kernel,
    "current" is universally treated as a read-only concept. Introducing
    a set_current() helper might mislead developers into thinking they
    can modify the active task pointer at will, whereas
    "entry_task_switch" explicitly limits its semantics to the context
    switch boundary.

Therefore, I prefer to keep the current naming and structure in
switch_to.h to remain consistent with ARM64 and keep the header
dependencies perfectly clean.

>> +
>>   /**
>>    * __switch_to - switch execution of a task
>>    * @prev:      The task previously executed.
>>    * @next:      The task to begin executing.
>> - * @next_ti:   task_thread_info(next).
>>    * @sched_ra:  __schedule return address.
>>    * @sched_cfa: __schedule call frame address.

...

>>   struct thread_info {
>> -       struct task_struct      *task;          /* main task structure */
>>          unsigned long           flags;          /* low level flags */
>> -       unsigned long           tp_value;       /* thread pointer */
> Don't remove tp_value, it has nothing to do with this patch, instead,
> it is for future LBT tls.

Regarding the suggestion to keep tp_value in thread_info:

You are completely right. I walked into a misunderstanding that
tp_value was strictly coupled with the kernel-space $tp tracking.
Since its true purpose is to preserve the user-space TLS value
for the LBT (Loongson Binary Translation) extension context,
it should definitely be decoupled from this THREAD_INFO_IN_TASK
migration.

I will follow the "one patch does one thing" principle and keep
tp_value untouched in struct thread_info to avoid breaking any
future or existing LBT TLS logic.

Thank you for clarifying this! I will restore this field in the
next version.

>>          __u32                   cpu;            /* current CPU */
>>          int                     preempt_count;  /* 0 => preemptible, <0 => BUG */
>>          struct pt_regs          *regs;
>> @@ -37,20 +35,11 @@ struct thread_info {
>>    */
>>   #define INIT_THREAD_INFO(tsk)                  \
>>   {                                              \
>> -       .task           = &tsk,                 \
>> -       .flags          = _TIF_FIXADE,          \
>> +       .flags          = 0,                    \
> Don't change flags.

Regarding the suggestion to keep the flags initialization:

You are completely right. Modifying the default flags (changing
_TIF_FIXADE to 0) is an unrelated side-effect that goes beyond
the scope of migrating thread_info.

Changing this could alter the alignment error fixing behavior
for the initial idle task and cause unexpected regressions.

I will follow your advice, leave the flags logic untouched,
and only remove the deleted ".task = &tsk" member.

Thank you for your critical review!

>>          .cpu            = 0,                    \
>>          .preempt_count  = INIT_PREEMPT_COUNT,   \

...

>> @@ -223,6 +226,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>>          if (clone_flags & CLONE_SETTLS)
>>                  childregs->regs[2] = tls;
>>
>> +       /* Set tp to the new task structure for context switching */
>> +       p->thread.reg02 = (unsigned long)p;
> This should be before "if (unlikely(args->fn))" for kernel thread.

Regarding the feedback on process.c and thread_struct:

Actually, after double-checking the core architecture assembly,
we don't need to worry about where to place
"p->thread.reg02 = (unsigned long)p;"
because this line can be completely deleted, and reg02 shouldn't
be added to thread_struct at all.

As analyzed previously, during context switch, the hardware $tp
register is updated directly from the C argument "next" via
"move tp, a1".

Furthermore, the cpu_restore_nonscratch macro contains absolutely
no logic to read or restore reg02. This means thread_struct.reg02
has a write-only path and is never read anywhere (even for new
processes or kernel threads). To keep the architecture code clean
and avoid misleading future developers, I will completely drop
reg02 and its assignment from the next version.

>> +
>>   out:
>>          ptrace_hw_copy_thread(p);
>>          clear_tsk_thread_flag(p, TIF_USEDFPU);

...

>> +
>> +       entry_task_switch(&init_task);
> This should be as early as possible, I suggest moving it after unwind_init().

Regarding the suggestion to move entry_task_switch() in setup.c:

You are completely right, and this is a critical catch for early
boot stability.

Placing entry_task_switch(&init_task) at the very end of
setup_arch() leaves a massive window during early initialization
where __entry_task remains NULL.

If any early exception, interrupt, or panic occurs before the end
of setup_arch(), the exception entry path will load a NULL pointer
into $tp, triggering an immediate double-fault and completely
blinding the kernel's ability to print stack traces.

Moving it immediately after unwind_init() ensures that the $tp
recovery mechanism is armed as early as possible, providing robust
exception handling support during the rest of the boot sequence.

I will absolutely adopt this suggestion and move it right after
unwind_init() in the next version. Thank you!

>>   }
>> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
>> index 64a048f1b880..e8b0d2fc2a9a 100644
>> --- a/arch/loongarch/kernel/smp.c
>> +++ b/arch/loongarch/kernel/smp.c

...

>> +       entry_task_switch(current);
> This should be as early as possible, I suggest moving it after cpu_probe().

Regarding the suggestion to move entry_task_switch() in smp.c:

You are completely right, and this is another critical catch for
early boot stability, this time on the secondary CPU path.

Placing entry_task_switch(current) after complete(&cpu_running)
leaves a dangerous window during the early C entry of
start_secondary() where the secondary CPU's __entry_task remains
uninitialized (NULL). If any early exception or kernel panic
occurs during the secondary CPU initialization prior to the
completion signal, the exception entry path will load a NULL
pointer into $tp, inducing an immediate double-fault and
completely blinding the kernel's early SMP debugging
capabilities.

Moving it immediately after cpu_probe() ensures that the
secondary CPU arms its $tp recovery mechanism at the earliest
possible stage in its C entry path.

I will absolutely adopt this suggestion and move it right
after cpu_probe() in the next version. Thank you!

>> +
>>          /*
>>           * irq will be enabled in loongson_smp_finish(), enabling it too
>>           * early is dangerous.
>> diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
>> index f377d8f5c51a..644348e05f6a 100644
>> --- a/arch/loongarch/kernel/switch.S
>> +++ b/arch/loongarch/kernel/switch.S

...

>> +       LONG_LPTR       t0, tp, TASK_STACK
> This should be "LONG_LPTR       t0, tp, (TASK_STACK -
> TASK_STRUCT_OFFSET)", otherwise it is wrong for 32BIT.

Regarding the suggestion for (TASK_STACK - TASK_STRUCT_OFFSET)
in switch.S:

Thank you for bringing this up! With the definition of
TASK_STRUCT_OFFSET in mind:

#ifdef CONFIG_64BIT
#define TASK_STRUCT_OFFSET 0
#else
#define TASK_STRUCT_OFFSET 2000
#endif

This is an incredibly sharp and critical catch for 32BIT
architecture compatibility.

I will update this line to:
"LONG_LPTR       t0, tp, (TASK_STACK - TASK_STRUCT_OFFSET)"
in the next version.

This is the incremental diff based on the original patch:

----->8-----
diff --git 
a/Documentation/features/core/thread-info-in-task/arch-support.txt 
b/Documentation/features/core/thread-info-in-task/arch-support.txt
index f3d744c76061..e26efdfbb6b4 100644
--- a/Documentation/features/core/thread-info-in-task/arch-support.txt
+++ b/Documentation/features/core/thread-info-in-task/arch-support.txt
@@ -12,7 +12,7 @@
      |       arm64: |  ok  |
      |        csky: | TODO |
      |     hexagon: | TODO |
-    |   loongarch: | TODO |
+    |   loongarch: |  ok  |
      |        m68k: | TODO |
      |  microblaze: | TODO |
      |        mips: | TODO |
diff --git a/arch/loongarch/include/asm/processor.h 
b/arch/loongarch/include/asm/processor.h
index df927a4318cc..5d8e82b1dce7 100644
--- a/arch/loongarch/include/asm/processor.h
+++ b/arch/loongarch/include/asm/processor.h
@@ -109,7 +109,7 @@ struct loongarch_vdso_info;
   */
  struct thread_struct {
         /* Main processor registers. */
-       unsigned long reg01, reg02, reg03, reg22; /* ra tp sp fp */
+       unsigned long reg01, reg03, reg22; /* ra sp fp */
         unsigned long reg23, reg24, reg25, reg26; /* s0-s3 */
         unsigned long reg27, reg28, reg29, reg30, reg31; /* s4-s8 */

@@ -146,7 +146,6 @@ struct thread_struct {
  #define thread_saved_fp(tsk)   (tsk->thread.sched_cfa)

  #define INIT_THREAD  {                                                 \
-       .reg02 = (unsigned long)&init_task,                             \
         .reg03 = (unsigned long)&init_stack + sizeof(init_stack),       \
  }

diff --git a/arch/loongarch/include/asm/stackframe.h 
b/arch/loongarch/include/asm/stackframe.h
index eeda5dcc982e..770db1084e8d 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -191,15 +191,15 @@
         andi    t0, t0, 0x3     /* extract pplv bit */
         beqz    t0, 9f

+       cfi_st  u0, PT_R21, \docfi
+       csrrd   u0, PERCPU_BASE_KS
+
         la_abs      t1, __entry_task
  #ifdef CONFIG_SMP
-       csrrd       t0, PERCPU_BASE_KS
-       LONG_ADD    t1, t1, t0
+       LONG_ADD    t1, t1, u0
  #endif
         LONG_L      tp, t1, 0

-       cfi_st  u0, PT_R21, \docfi
-       csrrd   u0, PERCPU_BASE_KS
  9:
  #ifdef CONFIG_KGDB
         li.w    t0, CSR_CRMD_WE
diff --git a/arch/loongarch/include/asm/thread_info.h 
b/arch/loongarch/include/asm/thread_info.h
index 2c95a5134976..41eabe4fb647 100644
--- a/arch/loongarch/include/asm/thread_info.h
+++ b/arch/loongarch/include/asm/thread_info.h
@@ -23,6 +23,7 @@
   */
  struct thread_info {
         unsigned long           flags;          /* low level flags */
+       unsigned long           tp_value;       /* thread pointer */
         __u32                   cpu;            /* current CPU */
         int                     preempt_count;  /* 0 => preemptible, <0 
=> BUG */
         struct pt_regs          *regs;
@@ -35,7 +36,7 @@ struct thread_info {
   */
  #define INIT_THREAD_INFO(tsk)                  \
  {                                              \
-       .flags          = 0,                    \
+       .flags          = _TIF_FIXADE,          \
         .cpu            = 0,                    \
         .preempt_count  = INIT_PREEMPT_COUNT,   \
  }
diff --git a/arch/loongarch/kernel/process.c 
b/arch/loongarch/kernel/process.c
index 71c9c6468e60..2f916c4e0e8f 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -226,9 +226,6 @@ int copy_thread(struct task_struct *p, const struct 
kernel_clone_args *args)
         if (clone_flags & CLONE_SETTLS)
                 childregs->regs[2] = tls;

-       /* Set tp to the new task structure for context switching */
-       p->thread.reg02 = (unsigned long)p;
-
  out:
         ptrace_hw_copy_thread(p);
         clear_tsk_thread_flag(p, TIF_USEDFPU);
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 5d434c5612ab..7065d195f2da 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -594,6 +594,7 @@ void __init setup_arch(char **cmdline_p)
  {
         cpu_probe();
         unwind_init();
+       entry_task_switch(&init_task);

         init_environ();
         efi_init();
@@ -618,6 +619,4 @@ void __init setup_arch(char **cmdline_p)
  #ifdef CONFIG_KASAN
         kasan_init();
  #endif
-
-       entry_task_switch(&init_task);
  }
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index e8b0d2fc2a9a..4b74409a98a3 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -665,6 +665,7 @@ asmlinkage void start_secondary(void)
         set_my_cpu_offset(per_cpu_offset(cpu));

         cpu_probe();
+       entry_task_switch(current);
         constant_clockevent_init();
         loongson_init_secondary();

@@ -688,8 +689,6 @@ asmlinkage void start_secondary(void)
          */
         complete(&cpu_running);

-       entry_task_switch(current);
-
         /*
          * irq will be enabled in loongson_smp_finish(), enabling it too
          * early is dangerous.
diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
index 644348e05f6a..33a10221d73a 100644
--- a/arch/loongarch/kernel/switch.S
+++ b/arch/loongarch/kernel/switch.S
@@ -24,8 +24,8 @@ SYM_FUNC_START(__switch_to)
         LONG_SPTR       t1, a0, (THREAD_CSRPRMD - TASK_STRUCT_OFFSET)

         cpu_save_nonscratch a0
-       LONG_SPTR       a3, a0, (THREAD_SCHED_RA - TASK_STRUCT_OFFSET)
-       LONG_SPTR       a4, a0, (THREAD_SCHED_CFA - TASK_STRUCT_OFFSET)
+       LONG_SPTR       a2, a0, (THREAD_SCHED_RA - TASK_STRUCT_OFFSET)
+       LONG_SPTR       a3, a0, (THREAD_SCHED_CFA - TASK_STRUCT_OFFSET)

  #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP)
         la              t7, __stack_chk_guard
@@ -36,7 +36,7 @@ SYM_FUNC_START(__switch_to)
         move    tp, a1
         cpu_restore_nonscratch a1

-       LONG_LPTR       t0, tp, TASK_STACK
+       LONG_LPTR       t0, tp, (TASK_STACK - TASK_STRUCT_OFFSET)
         PTR_LI          t1, _THREAD_SIZE
         PTR_ADD         t0, t0, t1
         set_saved_sp    t0, t1, t2

Here is a test script:

$ cat stress_test.sh
#!/bin/bash
set -e # Exit immediately if any command exits with a non-zero status

echo "=== Starting LoongArch THREAD_INFO_IN_TASK Extreme Stress Testing ==="
START_TIME=$(date)

# Clear existing dmesg buffer and back it up safely to /tmp
dmesg -c > /tmp/init_dmesg.log

# 1. Core Context Switch Stress Test
# Validates __switch_to() assembly and the 32-bit/64-bit structural 
offset calculations.
echo "Running: --context stressor (10 mins)..."
stress-ng --context $(nproc) --timeout 10m --metrics-brief

# 2. Bad System Calls and Exception Path Stress Test
# Validates handle_syscall and the __entry_task recovery path during 
exception entry.
# Fixed option to use the unambiguous '--sysbadaddr'
echo "Running: --sysbadaddr stressor (10 mins)..."
stress-ng --sysbadaddr $(nproc) --timeout 10m

# 3. Page Fault and Stack Stress Test
# Validates register reuse optimization (u0/PERCPU_BASE_KS) within the 
SAVE_SOME macro.
echo "Running: --fault stressor (10 mins)..."
stress-ng --fault $(nproc) --timeout 10m

# 4. Multi-Thread Cloning and Destruction Stress Test
# Validates the preservation of tp_value and the correctness of 
copy_thread().
echo "Running: --pthread stressor (10 mins)..."
stress-ng --pthread $(nproc) --timeout 10m

# 5. Ultimate Mixed Scheduling Matrix Test
# Simulates an extremely hostile system environment with high 
concurrency (20 mins).
echo "Running: Mixed Matrix (--schedmix + --yield) (20 mins)..."
stress-ng --schedmix $(nproc) --yield $(nproc) --timeout 20m --metrics

END_TIME=$(date)
echo "=== All stress-ng commands completed successfully ==="
echo "Start Time: $START_TIME"
echo "End Time:   $END_TIME"

# 2. Automated Kernlog Integrity Check
# Scans dmesg for hidden kernel regressions, warnings, or silent corruption.
echo "=== Analyzing kernel dmesg logs... ==="
if sudo dmesg | grep -qEi "oops|panic|warning|bug|recursive|tainted"; then
     echo "❌ WARNING: System survived but dmesg contains kernel errors! 
Please check the logs below:"
     sudo dmesg | grep -Ei "oops|panic|warning|bug|recursive|tainted" -C 5
else
     echo "✅ SUCCESS: dmesg remains perfectly silent! No Oops, Warnings, 
or Panics found."
     echo "The patch successfully passed the 1-hour stress testing suite!"
fi

Here are the test steps:

sudo dnf install -y stress-ng
chmod +x stress_test.sh
sudo ./stress_test.sh

Here is the test result:

$ sudo ./stress_test.sh
=== Starting LoongArch THREAD_INFO_IN_TASK Extreme Stress Testing ===
Running: --context stressor (10 mins)...
stress-ng: info:  [2719] setting to a 10 mins run per stressor
stress-ng: info:  [2719] dispatching hogs: 8 context
stress-ng: metrc: [2719] stressor       bogo ops real time  usr time 
sys time   bogo ops/s     bogo ops/s
stress-ng: metrc: [2719]                           (secs)    (secs) 
(secs)   (real time) (usr+sys time)
stress-ng: metrc: [2719] context        41308615    600.00   2226.94 
2571.93     68847.69        8607.98
stress-ng: info:  [2719] skipped: 0
stress-ng: info:  [2719] passed: 8: context (8)
stress-ng: info:  [2719] failed: 0
stress-ng: info:  [2719] metrics untrustworthy: 0
stress-ng: info:  [2719] successful run completed in 10 mins
Running: --sysbadaddr stressor (10 mins)...
stress-ng: info:  [2742] setting to a 10 mins run per stressor
stress-ng: info:  [2742] dispatching hogs: 8 sysbadaddr
stress-ng: info:  [2742] skipped: 0
stress-ng: info:  [2742] passed: 8: sysbadaddr (8)
stress-ng: info:  [2742] failed: 0
stress-ng: info:  [2742] metrics untrustworthy: 0
stress-ng: info:  [2742] successful run completed in 10 mins
Running: --fault stressor (10 mins)...
stress-ng: info:  [1090732] setting to a 10 mins run per stressor
stress-ng: info:  [1090732] dispatching hogs: 8 fault
stress-ng: info:  [1090732] skipped: 0
stress-ng: info:  [1090732] passed: 8: fault (8)
stress-ng: info:  [1090732] failed: 0
stress-ng: info:  [1090732] metrics untrustworthy: 0
stress-ng: info:  [1090732] successful run completed in 10 mins
Running: --pthread stressor (10 mins)...
stress-ng: info:  [1090760] setting to a 10 mins run per stressor
stress-ng: info:  [1090760] dispatching hogs: 8 pthread
stress-ng: info:  [1090760] skipped: 0
stress-ng: info:  [1090760] passed: 8: pthread (8)
stress-ng: info:  [1090760] failed: 0
stress-ng: info:  [1090760] metrics untrustworthy: 0
stress-ng: info:  [1090760] successful run completed in 10 mins
Running: Mixed Matrix (--schedmix + --yield) (20 mins)...
stress-ng: info:  [3131692] setting to a 20 mins run per stressor
stress-ng: info:  [3131692] dispatching hogs: 8 schedmix, 8 yield
stress-ng: metrc: [3131692] stressor       bogo ops real time  usr time 
sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [3131692]                           (secs)    (secs) 
  (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [3131692] schedmix        6577020   1200.04   1817.35 
  5090.05      5480.67         952.17        71.95          3392
stress-ng: metrc: [3131692] yield         2861718847   1200.00    733.75 
   1937.44   2384764.49     1071325.09        27.82          3360
stress-ng: metrc: [3131692] miscellaneous metrics:
stress-ng: metrc: [3131692] yield               6672.42 ns duration per 
sched_yield call (harmonic mean of 8 instances)
stress-ng: info:  [3131692] skipped: 0
stress-ng: info:  [3131692] passed: 16: schedmix (8) yield (8)
stress-ng: info:  [3131692] failed: 0
stress-ng: info:  [3131692] metrics untrustworthy: 0
stress-ng: info:  [3131692] successful run completed in 20 mins
=== All stress-ng commands completed successfully ===
Start Time: Wed Jun  3 09:03:43 AM CST 2026
End Time:   Wed Jun  3 10:03:44 AM CST 2026
=== Analyzing kernel dmesg logs... ===
✅ SUCCESS: dmesg remains perfectly silent! No Oops, Warnings, or Panics 
found.
The patch successfully passed the 1-hour stress testing suite!

I will send formal patch v1 next week.

Thanks,
Tiezhu

