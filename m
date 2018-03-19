From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 02/19] csky: Exception handling and syscall
Date: Mon, 19 Mar 2018 14:47:44 +0800
Message-ID: <20180319064744.GA10134@guoren-Inspiron-7460>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <fe603a94a7755528ff6f5ac288a017e2a20071c4.1521399976.git.ren_guo@c-sky.com>
 <20180319014755.s2n65f3hzzemc7do@salmiak>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180319014755.s2n65f3hzzemc7do@salmiak>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

Hi Mark,

> Here you open code an MFCR instruction.
> 
> I guess MFCR stands for something like move-from-control-register, and MTCR
> stands for move-to-control-register?
> 
> I see that later on you have helpers for specific registers, e.g. mfcr_cpuidrr().
> 
> You might want to follow the example of arm64's read_sysreg() and
> write_sysreg(), and have general purpose helpers for thos instructions, e.g.
> 
> #define mfcr(reg)						\
> ({								\
> 	unsigned long __mfcr_val;				\
> 	asm volatile("mfcr %0, " #reg "\n" : "=r" (__mfr_val));	\
> 	__mfcr_val;						\
> })
> 
> ... which avoids needing helpers for each register, as you can do:
> 
> ss1_val = mfcr(ss1);
> cpuidrr_val = mfcr(cpuidrr);
>
OK, good idea.

> > +	if (memblock_start_of_DRAM() != (PHYS_OFFSET + CONFIG_RAM_BASE)) {
> > +		pr_err("C-SKY: dts-DRAM doesn't fit .config: %x-%x.\n",
> > +			memblock_start_of_DRAM(),
> > +			PHYS_OFFSET + CONFIG_RAM_BASE);
> > +		return;
> > +	}
> 
> If this is a problem, is it safe to continue at all?
> 
> Why does the base address of RAM matter?
>
We use mips-like direct-mapping tech, and it need 512MB boundary
alignment. And few users need non-512MB boundary phy-addr start,
so we give the CONFIG_RAM_BASE for determine the offset to PHYS_OFFSET.

> > +
> > +	mtcr_msa0(PHYS_OFFSET | 0xe);
> > +	mtcr_msa1(PHYS_OFFSET | 0x6);
> 
> As with MFCR, you could use a generic helper here, e.g.
>
> #define mtcr(val, reg)								\
> do {										\
> 	asm volatile("mtcr %0, " #reg "\n" : "=r" ((unsigned long)val));	\
> } while (0);
> 
> mtcr(PHYS_OFFSET | 0xe, msa0)
> mtcr(PHYS_OFFSET | 0x6, msa1)
>
OK

> > +	seq_printf(m, "C-SKY CPU : %s\n", CSKYCPU_DEF_NAME);
> > +	seq_printf(m, "revision  : 0x%08x\n", mfcr_cpuidrr());
> > +	seq_printf(m, "ccr reg   : 0x%08x\n", mfcr_ccr());
> > +	seq_printf(m, "ccr2 reg  : 0x%08x\n", mfcr_ccr2());
> > +	seq_printf(m, "hint reg  : 0x%08x\n", mfcr_hint());
> > +	seq_printf(m, "msa0 reg  : 0x%08x\n", mfcr_msa0());
> > +	seq_printf(m, "msa1 reg  : 0x%08x\n", mfcr_msa1());
> 
> Do these need to be exposed to userspace?
>
Yes, I'll add more explain info.

> Does this arch support SMP? I see you don't log information per-cpu.
This patch-set doesn't support SMP.
> 
> > diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
> 
> > +#define THREADSIZE_MASK_BIT 13
> 
> You might want to define this as THREAD_SHIFT, and define THREAD_SIZE in terms
> of it, so that they're guaranteed to be in sync
> 
> e.g. in your <asm/thread_info.h> have:
> 
> #define THREAD_SHIFT	13
> #define THREAD_SIZE	(1 << THREAD_SHIFT)
OK

> If you have a spare register that you can point at the current task (or you
> have preemption-safe percpu ops), I'd recommend moving the thread_info off of
> the stack, and implementing THREAD_INFO_IN_TASK_STRUCT.
>
Em... I'll think about it.

> For consistency, and in case you change your stack size in future, this should
> be THREADSIZE_MASK_BIT.
>
OK

> > +        if (unlikely(address >= VMALLOC_START && address <= VMALLOC_END))
> > +                goto vmalloc_fault;
> 
> You might want to check if this was a user mode fault here, so that users can't trigger vmalloc faults.
Is it necessary to check user mode? If a user-process touch a
kernel-addr, it will cause a supervisor exception.

Best Regards
  Guo Ren
