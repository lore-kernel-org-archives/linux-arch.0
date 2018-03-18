From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 00/19] C-SKY(csky) Linux Kernel Port
Date: Mon, 19 Mar 2018 03:51:22 +0800
Message-ID: <cover.1521399976.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
CPU cores and the patches are based on linux-4.16-rc5.

There are two ABI versions with several CPU cores in this patchset:
  ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
  ABIv2: ck807 ck810 (16/32-bit variable length instruction, PIPT Cache ...)

More information: http://en.c-sky.com

I'm from Hangzhou,China C-SKY Microsystems and responsible for C-SKY Linux
port. My development repo is github.com/c-sky/csky-linux and use buildroot
as our CI-test enviornment. "LTP, Lmbench, uclibc-ng-test ..." will be tested
for every commit. See here for more details:
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

It's my first patchset to linux and any feedback is welcome :)

Guo Ren (19):
  csky: Kernel booting
  csky: Exception handling and syscall
  csky: Cache and TLB routines
  csky: MMU and page talbe management
  csky: Process management
  csky: IRQ handling
  csky: Atomic operations
  csky: ELF and module probe
  csky: VDSO and rt_sigreturn
  csky: Signal handling
  csky: Library functions
  csky: Debug and Ptrace GDB
  csky: User access
  csky: Misc headers
  csky: Build infrastructure
  csky: Device tree
  csky: defconfig
  clocksource: add timer-nationalchip.c
  irqchip: add irq-nationalchip.c and irq-csky.c

 arch/csky/Kconfig                        | 203 ++++++++++++
 arch/csky/Kconfig.debug                  |  22 ++
 arch/csky/Makefile                       |  92 ++++++
 arch/csky/abiv1/Makefile                 |   8 +
 arch/csky/abiv1/inc/abi/cacheflush.h     |  40 +++
 arch/csky/abiv1/inc/abi/ckmmu.h          | 140 ++++++++
 arch/csky/abiv1/inc/abi/entry.h          | 171 ++++++++++
 arch/csky/abiv1/inc/abi/page.h           |  26 ++
 arch/csky/abiv1/inc/abi/pgtable-bits.h   |  36 ++
 arch/csky/abiv1/inc/abi/reg_ops.h        |  79 +++++
 arch/csky/abiv1/inc/abi/regdef.h         |  27 ++
 arch/csky/abiv1/inc/abi/vdso.h           |  19 ++
 arch/csky/abiv1/src/alignment.c          | 513 +++++++++++++++++++++++++++++
 arch/csky/abiv1/src/bswapdi.c            |  18 +
 arch/csky/abiv1/src/bswapsi.c            |  15 +
 arch/csky/abiv1/src/cacheflush.c         |  32 ++
 arch/csky/abiv1/src/memcpy.S             | 344 +++++++++++++++++++
 arch/csky/abiv1/src/mmap.c               |  65 ++++
 arch/csky/abiv2/Makefile                 |   3 +
 arch/csky/abiv2/inc/abi/cacheflush.h     |   9 +
 arch/csky/abiv2/inc/abi/ckmmu.h          | 126 +++++++
 arch/csky/abiv2/inc/abi/entry.h          | 154 +++++++++
 arch/csky/abiv2/inc/abi/fpu.h            | 296 +++++++++++++++++
 arch/csky/abiv2/inc/abi/page.h           |  20 ++
 arch/csky/abiv2/inc/abi/pgtable-bits.h   |  36 ++
 arch/csky/abiv2/inc/abi/reg_ops.h        |  86 +++++
 arch/csky/abiv2/inc/abi/regdef.h         |  28 ++
 arch/csky/abiv2/inc/abi/vdso.h           |  18 +
 arch/csky/abiv2/src/fpu.c                | 312 ++++++++++++++++++
 arch/csky/abiv2/src/memcpy.c             |  43 +++
 arch/csky/boot/Makefile                  |  25 ++
 arch/csky/boot/dts/Makefile              |  14 +
 arch/csky/boot/dts/gx6605s.dts           | 159 +++++++++
 arch/csky/boot/dts/include/dt-bindings   |   1 +
 arch/csky/boot/dts/qemu.dts              |  87 +++++
 arch/csky/configs/gx66xx_defconfig       | 549 +++++++++++++++++++++++++++++++
 arch/csky/configs/qemu_ck807_defconfig   | 541 ++++++++++++++++++++++++++++++
 arch/csky/include/asm/Kbuild             |  71 ++++
 arch/csky/include/asm/addrspace.h        |  10 +
 arch/csky/include/asm/barrier.h          |  14 +
 arch/csky/include/asm/bitops.h           |  83 +++++
 arch/csky/include/asm/cache.h            |  32 ++
 arch/csky/include/asm/cacheflush.h       |   9 +
 arch/csky/include/asm/checksum.h         |  77 +++++
 arch/csky/include/asm/dma-mapping.h      |  17 +
 arch/csky/include/asm/elf.h              | 151 +++++++++
 arch/csky/include/asm/fixmap.h           |  65 ++++
 arch/csky/include/asm/highmem.h          |  50 +++
 arch/csky/include/asm/io.h               |  23 ++
 arch/csky/include/asm/irq.h              |  12 +
 arch/csky/include/asm/irqflags.h         |  55 ++++
 arch/csky/include/asm/mmu.h              |  11 +
 arch/csky/include/asm/mmu_context.h      | 140 ++++++++
 arch/csky/include/asm/page.h             | 108 ++++++
 arch/csky/include/asm/pgalloc.h          | 113 +++++++
 arch/csky/include/asm/pgtable.h          | 309 +++++++++++++++++
 arch/csky/include/asm/processor.h        | 140 ++++++++
 arch/csky/include/asm/segment.h          |  18 +
 arch/csky/include/asm/shmparam.h         |  10 +
 arch/csky/include/asm/string.h           |  19 ++
 arch/csky/include/asm/syscalls.h         |  14 +
 arch/csky/include/asm/thread_info.h      |  77 +++++
 arch/csky/include/asm/tlb.h              |  24 ++
 arch/csky/include/asm/tlbflush.h         |  22 ++
 arch/csky/include/asm/traps.h            |  39 +++
 arch/csky/include/asm/uaccess.h          | 408 +++++++++++++++++++++++
 arch/csky/include/asm/unistd.h           |   4 +
 arch/csky/include/asm/user.h             | 102 ++++++
 arch/csky/include/asm/vdso.h             |  12 +
 arch/csky/include/uapi/asm/Kbuild        |  30 ++
 arch/csky/include/uapi/asm/byteorder.h   |  14 +
 arch/csky/include/uapi/asm/cachectl.h    |  13 +
 arch/csky/include/uapi/asm/fcntl.h       |  13 +
 arch/csky/include/uapi/asm/ptrace.h      |  97 ++++++
 arch/csky/include/uapi/asm/sigcontext.h  |  33 ++
 arch/csky/include/uapi/asm/signal.h      | 164 +++++++++
 arch/csky/include/uapi/asm/stat.h        |  86 +++++
 arch/csky/include/uapi/asm/unistd.h      | 100 ++++++
 arch/csky/kernel/Makefile                |   8 +
 arch/csky/kernel/asm-offsets.c           |  86 +++++
 arch/csky/kernel/atomic.S                |  55 ++++
 arch/csky/kernel/cpu-probe.c             |  63 ++++
 arch/csky/kernel/cskyksyms.c             |  31 ++
 arch/csky/kernel/dumpstack.c             |  65 ++++
 arch/csky/kernel/entry.S                 | 408 +++++++++++++++++++++++
 arch/csky/kernel/head.S                  |  20 ++
 arch/csky/kernel/irq.c                   |  41 +++
 arch/csky/kernel/module.c                | 130 ++++++++
 arch/csky/kernel/platform.c              |  18 +
 arch/csky/kernel/power.c                 |  31 ++
 arch/csky/kernel/process.c               | 147 +++++++++
 arch/csky/kernel/ptrace.c                | 339 +++++++++++++++++++
 arch/csky/kernel/setup.c                 | 157 +++++++++
 arch/csky/kernel/signal.c                | 379 +++++++++++++++++++++
 arch/csky/kernel/syscall.c               |  65 ++++
 arch/csky/kernel/syscall_table.c         |  12 +
 arch/csky/kernel/time.c                  |  15 +
 arch/csky/kernel/traps.c                 | 152 +++++++++
 arch/csky/kernel/vdso.c                  |  89 +++++
 arch/csky/kernel/vmlinux.lds.S           |  67 ++++
 arch/csky/lib/Makefile                   |   1 +
 arch/csky/lib/delay.c                    |  40 +++
 arch/csky/lib/memset.c                   |  38 +++
 arch/csky/lib/usercopy.c                 | 271 +++++++++++++++
 arch/csky/mm/Makefile                    |  13 +
 arch/csky/mm/cachev1.c                   | 146 ++++++++
 arch/csky/mm/cachev2.c                   |  90 +++++
 arch/csky/mm/dma-mapping.c               | 250 ++++++++++++++
 arch/csky/mm/fault.c                     | 246 ++++++++++++++
 arch/csky/mm/highmem.c                   | 210 ++++++++++++
 arch/csky/mm/init.c                      | 101 ++++++
 arch/csky/mm/ioremap.c                   |  49 +++
 arch/csky/mm/syscache.c                  |  50 +++
 arch/csky/mm/tlb.c                       | 207 ++++++++++++
 arch/csky/oprofile/Makefile              |  13 +
 arch/csky/oprofile/init.c                |  16 +
 drivers/clocksource/Makefile             |   1 +
 drivers/clocksource/timer-nationalchip.c | 149 +++++++++
 drivers/irqchip/Makefile                 |   1 +
 drivers/irqchip/irq-csky.c               | 151 +++++++++
 drivers/irqchip/irq-nationalchip.c       | 196 +++++++++++
 121 files changed, 11763 insertions(+)
 create mode 100644 arch/csky/Kconfig
 create mode 100644 arch/csky/Kconfig.debug
 create mode 100644 arch/csky/Makefile
 create mode 100644 arch/csky/abiv1/Makefile
 create mode 100644 arch/csky/abiv1/inc/abi/cacheflush.h
 create mode 100644 arch/csky/abiv1/inc/abi/ckmmu.h
 create mode 100644 arch/csky/abiv1/inc/abi/entry.h
 create mode 100644 arch/csky/abiv1/inc/abi/page.h
 create mode 100644 arch/csky/abiv1/inc/abi/pgtable-bits.h
 create mode 100644 arch/csky/abiv1/inc/abi/reg_ops.h
 create mode 100644 arch/csky/abiv1/inc/abi/regdef.h
 create mode 100644 arch/csky/abiv1/inc/abi/vdso.h
 create mode 100644 arch/csky/abiv1/src/alignment.c
 create mode 100644 arch/csky/abiv1/src/bswapdi.c
 create mode 100644 arch/csky/abiv1/src/bswapsi.c
 create mode 100644 arch/csky/abiv1/src/cacheflush.c
 create mode 100644 arch/csky/abiv1/src/memcpy.S
 create mode 100644 arch/csky/abiv1/src/mmap.c
 create mode 100644 arch/csky/abiv2/Makefile
 create mode 100644 arch/csky/abiv2/inc/abi/cacheflush.h
 create mode 100644 arch/csky/abiv2/inc/abi/ckmmu.h
 create mode 100644 arch/csky/abiv2/inc/abi/entry.h
 create mode 100644 arch/csky/abiv2/inc/abi/fpu.h
 create mode 100644 arch/csky/abiv2/inc/abi/page.h
 create mode 100644 arch/csky/abiv2/inc/abi/pgtable-bits.h
 create mode 100644 arch/csky/abiv2/inc/abi/reg_ops.h
 create mode 100644 arch/csky/abiv2/inc/abi/regdef.h
 create mode 100644 arch/csky/abiv2/inc/abi/vdso.h
 create mode 100644 arch/csky/abiv2/src/fpu.c
 create mode 100644 arch/csky/abiv2/src/memcpy.c
 create mode 100644 arch/csky/boot/Makefile
 create mode 100644 arch/csky/boot/dts/Makefile
 create mode 100644 arch/csky/boot/dts/gx6605s.dts
 create mode 120000 arch/csky/boot/dts/include/dt-bindings
 create mode 100644 arch/csky/boot/dts/qemu.dts
 create mode 100644 arch/csky/configs/gx66xx_defconfig
 create mode 100644 arch/csky/configs/qemu_ck807_defconfig
 create mode 100644 arch/csky/include/asm/Kbuild
 create mode 100644 arch/csky/include/asm/addrspace.h
 create mode 100644 arch/csky/include/asm/barrier.h
 create mode 100644 arch/csky/include/asm/bitops.h
 create mode 100644 arch/csky/include/asm/cache.h
 create mode 100644 arch/csky/include/asm/cacheflush.h
 create mode 100644 arch/csky/include/asm/checksum.h
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
 create mode 100644 arch/csky/include/asm/segment.h
 create mode 100644 arch/csky/include/asm/shmparam.h
 create mode 100644 arch/csky/include/asm/string.h
 create mode 100644 arch/csky/include/asm/syscalls.h
 create mode 100644 arch/csky/include/asm/thread_info.h
 create mode 100644 arch/csky/include/asm/tlb.h
 create mode 100644 arch/csky/include/asm/tlbflush.h
 create mode 100644 arch/csky/include/asm/traps.h
 create mode 100644 arch/csky/include/asm/uaccess.h
 create mode 100644 arch/csky/include/asm/unistd.h
 create mode 100644 arch/csky/include/asm/user.h
 create mode 100644 arch/csky/include/asm/vdso.h
 create mode 100644 arch/csky/include/uapi/asm/Kbuild
 create mode 100644 arch/csky/include/uapi/asm/byteorder.h
 create mode 100644 arch/csky/include/uapi/asm/cachectl.h
 create mode 100644 arch/csky/include/uapi/asm/fcntl.h
 create mode 100644 arch/csky/include/uapi/asm/ptrace.h
 create mode 100644 arch/csky/include/uapi/asm/sigcontext.h
 create mode 100644 arch/csky/include/uapi/asm/signal.h
 create mode 100644 arch/csky/include/uapi/asm/stat.h
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
 create mode 100644 arch/csky/oprofile/Makefile
 create mode 100644 arch/csky/oprofile/init.c
 create mode 100644 drivers/clocksource/timer-nationalchip.c
 create mode 100644 drivers/irqchip/irq-csky.c
 create mode 100644 drivers/irqchip/irq-nationalchip.c

-- 
2.7.4
