From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 02/19] csky: Exception handling and syscall
Date: Mon, 19 Mar 2018 01:48:07 +0000
Message-ID: <20180319014755.s2n65f3hzzemc7do@salmiak>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <fe603a94a7755528ff6f5ac288a017e2a20071c4.1521399976.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fe603a94a7755528ff6f5ac288a017e2a20071c4.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

Hi,

On Mon, Mar 19, 2018 at 03:51:24AM +0800, Guo Ren wrote:
> +inline static unsigned int
> +get_regs_value(unsigned int rx, struct pt_regs *regs)
> +{
> +	unsigned int value;
> +
> +	if(rx == 0){
> +		if(user_mode(regs)){
> +			asm volatile("mfcr %0, ss1\n":"=r"(value));

Here you open code an MFCR instruction.

I guess MFCR stands for something like move-from-control-register, and MTCR
stands for move-to-control-register?

I see that later on you have helpers for specific registers, e.g. mfcr_cpuidrr().

You might want to follow the example of arm64's read_sysreg() and
write_sysreg(), and have general purpose helpers for thos instructions, e.g.

#define mfcr(reg)						\
({								\
	unsigned long __mfcr_val;				\
	asm volatile("mfcr %0, " #reg "\n" : "=r" (__mfr_val));	\
	__mfcr_val;						\
})

... which avoids needing helpers for each register, as you can do:

ss1_val = mfcr(ss1);
cpuidrr_val = mfcr(cpuidrr);

[...]

> +static __init void setup_cpu_msa(void)
> +{
> +	if (memblock_start_of_DRAM() != (PHYS_OFFSET + CONFIG_RAM_BASE)) {
> +		pr_err("C-SKY: dts-DRAM doesn't fit .config: %x-%x.\n",
> +			memblock_start_of_DRAM(),
> +			PHYS_OFFSET + CONFIG_RAM_BASE);
> +		return;
> +	}

If this is a problem, is it safe to continue at all?

Why does the base address of RAM matter?

> +
> +	mtcr_msa0(PHYS_OFFSET | 0xe);
> +	mtcr_msa1(PHYS_OFFSET | 0x6);

As with MFCR, you could use a generic helper here, e.g.

#define mtcr(val, reg)								\
do {										\
	asm volatile("mtcr %0, " #reg "\n" : "=r" ((unsigned long)val));	\
} while (0);

mtcr(PHYS_OFFSET | 0xe, msa0)
mtcr(PHYS_OFFSET | 0x6, msa1)

> +}
> +
> +__init void cpu_dt_probe(void)
> +{
> +	setup_cpu_msa();
> +}
> +
> +static int c_show(struct seq_file *m, void *v)
> +{
> +	seq_printf(m, "C-SKY CPU : %s\n", CSKYCPU_DEF_NAME);
> +	seq_printf(m, "revision  : 0x%08x\n", mfcr_cpuidrr());
> +	seq_printf(m, "ccr reg   : 0x%08x\n", mfcr_ccr());
> +	seq_printf(m, "ccr2 reg  : 0x%08x\n", mfcr_ccr2());
> +	seq_printf(m, "hint reg  : 0x%08x\n", mfcr_hint());
> +	seq_printf(m, "msa0 reg  : 0x%08x\n", mfcr_msa0());
> +	seq_printf(m, "msa1 reg  : 0x%08x\n", mfcr_msa1());

Do these need to be exposed to userspace?

Does this arch support SMP? I see you don't log information per-cpu.

[...]

> diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S

> +#define THREADSIZE_MASK_BIT 13

You might want to define this as THREAD_SHIFT, and define THREAD_SIZE in terms
of it, so that they're guaranteed to be in sync

e.g. in your <asm/thread_info.h> have:

#define THREAD_SHIFT	13
#define THREAD_SIZE	(1 << THREAD_SHIFT)

[...]

> +ENTRY(csky_systemcall)
> +	SAVE_ALL_TRAP
> +
> +	psrset  ee, ie
> +
> +	/* Stack frame for syscall, origin call set_esp0 */
> +	mov     r12, sp
> +
> +	bmaski  r11, 13
> +	andn    r12, r11
> +	bgeni   r11, 9
> +	addi    r11, 32
> +	addu    r12, r11
> +	st      sp, (r12, 0)
> +
> +	lrw     r11, __NR_syscalls
> +	cmphs   syscallid, r11                 /* Check nr of syscall */
> +	bt      ret_from_exception
> +
> +	lrw     r13, sys_call_table
> +	ixw     r13, syscallid                 /* Index into syscall table */
> +	ldw     r11, (r13)               /* Get syscall function */
> +	cmpnei  r11, 0                  /* Check for not null */
> +	bf      ret_from_exception
> +
> +	mov     r9, sp				 /* Get task pointer */
> +	bmaski  r10, THREADSIZE_MASK_BIT
> +	andn    r9, r10                      /* Get thread_info */

If you have a spare register that you can point at the current task (or you
have preemption-safe percpu ops), I'd recommend moving the thread_info off of
the stack, and implementing THREAD_INFO_IN_TASK_STRUCT.

[...]

> +ENTRY(csky_get_tls)
> +	USPTOKSP
> +
> +	/* increase epc for continue */
> +	mfcr	a0, epc
> +	INCTRAP	a0
> +	mtcr	a0, epc
> +
> +	/* get current task thread_info with kernel 8K stack */
> +	bmaski   a0, (PAGE_SHIFT + 1)

For consistency, and in case you change your stack size in future, this should
be THREADSIZE_MASK_BIT.

[...]

> +/*
> + * This routine handles page faults.  It determines the address,
> + * and the problem, and then passes it off to one of the appropriate
> + * routines.
> + */
> +asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
> +                              unsigned long mmu_meh)
> +{
> +        struct vm_area_struct * vma = NULL;
> +        struct task_struct *tsk = current;
> +        struct mm_struct *mm = tsk->mm;
> +        siginfo_t info;
> +	int fault;
> +	unsigned long address = mmu_meh & PAGE_MASK;
> +
> +        info.si_code = SEGV_MAPERR;
> +
> +        /*
> +         * We fault-in kernel-space virtual memory on-demand. The
> +         * 'reference' page table is init_mm.pgd.
> +         *
> +         * NOTE! We MUST NOT take any locks for this case. We may
> +         * be in an interrupt or a critical region, and should
> +         * only copy the information from the master page table,
> +         * nothing more.
> +         */
> +        if (unlikely(address >= VMALLOC_START && address <= VMALLOC_END))
> +                goto vmalloc_fault;

You might want to check if this was a user mode fault here, so that users can't trigger vmalloc faults.

Thanks,
Mark.

> +vmalloc_fault:
> +        {
> +                /*
> +                 * Synchronize this task's top level page-table
> +                 * with the 'reference' page table.
> +                 *
> +                 * Do _not_ use "tsk" here. We might be inside
> +                 * an interrupt in the middle of a task switch..
> +                 */
> +                int offset = __pgd_offset(address);
> +                pgd_t *pgd, *pgd_k;
> +                pud_t *pud, *pud_k;
> +                pmd_t *pmd, *pmd_k;
> +                pte_t *pte_k;
> +
> +                unsigned long pgd_base;
> +		pgd_base = tlb_get_pgd();
> +                pgd = (pgd_t *)pgd_base + offset;
> +                pgd_k = init_mm.pgd + offset;
> +
> +                if (!pgd_present(*pgd_k))
> +                        goto no_context;
> +                set_pgd(pgd, *pgd_k);
> +
> +                pud = (pud_t *)pgd;
> +                pud_k = (pud_t *)pgd_k;
> +                if (!pud_present(*pud_k))
> +                        goto no_context;
> +
> +                pmd = pmd_offset(pud, address);
> +                pmd_k = pmd_offset(pud_k, address);
> +                if (!pmd_present(*pmd_k))
> +                        goto no_context;
> +                set_pmd(pmd, *pmd_k);
> +
> +                pte_k = pte_offset_kernel(pmd_k, address);
> +                if (!pte_present(*pte_k))
> +                        goto no_context;
> +                return;
> +        }
> +}
> +
> -- 
> 2.7.4
> 
