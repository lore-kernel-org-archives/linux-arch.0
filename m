From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 01/19] csky: Build infrastructure
Date: Mon,  2 Jul 2018 01:30:04 +0800
Message-ID: <a26901aab87306c389e656a3ef200adfbc5195c0.1530465325.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/Kconfig                      | 211 +++++++++++++++++++++++++++++++++
 arch/csky/Kconfig.debug                |  29 +++++
 arch/csky/Makefile                     |  92 ++++++++++++++
 arch/csky/abiv1/Makefile               |   8 ++
 arch/csky/abiv2/Makefile               |   4 +
 arch/csky/boot/Makefile                |  25 ++++
 arch/csky/boot/dts/Makefile            |  14 +++
 arch/csky/boot/dts/include/dt-bindings |   1 +
 arch/csky/include/asm/Kbuild           |  72 +++++++++++
 arch/csky/include/uapi/asm/Kbuild      |  33 ++++++
 arch/csky/kernel/Makefile              |   8 ++
 arch/csky/lib/Makefile                 |   1 +
 arch/csky/mm/Makefile                  |  13 ++
 13 files changed, 511 insertions(+)
 create mode 100644 arch/csky/Kconfig
 create mode 100644 arch/csky/Kconfig.debug
 create mode 100644 arch/csky/Makefile
 create mode 100644 arch/csky/abiv1/Makefile
 create mode 100644 arch/csky/abiv2/Makefile
 create mode 100644 arch/csky/boot/Makefile
 create mode 100644 arch/csky/boot/dts/Makefile
 create mode 120000 arch/csky/boot/dts/include/dt-bindings
 create mode 100644 arch/csky/include/asm/Kbuild
 create mode 100644 arch/csky/include/uapi/asm/Kbuild
 create mode 100644 arch/csky/kernel/Makefile
 create mode 100644 arch/csky/lib/Makefile
 create mode 100644 arch/csky/mm/Makefile

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
new file mode 100644
index 0000000..cfeb312
--- /dev/null
+++ b/arch/csky/Kconfig
@@ -0,0 +1,211 @@
+config CSKY
+	bool
+	default y
+	select ARCH_USE_BUILTIN_BSWAP
+	select COMMON_CLK
+	select CLKSRC_MMIO
+	select CLKSRC_OF
+	select IRQ_DOMAIN
+	select HANDLE_DOMAIN_IRQ
+	select DW_APB_TIMER_OF
+	select GENERIC_ATOMIC64
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_CPU_DEVICES
+	select GENERIC_IRQ_CHIP
+	select GENERIC_IRQ_PROBE
+	select GENERIC_IRQ_SHOW
+	select GENERIC_SCHED_CLOCK
+	select GENERIC_SMP_IDLE_THREAD
+	select HAVE_ARCH_TRACEHOOK
+	select HAVE_GENERIC_DMA_COHERENT
+	select HAVE_KERNEL_GZIP
+	select HAVE_KERNEL_LZO
+	select HAVE_KERNEL_LZMA
+	select HAVE_PERF_EVENTS
+	select HAVE_C_RECORDMCOUNT
+	select HAVE_KPROBES
+	select HAVE_KRETPROBES
+	select HAVE_DMA_API_DEBUG
+	select HAVE_MEMBLOCK
+	select MAY_HAVE_SPARSE_IRQ
+	select MODULES_USE_ELF_RELA if MODULES
+	select NO_BOOTMEM
+	select OF
+	select OF_EARLY_FLATTREE
+	select OF_RESERVED_MEM
+	select PERF_USE_VMALLOC
+	select RTC_LIB
+	select TIMER_OF
+	select USB_ARCH_HAS_EHCI
+	select USB_ARCH_HAS_OHCI
+
+config CPU_HAS_CACHEV2
+	bool
+
+config CPU_HAS_HILO
+	bool
+
+config CPU_HAS_TLBI
+	bool
+
+config CPU_HAS_LDSTEX
+	bool
+	help
+	  For SMP cpu need "ldex&stex" instrcutions to keep atomic.
+
+config CPU_NEED_TLBSYNC
+	bool
+
+config CPU_NEED_SOFTALIGN
+	bool
+
+config CPU_NO_USER_BKPT
+	bool
+	help
+	  For abiv2 we couldn't use "trap 1" as user space bkpt in gdbserver, because
+	  abiv2 is 16/32bit instruction set and "trap 1" is 32bit.
+	  So we need a 16bit instruction as user space bkpt, and it will cause a illegal
+	  instruction exception.
+	  In kernel we parse the *regs->pc to determine wether send SIGTRAP or not.
+
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
+config HZ
+	int
+	default 100
+
+config GENERIC_CSUM
+	bool
+	default y
+
+config GENERIC_HWEIGHT
+	bool
+	default y
+
+config MMU
+	bool
+	default y
+
+config RWSEM_GENERIC_SPINLOCK
+	bool
+	default y
+
+config TIME_LOW_RES
+	bool
+	default y
+
+config TRACE_IRQFLAGS_SUPPORT
+	bool
+	default y
+
+source "init/Kconfig"
+
+source "kernel/Kconfig.freezer"
+
+menu "Processor type and features"
+
+comment "Processor type"
+
+choice
+	prompt "CPU MODEL"
+	default CPU_CK610
+
+config CPU_CK610
+	bool "CSKY CPU ck610"
+	select CPU_NEED_TLBSYNC
+	select CPU_NEED_SOFTALIGN
+	select CPU_NO_USER_BKPT
+
+config CPU_CK810
+	bool "CSKY CPU ck810"
+	select CPU_HAS_HILO
+	select CPU_NEED_TLBSYNC
+
+config CPU_CK807
+	bool "CSKY CPU ck807"
+	select CPU_HAS_HILO
+
+config CPU_CK860
+	bool "CSKY CPU ck860"
+	select CPU_HAS_TLBI
+	select CPU_HAS_CACHEV2
+	select CPU_HAS_LDSTEX
+endchoice
+
+config CPU_TLB_SIZE
+	int
+	default "128"	if(CPU_CK610 || CPU_CK807 || CPU_CK810)
+	default "1024"	if(CPU_CK860)
+
+config CPU_ASID_BITS
+	int
+	default "8"	if(CPU_CK610 || CPU_CK807 || CPU_CK810)
+	default "12"	if(CPU_CK860)
+
+config L1_CACHE_SHIFT
+	int
+	default "4"	if(CPU_CK610)
+	default "5"	if(CPU_CK807 || CPU_CK810)
+	default "6"	if(CPU_CK860)
+
+config HIGHMEM
+	bool "High Memory Support"
+	depends on !CPU_CK610
+	default y
+
+menuconfig CPU_HAS_FPU
+	bool "CPU has FPU coprocessor"
+	depends on CPU_CK807 || CPU_CK810 || CPU_CK860
+
+menuconfig CPU_HAS_TEE
+	bool "CPU has Trusted Execution Environment"
+	depends on CPU_CK810
+
+config SMP
+	bool "Symmetric Multi-Processing (SMP) support for C-SKY"
+	depends on CPU_CK860
+	default n
+
+config NR_CPUS
+	int "Maximum number of CPUs (2-32)"
+	range 2 32
+	depends on SMP
+	default "4"
+
+comment "*****System type*****"
+
+config RAM_BASE
+	hex "It must be the same with the memory section in your dts"
+	default 0x0
+endmenu
+
+menu "Power management options"
+
+source "kernel/power/Kconfig"
+
+config ARCH_SUSPEND_POSSIBLE
+	bool
+	default y
+endmenu
+
+source "mm/Kconfig"
+
+source "fs/Kconfig.binfmt"
+
+source "kernel/Kconfig.preempt"
+
+source "net/Kconfig"
+
+source "drivers/Kconfig"
+
+source "fs/Kconfig"
+
+source "arch/csky/Kconfig.debug"
+
+source "security/Kconfig"
+
+source "crypto/Kconfig"
+
+source "lib/Kconfig"
diff --git a/arch/csky/Kconfig.debug b/arch/csky/Kconfig.debug
new file mode 100644
index 0000000..6978702
--- /dev/null
+++ b/arch/csky/Kconfig.debug
@@ -0,0 +1,29 @@
+menu "Kernel hacking"
+
+menu "C-SKY Debug Options"
+config CSKY_DEBUG_INFO
+	bool "Compile the kernel with debug info, just add -g"
+	depends on !DEBUG_INFO
+	help
+	  DEBUG_INFO and COMPILE_TEST is conflict, so we provide
+	  another way to support -g.
+	  Some drivers eg: DW_MMC need COMPILE_TEST for new cpu
+	  arch :(
+
+config CSKY_VECIRQ_LEGENCY
+	bool "Use legency IRQ vector for interrupt, it's for SOC bugfix."
+	help
+	  It's a deprecated method for arch/csky. Don't use it, unless your
+	  SOC has bug.
+
+config CSKY_BUILTIN_DTB
+	bool "Use kernel builtin dtb"
+
+config CSKY_BUILTIN_DTB_NAME
+	string "kernel builtin dtb name"
+	depends on CSKY_BUILTIN_DTB
+endmenu
+
+source "lib/Kconfig.debug"
+
+endmenu
diff --git a/arch/csky/Makefile b/arch/csky/Makefile
new file mode 100644
index 0000000..c297324
--- /dev/null
+++ b/arch/csky/Makefile
@@ -0,0 +1,92 @@
+OBJCOPYFLAGS	:=-O binary
+GZFLAGS		:=-9
+
+ifdef CONFIG_CPU_HAS_FPU
+FPUEXT = f
+endif
+
+ifdef CONFIG_CPU_HAS_TEE
+TEEEXT = t
+endif
+
+ifdef CONFIG_CPU_CK610
+CPUTYPE	= ck610
+CSKYABI	= abiv1
+endif
+
+ifdef CONFIG_CPU_CK810
+CPUTYPE = ck810$(FPUEXT)$(TEEEXT)
+CSKYABI	= abiv2
+endif
+
+ifdef CONFIG_CPU_CK807
+CPUTYPE = ck807$(FPUEXT)$(TEEEXT)
+CSKYABI	= abiv2
+endif
+
+ifdef CONFIG_CPU_CK860
+CPUTYPE = ck860$(FPUEXT)$(TEEEXT)
+CSKYABI	= abiv2
+endif
+
+ifneq ($(CSKYABI),)
+KBUILD_CFLAGS += -mcpu=$(CPUTYPE)
+KBUILD_CFLAGS += -DCSKYCPU_DEF_NAME=\"$(CPUTYPE)\"
+endif
+
+KBUILD_CFLAGS += -pipe
+ifeq ($(CSKYABI),abiv2)
+KBUILD_CFLAGS += -mno-stack-size
+endif
+
+ifeq ($(CONFIG_CSKY_DEBUG_INFO),y)
+KBUILD_CFLAGS += -g
+endif
+
+abidirs := $(patsubst %,arch/csky/%/,$(CSKYABI))
+
+KBUILD_CFLAGS += $(patsubst %,-I$(srctree)/%inc,$(abidirs))
+
+KBUILD_CPPFLAGS += -mlittle-endian
+LDFLAGS += -EL
+
+KBUILD_AFLAGS += $(KBUILD_CFLAGS)
+
+head-y := arch/csky/kernel/head.o
+
+core-y += arch/csky/kernel/
+core-y += arch/csky/mm/
+core-y += arch/csky/$(CSKYABI)/
+
+libs-y += arch/csky/lib/ \
+	$(shell $(CC) $(KBUILD_CFLAGS) $(KCFLAGS) -print-libgcc-file-name)
+
+ifdef CONFIG_CSKY_BUILTIN_DTB
+core-y += arch/csky/boot/dts/
+endif
+
+all: zImage
+
+boot := arch/csky/boot
+
+dtbs: scripts
+	$(Q)$(MAKE) $(build)=$(boot)/dts
+
+%.dtb %.dtb.S %.dtb.o: scripts
+	$(Q)$(MAKE) $(build)=$(boot)/dts $(boot)/dts/$@
+
+zImage Image uImage: vmlinux dtbs
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+
+archmrproper:
+
+archclean:
+	$(Q)$(MAKE) $(clean)=$(boot)
+	rm -rf arch/csky/include/generated
+
+define archhelp
+  echo  '* zImage       - Compressed kernel image (arch/$(ARCH)/boot/zImage)'
+  echo  '  Image        - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
+  echo  '  uImage       - U-Boot wrapped zImage'
+endef
+
diff --git a/arch/csky/abiv1/Makefile b/arch/csky/abiv1/Makefile
new file mode 100644
index 0000000..c63c6d2
--- /dev/null
+++ b/arch/csky/abiv1/Makefile
@@ -0,0 +1,8 @@
+obj-y +=	bswapdi.o
+obj-y +=	bswapsi.o
+obj-y +=	cacheflush.o
+obj-y +=	memcpy.o
+obj-y +=	mmap.o
+
+obj-$(CONFIG_CPU_NEED_SOFTALIGN) +=	alignment.o
+
diff --git a/arch/csky/abiv2/Makefile b/arch/csky/abiv2/Makefile
new file mode 100644
index 0000000..c90d0fe
--- /dev/null
+++ b/arch/csky/abiv2/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o
+obj-y				+= memcpy.o
+obj-y				+= cacheflush.o
+
diff --git a/arch/csky/boot/Makefile b/arch/csky/boot/Makefile
new file mode 100644
index 0000000..c3301a8
--- /dev/null
+++ b/arch/csky/boot/Makefile
@@ -0,0 +1,25 @@
+targets := Image zImage uImage
+targets += $(dtb-y)
+
+$(obj)/Image: vmlinux FORCE
+	$(call if_changed,objcopy)
+	@echo '  Kernel: $@ is ready'
+
+compress-$(CONFIG_KERNEL_GZIP) = gzip
+compress-$(CONFIG_KERNEL_LZO)  = lzo
+compress-$(CONFIG_KERNEL_LZMA) = lzma
+compress-$(CONFIG_KERNEL_XZ)   = xzkern
+compress-$(CONFIG_KERNEL_LZ4)  = lz4
+
+$(obj)/zImage:  $(obj)/Image FORCE
+	$(call if_changed,$(compress-y))
+	@echo '  Kernel: $@ is ready'
+
+UIMAGE_ARCH		= sandbox
+UIMAGE_COMPRESSION	= $(compress-y)
+UIMAGE_LOADADDR		= $(shell $(NM) vmlinux | awk '$$NF == "_start" {print $$1}')
+
+$(obj)/uImage: $(obj)/zImage
+	$(call if_changed,uimage)
+	@echo 'Image: $@ is ready'
+
diff --git a/arch/csky/boot/dts/Makefile b/arch/csky/boot/dts/Makefile
new file mode 100644
index 0000000..9afc954
--- /dev/null
+++ b/arch/csky/boot/dts/Makefile
@@ -0,0 +1,14 @@
+dtstree	:= $(srctree)/$(src)
+
+ifdef CONFIG_CSKY_BUILTIN_DTB
+builtindtb-y := $(patsubst "%",%,$(CONFIG_CSKY_BUILTIN_DTB_NAME))
+dtb-y += $(builtindtb-y).dtb
+obj-y += $(builtindtb-y).dtb.o
+.SECONDARY: $(obj)/$(builtindtb-y).dtb.S
+else
+dtb-y := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
+endif
+
+always += $(dtb-y)
+clean-files += *.dtb *.dtb.S
+
diff --git a/arch/csky/boot/dts/include/dt-bindings b/arch/csky/boot/dts/include/dt-bindings
new file mode 120000
index 0000000..08c00e4
--- /dev/null
+++ b/arch/csky/boot/dts/include/dt-bindings
@@ -0,0 +1 @@
+../../../../../include/dt-bindings
\ No newline at end of file
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
new file mode 100644
index 0000000..5de6519
--- /dev/null
+++ b/arch/csky/include/asm/Kbuild
@@ -0,0 +1,72 @@
+generic-y += asm-offsets.h
+generic-y += atomic.h
+generic-y += auxvec.h
+generic-y += bitsperlong.h
+generic-y += bug.h
+generic-y += bugs.h
+generic-y += clkdev.h
+generic-y += cputime.h
+generic-y += current.h
+generic-y += delay.h
+generic-y += device.h
+generic-y += div64.h
+generic-y += dma.h
+generic-y += emergency-restart.h
+generic-y += errno.h
+generic-y += exec.h
+generic-y += fb.h
+generic-y += ftrace.h
+generic-y += futex.h
+generic-y += gpio.h
+generic-y += hardirq.h
+generic-y += hw_irq.h
+generic-y += ioctl.h
+generic-y += ioctls.h
+generic-y += irq_regs.h
+generic-y += ipcbuf.h
+generic-y += irq_work.h
+generic-y += kdebug.h
+generic-y += kmap_types.h
+generic-y += kprobes.h
+generic-y += kvm_para.h
+generic-y += linkage.h
+generic-y += local.h
+generic-y += local64.h
+generic-y += mman.h
+generic-y += mm-arch-hooks.h
+generic-y += module.h
+generic-y += msgbuf.h
+generic-y += mutex.h
+generic-y += param.h
+generic-y += pci.h
+generic-y += percpu.h
+generic-y += posix_types.h
+generic-y += poll.h
+generic-y += preempt.h
+generic-y += resource.h
+generic-y += scatterlist.h
+generic-y += sections.h
+generic-y += sembuf.h
+generic-y += serial.h
+generic-y += setup.h
+generic-y += shmbuf.h
+generic-y += shm.h
+generic-y += siginfo.h
+generic-y += signal.h
+generic-y += sizes.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += statfs.h
+generic-y += switch_to.h
+generic-y += termbits.h
+generic-y += termios.h
+generic-y += timex.h
+generic-y += topology.h
+generic-y += trace_clock.h
+generic-y += types.h
+generic-y += ucontext.h
+generic-y += unaligned.h
+generic-y += user.h
+generic-y += vga.h
+generic-y += vmlinux.lds.h
+generic-y += word-at-a-time.h
diff --git a/arch/csky/include/uapi/asm/Kbuild b/arch/csky/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..b65252b
--- /dev/null
+++ b/arch/csky/include/uapi/asm/Kbuild
@@ -0,0 +1,33 @@
+include include/uapi/asm-generic/Kbuild.asm
+
+header-y += cachectl.h
+header-y += stat.h
+
+generic-y += auxvec.h
+generic-y += param.h
+generic-y += bpf_perf_event.h
+generic-y += errno.h
+generic-y += fcntl.h
+generic-y += ioctl.h
+generic-y += ioctls.h
+generic-y += ipcbuf.h
+generic-y += shmbuf.h
+generic-y += bitsperlong.h
+generic-y += mman.h
+generic-y += msgbuf.h
+generic-y += poll.h
+generic-y += posix_types.h
+generic-y += resource.h
+generic-y += sembuf.h
+generic-y += siginfo.h
+generic-y += signal.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += statfs.h
+generic-y += stat.h
+generic-y += setup.h
+generic-y += swab.h
+generic-y += termbits.h
+generic-y += termios.h
+generic-y += types.h
+generic-y += ucontext.h
diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
new file mode 100644
index 0000000..5403650
--- /dev/null
+++ b/arch/csky/kernel/Makefile
@@ -0,0 +1,8 @@
+extra-y := head.o vmlinux.lds
+
+obj-y += entry.o atomic.o signal.o traps.o irq.o time.o vdso.o \
+	 power.o syscall.o platform.o syscall_table.o setup.o \
+	 cskyksyms.o process.o cpu-probe.o ptrace.o dumpstack.o
+
+obj-$(CONFIG_MODULES) += module.o
+obj-$(CONFIG_SMP) += smp.o
diff --git a/arch/csky/lib/Makefile b/arch/csky/lib/Makefile
new file mode 100644
index 0000000..02aefbc
--- /dev/null
+++ b/arch/csky/lib/Makefile
@@ -0,0 +1 @@
+lib-y  := memset.o usercopy.o delay.o
diff --git a/arch/csky/mm/Makefile b/arch/csky/mm/Makefile
new file mode 100644
index 0000000..c870eb3
--- /dev/null
+++ b/arch/csky/mm/Makefile
@@ -0,0 +1,13 @@
+ifeq ($(CONFIG_CPU_HAS_CACHEV2),y)
+obj-y +=			cachev2.o
+else
+obj-y +=			cachev1.o
+endif
+
+obj-y +=			dma-mapping.o
+obj-y +=			fault.o
+obj-$(CONFIG_HIGHMEM) +=	highmem.o
+obj-y +=			init.o
+obj-y +=			ioremap.o
+obj-y +=			syscache.o
+obj-y +=			tlb.o
-- 
2.7.4
