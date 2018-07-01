From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 00/19] C-SKY(csky) Linux Kernel Port
Date: Mon,  2 Jul 2018 01:30:03 +0800
Message-ID: <cover.1530465325.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

This is the 2th version patchset to add the Linux kernel port for C-SKY(csky).
Thanks to everyone who provided feedback on the previous version.

This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
CPU cores and the patches are based on linux-4.16.2.

There are two ABI versions with several CPU cores in this patchset:
  ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
  ABIv2: ck807 ck810 ck860 (16/32-bit variable length instruction, PIPT Cache,
	 SMP ...)

More information: http://en.c-sky.com

I'm from Hangzhou,China C-SKY Microsystems and responsible for C-SKY Linux
port. The development repo is
https://github.com/c-sky/csky-linux

We use buildroot as our CI-test enviornment. "LTP, Lmbench, uclibc-ng-test ..."
will be tested for every commit. See here for more details:
  https://gitlab.com/c-sky/buildroot/pipelines

You can try C-SKY linux in a few steps:
  $ git clone https://github.com/c-sky/buildroot.git
  $ cd buildroot
  $ make qemu_csky_ck807_uclibc_bt_defconfig
  $ make
It will download "linux uclibc-ng gcc binutils qemu busybox" source code and build
them into one image. How to run, See:
  https://github.com/c-sky/buildroot/blob/master/board/qemu/csky/readme.txt

I've finished uClibc-ng.org upstream and "gcc glibc binutils qemu ..." upstream is
on going and the source code is here:
  https://github.com/c-sky

Any feedback is welcome.

Changes in v2:
a29bfc8 csky: add pre_mmu_init, move misc mmu setup to mm/init.c
4eab702 csky: no need kmap for !VM_EXEC.
6770eec csky: Use TEE as the name of CPU Trusted Execution Enviornment.
a56c8c7 csky: update the cache flush api.
1a48a95 csky: add C-SKY Trust Zone.
b7a0a44 csky: use CONFIG_RAM_BASE as the same in memory of dts.
15adf81 csky: remove unused code.
35c0d97 csky: bugfix lost a cacheline flush when start isn't cacheline-aligned.
4e82c8d csky: use tlbi.alls for ck860 smp temporary.
ae7149e csky: bugfix use kmap_atomic() to prevent no mapped addr.
5538795 csky: bugfix user access in kernel space.
a7aa591 csky: add 16bit user space bkpt.
0de70ec csky: add sync.is for cmpxchg in SMP.
c5c08a1 csky: seperate sync.is and sync for SMP and Non-SMP.
dbbf4dc csky: use sync.is for ck860 mb().
f33f8da csky: rewrite the alignment implement.
68152c7 csky: bugfix alignment pt_regs error.
d618d43 csky: support set_affinity for irq balance in SMP
ebf86c9 csky: bugfix compile error without CONFIG_SMP.
8537eea csky: remove debug code.
4ebc051 csky: bugfix compile error with linux-4.9.56
75a938e csky: C-SKY SMP supported.
0eebc07 csky: use internal function for map_sg.
3d29751 csky: bugfix can't support highmem
b545d2a csky: bugfix r26 is the link reg for jsri_to_jsr.
9e3313a csky: bugfix sync tls for abiv1 in ptrace.
587a0d2 csky: use __NR_rt_sigreturn in asm-generic.
f562b46 csky: bugfix gpr_set & fpr_set
f57266f csky: bugfix fpu_fpe_helper excute mtcr mfcr.
c676669 csky: bugfix ave is default enable on reset.
d40d34d csky: remove unused sc_mask in sigcontext.h.
274b7a2 csky: redesign the signal's api
7501771 csky: bugfix forget restore usp.
923e2ca csky: re-struct the pt_regs for regset.
2a1e499 csky: fixup config.
ada81ec csky: bugfix abiv1 compile error.
e34acb9 csky: bugfix abiv1 couldn't support -mno-stack-size.
ec53560 csky: change irq map, reserve soft_irq&private_irq space.
c7576f7 csky: bugfix modpost warning with -mno-stack-size
c8ff9d4 csky: support csky mp timer alpha version.
deabaaf csky: update .gitignore.
574815c csky: bugfix compile error with abiv1 in 4.15
0b426a7 csky: bugfix format of cpu verion id.
083435f csky: irq-csky-v2 alpha init.
21209e5 csky: add .gitignore
73e19b4 csky: remove FMFS_FPU_REGS/FMTS_FPU_REGS
07e8fac csky: add fpu regset in ptrace.c
cac779d csky: add CSKY_VECIRQ_LEGENCY for SOC bug.
54bab1d csky: move usp into pt_regs.
b167422 csky: support regset for ptrace.
a098d4c csky: remove ARCH_WANT_IPC_PARSE_VERSION
fe61a84 csky: add timer-of support.
27702e2 csky: bugfix boot error.
ebe3edb csky: bugfix gx6605s boot failed  - add __HEAD to head.section for head.S  - move INIT_SECTION together to fix compile warning.
7138cae csky: coding convension for timer-nationalchip.c
fa7f9bb csky: use ffs instead of fls.
ddc9e81 csky: change to generic irq chip for irq-csky.c
e9be8b9 irqchip: add generic irq chip for irq-nationalchip
2ee83fe csky: add set_handle_irq(), ref from openrisc & arm.
74181d6 csky: use irq_domain_add_linear instead of leagcy.
fa45ae4 csky: bugfix setup stroge order for uncached.
eb8030f csky: add HIGHMEM config in Kconfig
4f983d4 csky: remove "default n" in Kconfig
2467575 csky: use asm-generic/signal.h
77438e5 csky: coding conventions for irq.c
2e4a2b4 csky: optimize the cache flush ops.
96e1c58 csky: add CONFIG_CPU_ASID_BITS.
9339666 csky: add cprcr() cpwcr() for abiv1
ff05be4 csky: add THREAD_SHIFT define in asm/page.h
52ab022 csky: add mfcr() mtcr() in asm/reg_ops.h
bdcd8f3 csky: revert back Kconfig select.
590c7e6 csky: bugfix compile error with CONFIG_AUDIT
1989292 csky: revert some back with cleanup unistd.h
f1454fe csky: cleanup unistd.h
5d2985f csky: cleanup Kconfig and Makefile.
423d97e csky: cancel subdirectories
cae2af4 csky: use asm-generic/fcntl.h

Guo Ren (19):
  csky: Build infrastructure
  csky: defconfig
  csky: Kernel booting
  csky: Exception handling
  csky: System Call
  csky: Cache and TLB routines
  csky: MMU and page table management
  csky: Process management and Signal
  csky: VDSO and rt_sigreturn
  csky: IRQ handling
  csky: Atomic operations
  csky: ELF and module probe
  csky: Library functions
  csky: User access
  csky: Debug and Ptrace GDB
  csky: SMP support
  csky: Misc headers
  clocksource: add C-SKY clocksource drivers
  irqchip: add C-SKY irqchip drivers

 arch/csky/Kconfig                        | 211 ++++++++++++
 arch/csky/Kconfig.debug                  |  29 ++
 arch/csky/Makefile                       |  92 ++++++
 arch/csky/abiv1/Makefile                 |   8 +
 arch/csky/abiv1/alignment.c              | 332 +++++++++++++++++++
 arch/csky/abiv1/bswapdi.c                |  18 +
 arch/csky/abiv1/bswapsi.c                |  15 +
 arch/csky/abiv1/cacheflush.c             |  51 +++
 arch/csky/abiv1/inc/abi/cacheflush.h     |  42 +++
 arch/csky/abiv1/inc/abi/ckmmu.h          |  80 +++++
 arch/csky/abiv1/inc/abi/entry.h          | 152 +++++++++
 arch/csky/abiv1/inc/abi/page.h           |  26 ++
 arch/csky/abiv1/inc/abi/pgtable-bits.h   |  36 ++
 arch/csky/abiv1/inc/abi/reg_ops.h        |  47 +++
 arch/csky/abiv1/inc/abi/regdef.h         |  15 +
 arch/csky/abiv1/inc/abi/tlb.h            |  11 +
 arch/csky/abiv1/inc/abi/vdso.h           |  17 +
 arch/csky/abiv1/memcpy.S                 | 344 +++++++++++++++++++
 arch/csky/abiv1/mmap.c                   |  65 ++++
 arch/csky/abiv2/Makefile                 |   4 +
 arch/csky/abiv2/cacheflush.c             |  55 ++++
 arch/csky/abiv2/fpu.c                    | 242 ++++++++++++++
 arch/csky/abiv2/inc/abi/cacheflush.h     |  38 +++
 arch/csky/abiv2/inc/abi/ckmmu.h          |  88 +++++
 arch/csky/abiv2/inc/abi/entry.h          | 149 +++++++++
 arch/csky/abiv2/inc/abi/fpu.h            | 219 ++++++++++++
 arch/csky/abiv2/inc/abi/page.h           |  14 +
 arch/csky/abiv2/inc/abi/pgtable-bits.h   |  36 ++
 arch/csky/abiv2/inc/abi/reg_ops.h        |  38 +++
 arch/csky/abiv2/inc/abi/regdef.h         |  15 +
 arch/csky/abiv2/inc/abi/tlb.h            |  12 +
 arch/csky/abiv2/inc/abi/vdso.h           |  18 +
 arch/csky/abiv2/memcpy.c                 |  43 +++
 arch/csky/boot/Makefile                  |  25 ++
 arch/csky/boot/dts/Makefile              |  14 +
 arch/csky/boot/dts/include/dt-bindings   |   1 +
 arch/csky/configs/gx66xx_defconfig       | 549 +++++++++++++++++++++++++++++++
 arch/csky/configs/qemu_ck807_defconfig   | 541 ++++++++++++++++++++++++++++++
 arch/csky/include/asm/Kbuild             |  72 ++++
 arch/csky/include/asm/addrspace.h        |  10 +
 arch/csky/include/asm/barrier.h          |  19 ++
 arch/csky/include/asm/bitops.h           | 277 ++++++++++++++++
 arch/csky/include/asm/cache.h            |  29 ++
 arch/csky/include/asm/cacheflush.h       |   9 +
 arch/csky/include/asm/checksum.h         |  77 +++++
 arch/csky/include/asm/cmpxchg.h          |  68 ++++
 arch/csky/include/asm/dma-mapping.h      |  13 +
 arch/csky/include/asm/elf.h              | 149 +++++++++
 arch/csky/include/asm/fixmap.h           |  65 ++++
 arch/csky/include/asm/highmem.h          |  50 +++
 arch/csky/include/asm/io.h               |  23 ++
 arch/csky/include/asm/irq.h              |  10 +
 arch/csky/include/asm/irqflags.h         |  49 +++
 arch/csky/include/asm/mmu.h              |  11 +
 arch/csky/include/asm/mmu_context.h      | 158 +++++++++
 arch/csky/include/asm/page.h             | 104 ++++++
 arch/csky/include/asm/pgalloc.h          | 108 ++++++
 arch/csky/include/asm/pgtable.h          | 301 +++++++++++++++++
 arch/csky/include/asm/processor.h        | 123 +++++++
 arch/csky/include/asm/reg_ops.h          |  16 +
 arch/csky/include/asm/segment.h          |  18 +
 arch/csky/include/asm/shmparam.h         |  10 +
 arch/csky/include/asm/smp.h              |  26 ++
 arch/csky/include/asm/spinlock.h         | 174 ++++++++++
 arch/csky/include/asm/spinlock_types.h   |  20 ++
 arch/csky/include/asm/string.h           |  19 ++
 arch/csky/include/asm/syscall.h          |  69 ++++
 arch/csky/include/asm/syscalls.h         |  14 +
 arch/csky/include/asm/thread_info.h      |  73 ++++
 arch/csky/include/asm/tlb.h              |  19 ++
 arch/csky/include/asm/tlbflush.h         |  22 ++
 arch/csky/include/asm/traps.h            |  39 +++
 arch/csky/include/asm/uaccess.h          | 397 ++++++++++++++++++++++
 arch/csky/include/asm/unistd.h           |   4 +
 arch/csky/include/asm/vdso.h             |  12 +
 arch/csky/include/uapi/asm/Kbuild        |  33 ++
 arch/csky/include/uapi/asm/byteorder.h   |  14 +
 arch/csky/include/uapi/asm/cachectl.h    |  13 +
 arch/csky/include/uapi/asm/ptrace.h      | 105 ++++++
 arch/csky/include/uapi/asm/sigcontext.h  |  13 +
 arch/csky/include/uapi/asm/unistd.h      |  63 ++++
 arch/csky/kernel/Makefile                |   8 +
 arch/csky/kernel/asm-offsets.c           |  85 +++++
 arch/csky/kernel/atomic.S                |  87 +++++
 arch/csky/kernel/cpu-probe.c             |  83 +++++
 arch/csky/kernel/cskyksyms.c             |  31 ++
 arch/csky/kernel/dumpstack.c             |  65 ++++
 arch/csky/kernel/entry.S                 | 407 +++++++++++++++++++++++
 arch/csky/kernel/head.S                  |  81 +++++
 arch/csky/kernel/irq.c                   |  31 ++
 arch/csky/kernel/module.c                |  82 +++++
 arch/csky/kernel/platform.c              |  18 +
 arch/csky/kernel/power.c                 |  31 ++
 arch/csky/kernel/process.c               | 134 ++++++++
 arch/csky/kernel/ptrace.c                | 288 ++++++++++++++++
 arch/csky/kernel/setup.c                 | 148 +++++++++
 arch/csky/kernel/signal.c                | 350 ++++++++++++++++++++
 arch/csky/kernel/smp.c                   | 256 ++++++++++++++
 arch/csky/kernel/syscall.c               |  63 ++++
 arch/csky/kernel/syscall_table.c         |  12 +
 arch/csky/kernel/time.c                  |  12 +
 arch/csky/kernel/traps.c                 | 167 ++++++++++
 arch/csky/kernel/vdso.c                  |  89 +++++
 arch/csky/kernel/vmlinux.lds.S           |  65 ++++
 arch/csky/lib/Makefile                   |   1 +
 arch/csky/lib/delay.c                    |  40 +++
 arch/csky/lib/memset.c                   |  38 +++
 arch/csky/lib/usercopy.c                 | 271 +++++++++++++++
 arch/csky/mm/Makefile                    |  13 +
 arch/csky/mm/cachev1.c                   | 132 ++++++++
 arch/csky/mm/cachev2.c                   |  97 ++++++
 arch/csky/mm/dma-mapping.c               | 216 ++++++++++++
 arch/csky/mm/fault.c                     | 223 +++++++++++++
 arch/csky/mm/highmem.c                   | 210 ++++++++++++
 arch/csky/mm/init.c                      | 122 +++++++
 arch/csky/mm/ioremap.c                   |  49 +++
 arch/csky/mm/syscache.c                  |  29 ++
 arch/csky/mm/tlb.c                       | 210 ++++++++++++
 drivers/clocksource/Makefile             |   1 +
 drivers/clocksource/timer-csky-v1.c      | 169 ++++++++++
 drivers/clocksource/timer-nationalchip.c | 165 ++++++++++
 drivers/irqchip/Makefile                 |   1 +
 drivers/irqchip/irq-csky-v1.c            | 126 +++++++
 drivers/irqchip/irq-csky-v2.c            | 191 +++++++++++
 drivers/irqchip/irq-nationalchip.c       | 131 ++++++++
 125 files changed, 11618 insertions(+)
 create mode 100644 arch/csky/Kconfig
 create mode 100644 arch/csky/Kconfig.debug
 create mode 100644 arch/csky/Makefile
 create mode 100644 arch/csky/abiv1/Makefile
 create mode 100644 arch/csky/abiv1/alignment.c
 create mode 100644 arch/csky/abiv1/bswapdi.c
 create mode 100644 arch/csky/abiv1/bswapsi.c
 create mode 100644 arch/csky/abiv1/cacheflush.c
 create mode 100644 arch/csky/abiv1/inc/abi/cacheflush.h
 create mode 100644 arch/csky/abiv1/inc/abi/ckmmu.h
 create mode 100644 arch/csky/abiv1/inc/abi/entry.h
 create mode 100644 arch/csky/abiv1/inc/abi/page.h
 create mode 100644 arch/csky/abiv1/inc/abi/pgtable-bits.h
 create mode 100644 arch/csky/abiv1/inc/abi/reg_ops.h
 create mode 100644 arch/csky/abiv1/inc/abi/regdef.h
 create mode 100644 arch/csky/abiv1/inc/abi/tlb.h
 create mode 100644 arch/csky/abiv1/inc/abi/vdso.h
 create mode 100644 arch/csky/abiv1/memcpy.S
 create mode 100644 arch/csky/abiv1/mmap.c
 create mode 100644 arch/csky/abiv2/Makefile
 create mode 100644 arch/csky/abiv2/cacheflush.c
 create mode 100644 arch/csky/abiv2/fpu.c
 create mode 100644 arch/csky/abiv2/inc/abi/cacheflush.h
 create mode 100644 arch/csky/abiv2/inc/abi/ckmmu.h
 create mode 100644 arch/csky/abiv2/inc/abi/entry.h
 create mode 100644 arch/csky/abiv2/inc/abi/fpu.h
 create mode 100644 arch/csky/abiv2/inc/abi/page.h
 create mode 100644 arch/csky/abiv2/inc/abi/pgtable-bits.h
 create mode 100644 arch/csky/abiv2/inc/abi/reg_ops.h
 create mode 100644 arch/csky/abiv2/inc/abi/regdef.h
 create mode 100644 arch/csky/abiv2/inc/abi/tlb.h
 create mode 100644 arch/csky/abiv2/inc/abi/vdso.h
 create mode 100644 arch/csky/abiv2/memcpy.c
 create mode 100644 arch/csky/boot/Makefile
 create mode 100644 arch/csky/boot/dts/Makefile
 create mode 120000 arch/csky/boot/dts/include/dt-bindings
 create mode 100644 arch/csky/configs/gx66xx_defconfig
 create mode 100644 arch/csky/configs/qemu_ck807_defconfig
 create mode 100644 arch/csky/include/asm/Kbuild
 create mode 100644 arch/csky/include/asm/addrspace.h
 create mode 100644 arch/csky/include/asm/barrier.h
 create mode 100644 arch/csky/include/asm/bitops.h
 create mode 100644 arch/csky/include/asm/cache.h
 create mode 100644 arch/csky/include/asm/cacheflush.h
 create mode 100644 arch/csky/include/asm/checksum.h
 create mode 100644 arch/csky/include/asm/cmpxchg.h
 create mode 100644 arch/csky/include/asm/dma-mapping.h
 create mode 100644 arch/csky/include/asm/elf.h
 create mode 100644 arch/csky/include/asm/fixmap.h
 create mode 100644 arch/csky/include/asm/highmem.h
 create mode 100644 arch/csky/include/asm/io.h
 create mode 100644 arch/csky/include/asm/irq.h
 create mode 100644 arch/csky/include/asm/irqflags.h
 create mode 100644 arch/csky/include/asm/mmu.h
 create mode 100644 arch/csky/include/asm/mmu_context.h
 create mode 100644 arch/csky/include/asm/page.h
 create mode 100644 arch/csky/include/asm/pgalloc.h
 create mode 100644 arch/csky/include/asm/pgtable.h
 create mode 100644 arch/csky/include/asm/processor.h
 create mode 100644 arch/csky/include/asm/reg_ops.h
 create mode 100644 arch/csky/include/asm/segment.h
 create mode 100644 arch/csky/include/asm/shmparam.h
 create mode 100644 arch/csky/include/asm/smp.h
 create mode 100644 arch/csky/include/asm/spinlock.h
 create mode 100644 arch/csky/include/asm/spinlock_types.h
 create mode 100644 arch/csky/include/asm/string.h
 create mode 100644 arch/csky/include/asm/syscall.h
 create mode 100644 arch/csky/include/asm/syscalls.h
 create mode 100644 arch/csky/include/asm/thread_info.h
 create mode 100644 arch/csky/include/asm/tlb.h
 create mode 100644 arch/csky/include/asm/tlbflush.h
 create mode 100644 arch/csky/include/asm/traps.h
 create mode 100644 arch/csky/include/asm/uaccess.h
 create mode 100644 arch/csky/include/asm/unistd.h
 create mode 100644 arch/csky/include/asm/vdso.h
 create mode 100644 arch/csky/include/uapi/asm/Kbuild
 create mode 100644 arch/csky/include/uapi/asm/byteorder.h
 create mode 100644 arch/csky/include/uapi/asm/cachectl.h
 create mode 100644 arch/csky/include/uapi/asm/ptrace.h
 create mode 100644 arch/csky/include/uapi/asm/sigcontext.h
 create mode 100644 arch/csky/include/uapi/asm/unistd.h
 create mode 100644 arch/csky/kernel/Makefile
 create mode 100644 arch/csky/kernel/asm-offsets.c
 create mode 100644 arch/csky/kernel/atomic.S
 create mode 100644 arch/csky/kernel/cpu-probe.c
 create mode 100644 arch/csky/kernel/cskyksyms.c
 create mode 100644 arch/csky/kernel/dumpstack.c
 create mode 100644 arch/csky/kernel/entry.S
 create mode 100644 arch/csky/kernel/head.S
 create mode 100644 arch/csky/kernel/irq.c
 create mode 100644 arch/csky/kernel/module.c
 create mode 100644 arch/csky/kernel/platform.c
 create mode 100644 arch/csky/kernel/power.c
 create mode 100644 arch/csky/kernel/process.c
 create mode 100644 arch/csky/kernel/ptrace.c
 create mode 100644 arch/csky/kernel/setup.c
 create mode 100644 arch/csky/kernel/signal.c
 create mode 100644 arch/csky/kernel/smp.c
 create mode 100644 arch/csky/kernel/syscall.c
 create mode 100644 arch/csky/kernel/syscall_table.c
 create mode 100644 arch/csky/kernel/time.c
 create mode 100644 arch/csky/kernel/traps.c
 create mode 100644 arch/csky/kernel/vdso.c
 create mode 100644 arch/csky/kernel/vmlinux.lds.S
 create mode 100644 arch/csky/lib/Makefile
 create mode 100644 arch/csky/lib/delay.c
 create mode 100644 arch/csky/lib/memset.c
 create mode 100644 arch/csky/lib/usercopy.c
 create mode 100644 arch/csky/mm/Makefile
 create mode 100644 arch/csky/mm/cachev1.c
 create mode 100644 arch/csky/mm/cachev2.c
 create mode 100644 arch/csky/mm/dma-mapping.c
 create mode 100644 arch/csky/mm/fault.c
 create mode 100644 arch/csky/mm/highmem.c
 create mode 100644 arch/csky/mm/init.c
 create mode 100644 arch/csky/mm/ioremap.c
 create mode 100644 arch/csky/mm/syscache.c
 create mode 100644 arch/csky/mm/tlb.c
 create mode 100644 drivers/clocksource/timer-csky-v1.c
 create mode 100644 drivers/clocksource/timer-nationalchip.c
 create mode 100644 drivers/irqchip/irq-csky-v1.c
 create mode 100644 drivers/irqchip/irq-csky-v2.c
 create mode 100644 drivers/irqchip/irq-nationalchip.c

-- 
2.7.4
