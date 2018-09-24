Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33572 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbeIXUhX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Sep 2018 16:37:23 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V5 00/30] C-SKY(csky) Linux Kernel Port
Date: Mon, 24 Sep 2018 22:34:25 +0800
Message-ID: <cover.1537789736.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, palmer@sifive.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20180924143425.4SW6ldR4FoN_WLvaFHcZAG7oTU1_qDGKpaUdZkNCnRQ@z>

This is the 5th version patchset to add the Linux kernel port for C-SKY(csky).
Since I misunderstood the linux-next. I made some discrete patches which made
review confusing. Now correct back to the whole patchset style.
Thanks to everyone who provided feedback on the previous versions.

This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
CPU cores and the patches are based on linux-4.19-rc3

There are two ABI versions with several CPU cores in this patchset:
  ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
  ABIv2: ck807 ck810 ck860 (16/32-bit variable length instruction, PIPT Cache,
	 SMP ...)

More information: http://en.c-sky.com

Here is the pre-built cross compiler for fast test from our CI:
https://gitlab.com/c-sky/buildroot/-/jobs/97941896/artifacts/file/output/images/csky_toolchain_csky_ck860_platform_defconfig_72371bf75a51f27ea59fc34eeaf236e06b75bf69.tar.xz

I'm from Hangzhou,China C-SKY Microsystems and responsible for C-SKY Linux
port. The development repo is https://gitlab.com/c-sky/csky-linux

We use buildroot as our CI-test enviornment. "LTP, Lmbench ..."
will be tested for every commit. See here for more details:
  https://gitlab.com/c-sky/buildroot/pipelines

You also can try C-SKY linux in a few steps with buildroot:
  $ git clone https://gitlab.com/c-sky/buildroot.git
  $ cd buildroot
  $ make qemu_csky_ck807f_4.18_glibc_defconfig
  $ make
It will download "linux glibc gcc binutils qemu busybox" source code and build
them into one image. How to run, See:
https://c-sky.gitlab.io/-/buildroot/-/jobs/95233371/artifacts/output/images/readme.txt

Any feedback is welcome.

Changes in v5:
 - remove redundant smp_mb operations in spinlock.h
 - add commit message for dt-bindings docs
 - add CPUHP_AP_CSKY_TIMER_STARTING in hotplug.h for csky_mptimer
 - add COMPILE_TEST for timer-gx6605s Kconfig
 - seperate csky two interrupt controllers with 2 patches
 - add MAINTAINERS patch for csky
 - move IPI_IRQ into csky_mptimer, fixup irq_mapping problem
 - coding convension

Changes in v4:
 - cleanup defconfig
 - use ksys_ in syscall.c
 - remove wrong comment in vdso.c
 - Use GENERIC_IRQ_MULTI_HANDLER
 - optimize the memset.c
 - fixup dts warnings
 - remove big-endian in byteorder.h

Changes in v3:
dc560f1 csky: change to EM_CSKY 252 for elf.h
2ac3ddf csky: remove gx6605s.dts
af00b8c csky: add defconfig and qemu.dts
6c87efb csky: remove the deprecate name.
f6dda39 csky: add dt-bindings doc.
d9f02a8 csky: remove KERNEL_VERSION in upstream branch
7bd663c csky: Use kernel/dma/noncoherent.c
1544c09 csky: bugfix emmc hang up LINS-976
e963271 csky: cleanup include/asm/Kbuild
cd267ba csky: remove CSKY_DEBUG_INFO
78950da csky: remove dcache invalid.
13fe51d csky: remove csum_ipv6_magic(), use generic one.
a7372db csky: bugfix CK810 access twice error.
1bb7c69 csky: bugfix add gcc asm memory for barrier.
5ea3257 csky: add -msoft-float instead of -mfloat-abi=soft.
38b037d csky: bugfix losing cache flush range.
ab5e8c4 csky: Add ticket-spinlock and qrwlock support.
c9aaec5 csky: rename cskyksyms.c to libgcc_ksyms.c
28c5e48 csky: avoid the MB on failure: trylock
f929c97 csky: bugfix idly4 may cause exception.
09dc496 csky: Use GENERIC_ASHLDI3/ASHRDI3 etc
6ecc99d csky: optimize smp boot code.
16f50df csky: asm/bug.h simple implement.
0ba532a csky: csky asm/atomic.h added.
df66947 csky: asm/compat.h added
275a06f csky: String operations optimization
4c021dd csky: ck860 SMP memory barrier optimize
fc39c66 csky: Add wait/doze/stop
d005144 csky: add GENERIC_ALLOCATOR
4a10074 csky: bugfix cma failed for highmem.
9f2ca70 csky: CMA supported :)
53791f4 csky: optimize csky_dma_alloc_nonatomic
974676e csky: optimize the cpuinfo printf.
2538669 csky: bugfix make headers_install error.
1158d0c csky: prevent hard-float and vdsp instructions.
dc3c856 csky: increase Normal Memory to 1GB
6ee5932 csky: bugfix qemu mmu couldn't support 0xffffe000
1d7dfb8 csky: csky_dma_alloc_atomic added.
caf6610 csky: restruct the fixmap memory layout.
5a17eaa csky: use -Wa,-mcpu=ckxxxfv to the as.
4d51829 csky: use Kconfig.hz.
f3f88fa csky: BUGFIX add -mcpu=ck860f support
6192fd1 csky: support ck860 fpu.
7aa5e01 csky: BUGFIX add smp_mb before ldex.
15758e2 csky: BUGFIX tlbi couldn't handle ASID in another CPU core.
d69640d csky: enable tlbi.vas to flush one tlb entry

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

Guo Ren (30):
  csky: Build infrastructure
  csky: defconfig
  csky: Kernel booting
  csky: Exception handling and mm-fault
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
  dt-bindings: csky CPU Bindings
  dt-bindings: Add vendor prefix for csky
  csky/dma: bugfix dma_sync_for_cpu/device
  csky: remove irq_mapping from smp.c
  irqchip: add C-SKY SMP interrupt controller
  dt-bindings: interrupt-controller: C-SKY SMP intc
  clocksource: add C-SKY SMP timer
  dt-bindings: timer: C-SKY Multi-processor timer
  MAINTAINERS: Add csky
  dt-bindings: interrupt-controller: C-SKY APB intc
  irqchip: add C-SKY APB bus interrupt controller
  dt-bindings: timer: gx6605s SOC timer
  clocksource: add gx6605s SOC system timer

 Documentation/devicetree/bindings/csky/cpus.txt    |  70 ++++
 .../interrupt-controller/csky,apb-intc.txt         |  62 ++++
 .../bindings/interrupt-controller/csky,mpintc.txt  |  40 +++
 .../bindings/timer/csky,gx6605s-timer.txt          |  42 +++
 .../devicetree/bindings/timer/csky,mptimer.txt     |  46 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |  16 +
 arch/csky/Kconfig                                  | 204 +++++++++++
 arch/csky/Kconfig.debug                            |   8 +
 arch/csky/Makefile                                 |  92 +++++
 arch/csky/abiv1/Makefile                           |   8 +
 arch/csky/abiv1/alignment.c                        | 332 +++++++++++++++++
 arch/csky/abiv1/bswapdi.c                          |  19 +
 arch/csky/abiv1/bswapsi.c                          |  15 +
 arch/csky/abiv1/cacheflush.c                       |  51 +++
 arch/csky/abiv1/inc/abi/cacheflush.h               |  43 +++
 arch/csky/abiv1/inc/abi/ckmmu.h                    |  75 ++++
 arch/csky/abiv1/inc/abi/entry.h                    | 160 +++++++++
 arch/csky/abiv1/inc/abi/page.h                     |  27 ++
 arch/csky/abiv1/inc/abi/pgtable-bits.h             |  37 ++
 arch/csky/abiv1/inc/abi/reg_ops.h                  |  27 ++
 arch/csky/abiv1/inc/abi/regdef.h                   |  26 ++
 arch/csky/abiv1/inc/abi/string.h                   |  13 +
 arch/csky/abiv1/inc/abi/tlb.h                      |  12 +
 arch/csky/abiv1/inc/abi/vdso.h                     |  18 +
 arch/csky/abiv1/memcpy.S                           | 345 ++++++++++++++++++
 arch/csky/abiv1/memset.c                           |  37 ++
 arch/csky/abiv1/mmap.c                             |  66 ++++
 arch/csky/abiv1/strksyms.c                         |   7 +
 arch/csky/abiv2/Makefile                           |  10 +
 arch/csky/abiv2/cacheflush.c                       |  59 +++
 arch/csky/abiv2/fpu.c                              | 281 +++++++++++++++
 arch/csky/abiv2/inc/abi/cacheflush.h               |  40 +++
 arch/csky/abiv2/inc/abi/ckmmu.h                    |  87 +++++
 arch/csky/abiv2/inc/abi/entry.h                    | 157 ++++++++
 arch/csky/abiv2/inc/abi/fpu.h                      |  66 ++++
 arch/csky/abiv2/inc/abi/page.h                     |  14 +
 arch/csky/abiv2/inc/abi/pgtable-bits.h             |  37 ++
 arch/csky/abiv2/inc/abi/reg_ops.h                  |  17 +
 arch/csky/abiv2/inc/abi/regdef.h                   |  26 ++
 arch/csky/abiv2/inc/abi/string.h                   |  28 ++
 arch/csky/abiv2/inc/abi/tlb.h                      |  13 +
 arch/csky/abiv2/inc/abi/vdso.h                     |  24 ++
 arch/csky/abiv2/memcmp.S                           | 152 ++++++++
 arch/csky/abiv2/memcpy.S                           | 110 ++++++
 arch/csky/abiv2/memcpy.c                           |  40 +++
 arch/csky/abiv2/memmove.S                          | 108 ++++++
 arch/csky/abiv2/memset.S                           |  83 +++++
 arch/csky/abiv2/strcmp.S                           | 168 +++++++++
 arch/csky/abiv2/strcpy.S                           | 123 +++++++
 arch/csky/abiv2/strksyms.c                         |  12 +
 arch/csky/abiv2/strlen.S                           |  97 +++++
 arch/csky/abiv2/sysdep.h                           |  30 ++
 arch/csky/boot/Makefile                            |  24 ++
 arch/csky/boot/dts/Makefile                        |  13 +
 arch/csky/boot/dts/include/dt-bindings             |   1 +
 arch/csky/configs/defconfig                        |  61 ++++
 arch/csky/include/asm/Kbuild                       |  69 ++++
 arch/csky/include/asm/addrspace.h                  |  10 +
 arch/csky/include/asm/atomic.h                     | 213 +++++++++++
 arch/csky/include/asm/barrier.h                    |  45 +++
 arch/csky/include/asm/bitops.h                     | 282 +++++++++++++++
 arch/csky/include/asm/bug.h                        |  26 ++
 arch/csky/include/asm/cache.h                      |  28 ++
 arch/csky/include/asm/cacheflush.h                 |   9 +
 arch/csky/include/asm/checksum.h                   |  55 +++
 arch/csky/include/asm/cmpxchg.h                    |  70 ++++
 arch/csky/include/asm/compat.h                     |  11 +
 arch/csky/include/asm/elf.h                        | 150 ++++++++
 arch/csky/include/asm/fixmap.h                     |  27 ++
 arch/csky/include/asm/highmem.h                    |  51 +++
 arch/csky/include/asm/io.h                         |  24 ++
 arch/csky/include/asm/irq.h                        |   9 +
 arch/csky/include/asm/irqflags.h                   |  50 +++
 arch/csky/include/asm/mmu.h                        |  12 +
 arch/csky/include/asm/mmu_context.h                | 149 ++++++++
 arch/csky/include/asm/page.h                       | 101 ++++++
 arch/csky/include/asm/pgalloc.h                    | 109 ++++++
 arch/csky/include/asm/pgtable.h                    | 300 ++++++++++++++++
 arch/csky/include/asm/processor.h                  | 121 +++++++
 arch/csky/include/asm/reg_ops.h                    |  22 ++
 arch/csky/include/asm/segment.h                    |  19 +
 arch/csky/include/asm/shmparam.h                   |  11 +
 arch/csky/include/asm/smp.h                        |  28 ++
 arch/csky/include/asm/spinlock.h                   | 272 ++++++++++++++
 arch/csky/include/asm/spinlock_types.h             |  35 ++
 arch/csky/include/asm/string.h                     |  13 +
 arch/csky/include/asm/switch_to.h                  |  36 ++
 arch/csky/include/asm/syscall.h                    |  69 ++++
 arch/csky/include/asm/syscalls.h                   |  15 +
 arch/csky/include/asm/thread_info.h                |  75 ++++
 arch/csky/include/asm/tlb.h                        |  20 ++
 arch/csky/include/asm/tlbflush.h                   |  23 ++
 arch/csky/include/asm/traps.h                      |  40 +++
 arch/csky/include/asm/uaccess.h                    | 399 +++++++++++++++++++++
 arch/csky/include/asm/unistd.h                     |   4 +
 arch/csky/include/asm/vdso.h                       |  13 +
 arch/csky/include/uapi/asm/Kbuild                  |  33 ++
 arch/csky/include/uapi/asm/byteorder.h             |   9 +
 arch/csky/include/uapi/asm/cachectl.h              |  14 +
 arch/csky/include/uapi/asm/ptrace.h                | 104 ++++++
 arch/csky/include/uapi/asm/sigcontext.h            |  14 +
 arch/csky/include/uapi/asm/unistd.h                |  10 +
 arch/csky/kernel/Makefile                          |   8 +
 arch/csky/kernel/asm-offsets.c                     |  86 +++++
 arch/csky/kernel/atomic.S                          |  87 +++++
 arch/csky/kernel/cpu-probe.c                       |  79 ++++
 arch/csky/kernel/dumpstack.c                       |  65 ++++
 arch/csky/kernel/entry.S                           | 397 ++++++++++++++++++++
 arch/csky/kernel/head.S                            |  78 ++++
 arch/csky/kernel/irq.c                             |  22 ++
 arch/csky/kernel/module.c                          |  83 +++++
 arch/csky/kernel/platform.c                        |  17 +
 arch/csky/kernel/power.c                           |  30 ++
 arch/csky/kernel/process.c                         | 135 +++++++
 arch/csky/kernel/ptrace.c                          | 318 ++++++++++++++++
 arch/csky/kernel/setup.c                           | 151 ++++++++
 arch/csky/kernel/signal.c                          | 351 ++++++++++++++++++
 arch/csky/kernel/smp.c                             | 245 +++++++++++++
 arch/csky/kernel/syscall.c                         |  42 +++
 arch/csky/kernel/syscall_table.c                   |  14 +
 arch/csky/kernel/time.c                            |  11 +
 arch/csky/kernel/traps.c                           | 168 +++++++++
 arch/csky/kernel/vdso.c                            |  85 +++++
 arch/csky/kernel/vmlinux.lds.S                     |  64 ++++
 arch/csky/lib/Makefile                             |   1 +
 arch/csky/lib/delay.c                              |  40 +++
 arch/csky/lib/usercopy.c                           | 271 ++++++++++++++
 arch/csky/mm/Makefile                              |  13 +
 arch/csky/mm/cachev1.c                             | 127 +++++++
 arch/csky/mm/cachev2.c                             |  80 +++++
 arch/csky/mm/dma-mapping.c                         | 255 +++++++++++++
 arch/csky/mm/fault.c                               | 221 ++++++++++++
 arch/csky/mm/highmem.c                             | 196 ++++++++++
 arch/csky/mm/init.c                                | 119 ++++++
 arch/csky/mm/ioremap.c                             |  49 +++
 arch/csky/mm/syscache.c                            |  29 ++
 arch/csky/mm/tlb.c                                 | 215 +++++++++++
 drivers/clocksource/Kconfig                        |  16 +
 drivers/clocksource/Makefile                       |   2 +
 drivers/clocksource/csky_mptimer.c                 | 176 +++++++++
 drivers/clocksource/timer-gx6605s.c                | 150 ++++++++
 drivers/irqchip/Kconfig                            |  16 +
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-csky-apb-intc.c                | 260 ++++++++++++++
 drivers/irqchip/irq-csky-mpintc.c                  | 195 ++++++++++
 include/linux/cpuhotplug.h                         |   1 +
 147 files changed, 11949 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/csky/cpus.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
 create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.txt
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
 create mode 100644 arch/csky/abiv1/inc/abi/string.h
 create mode 100644 arch/csky/abiv1/inc/abi/tlb.h
 create mode 100644 arch/csky/abiv1/inc/abi/vdso.h
 create mode 100644 arch/csky/abiv1/memcpy.S
 create mode 100644 arch/csky/abiv1/memset.c
 create mode 100644 arch/csky/abiv1/mmap.c
 create mode 100644 arch/csky/abiv1/strksyms.c
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
 create mode 100644 arch/csky/abiv2/inc/abi/string.h
 create mode 100644 arch/csky/abiv2/inc/abi/tlb.h
 create mode 100644 arch/csky/abiv2/inc/abi/vdso.h
 create mode 100644 arch/csky/abiv2/memcmp.S
 create mode 100644 arch/csky/abiv2/memcpy.S
 create mode 100644 arch/csky/abiv2/memcpy.c
 create mode 100644 arch/csky/abiv2/memmove.S
 create mode 100644 arch/csky/abiv2/memset.S
 create mode 100644 arch/csky/abiv2/strcmp.S
 create mode 100644 arch/csky/abiv2/strcpy.S
 create mode 100644 arch/csky/abiv2/strksyms.c
 create mode 100644 arch/csky/abiv2/strlen.S
 create mode 100644 arch/csky/abiv2/sysdep.h
 create mode 100644 arch/csky/boot/Makefile
 create mode 100644 arch/csky/boot/dts/Makefile
 create mode 120000 arch/csky/boot/dts/include/dt-bindings
 create mode 100644 arch/csky/configs/defconfig
 create mode 100644 arch/csky/include/asm/Kbuild
 create mode 100644 arch/csky/include/asm/addrspace.h
 create mode 100644 arch/csky/include/asm/atomic.h
 create mode 100644 arch/csky/include/asm/barrier.h
 create mode 100644 arch/csky/include/asm/bitops.h
 create mode 100644 arch/csky/include/asm/bug.h
 create mode 100644 arch/csky/include/asm/cache.h
 create mode 100644 arch/csky/include/asm/cacheflush.h
 create mode 100644 arch/csky/include/asm/checksum.h
 create mode 100644 arch/csky/include/asm/cmpxchg.h
 create mode 100644 arch/csky/include/asm/compat.h
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
 create mode 100644 arch/csky/include/asm/switch_to.h
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
 create mode 100644 drivers/clocksource/csky_mptimer.c
 create mode 100644 drivers/clocksource/timer-gx6605s.c
 create mode 100644 drivers/irqchip/irq-csky-apb-intc.c
 create mode 100644 drivers/irqchip/irq-csky-mpintc.c

-- 
2.7.4
