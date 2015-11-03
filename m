From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 03/28] lkl: architecture skeleton for Linux kernel library
Date: Tue,  3 Nov 2015 22:20:34 +0200
Message-ID: <1446582059-17355-4-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-arch.vger.kernel.org

Adds the LKL Kconfig, vmlinux linker script, basic architecture
headers and miscellaneous basic functions or stubs such as
dump_stack(), show_regs() and cpuinfo proc ops.

The headers we introduce in this patch are simple wrappers to the
asm-generic headers or stubs for things we don't support, such as
ptrace, DMA, signals, ELF handling and low level processor operations.

The kernel configuration is automatically updated to reflect the
endianness of the host, 64bit support or the output format for
vmlinux's linker script. We do this by looking at the ld's default
output format.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 MAINTAINERS                             |  5 ++
 arch/lkl/.gitignore                     |  1 +
 arch/lkl/Kconfig                        | 82 +++++++++++++++++++++++++++++++++
 arch/lkl/auto.conf                      |  1 +
 arch/lkl/defconfig                      | 35 ++++++++++++++
 arch/lkl/include/asm/Kbuild             | 77 +++++++++++++++++++++++++++++++
 arch/lkl/include/asm/bitsperlong.h      | 11 +++++
 arch/lkl/include/asm/byteorder.h        | 10 ++++
 arch/lkl/include/asm/dma-mapping.h      |  6 +++
 arch/lkl/include/asm/elf.h              | 13 ++++++
 arch/lkl/include/asm/mutex.h            |  7 +++
 arch/lkl/include/asm/processor.h        | 53 +++++++++++++++++++++
 arch/lkl/include/asm/ptrace.h           | 23 +++++++++
 arch/lkl/include/asm/vmlinux.lds.h      | 15 ++++++
 arch/lkl/include/uapi/asm/Kbuild        | 38 +++++++++++++++
 arch/lkl/include/uapi/asm/bitsperlong.h | 12 +++++
 arch/lkl/include/uapi/asm/sigcontext.h  | 14 ++++++
 arch/lkl/kernel/asm-offsets.c           |  1 +
 arch/lkl/kernel/misc.c                  | 57 +++++++++++++++++++++++
 arch/lkl/kernel/vmlinux.lds.S           | 45 ++++++++++++++++++
 20 files changed, 506 insertions(+)
 create mode 100644 arch/lkl/.gitignore
 create mode 100644 arch/lkl/Kconfig
 create mode 100644 arch/lkl/auto.conf
 create mode 100644 arch/lkl/defconfig
 create mode 100644 arch/lkl/include/asm/Kbuild
 create mode 100644 arch/lkl/include/asm/bitsperlong.h
 create mode 100644 arch/lkl/include/asm/byteorder.h
 create mode 100644 arch/lkl/include/asm/dma-mapping.h
 create mode 100644 arch/lkl/include/asm/elf.h
 create mode 100644 arch/lkl/include/asm/mutex.h
 create mode 100644 arch/lkl/include/asm/processor.h
 create mode 100644 arch/lkl/include/asm/ptrace.h
 create mode 100644 arch/lkl/include/asm/vmlinux.lds.h
 create mode 100644 arch/lkl/include/uapi/asm/Kbuild
 create mode 100644 arch/lkl/include/uapi/asm/bitsperlong.h
 create mode 100644 arch/lkl/include/uapi/asm/sigcontext.h
 create mode 100644 arch/lkl/kernel/asm-offsets.c
 create mode 100644 arch/lkl/kernel/misc.c
 create mode 100644 arch/lkl/kernel/vmlinux.lds.S

diff --git a/MAINTAINERS b/MAINTAINERS
index 77ed3a0..e2a737f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6355,6 +6355,11 @@ F:	arch/powerpc/platforms/pasemi/
 F:	drivers/*/*pasemi*
 F:	drivers/*/*/*pasemi*
 
+LINUX KERNEL LIBRARY
+M:	Octavian Purdila <octavian.purdila@intel.com>
+S:	Maintained
+F:	arch/lkl/
+
 LINUX SECURITY MODULE (LSM) FRAMEWORK
 M:	Chris Wright <chrisw@sous-sol.org>
 L:	linux-security-module@vger.kernel.org
diff --git a/arch/lkl/.gitignore b/arch/lkl/.gitignore
new file mode 100644
index 0000000..c619b7d
--- /dev/null
+++ b/arch/lkl/.gitignore
@@ -0,0 +1 @@
+kernel/vmlinux.lds
diff --git a/arch/lkl/Kconfig b/arch/lkl/Kconfig
new file mode 100644
index 0000000..064960b
--- /dev/null
+++ b/arch/lkl/Kconfig
@@ -0,0 +1,82 @@
+config LKL
+       def_bool y
+       depends on !SMP && !MMU && !COREDUMP && !AUDITSYSCALL && !SECCOMP && !TRACEPOINTS && !UPROBES && !COMPAT && !USER_RETURN_NOTIFIER
+       select ARCH_THREAD_INFO_ALLOCATOR
+       select RWSEM_GENERIC_SPINLOCK
+       select GENERIC_ATOMIC64
+       select SEMAPHORE_SLEEPERS
+       select GENERIC_TIME
+       select GENERIC_FIND_NEXT_BIT
+       select GENERIC_HWEIGHT
+       select GENERIC_HARDIRQS
+       select FLATMEM
+       select FLAT_NODE_MEM_MAP
+       select GENERIC_CLOCKEVENTS
+       select GENERIC_CPU_DEVICES
+       select NO_HZ_IDLE
+       select NO_PREEMPT
+       select ARCH_WANT_FRAME_POINTERS
+       select PHYS_ADDR_T_64BIT if 64BIT
+       select 64BIT if OUTPUT_FORMAT = "elf64-x86-64"
+
+config OUTPUTFORMAT
+       string
+       option env="OUTPUT_FORMAT"
+
+config OUTPUT_FORMAT
+       string "Output format"
+       default OUTPUTFORMAT
+
+config ARCH_DMA_ADDR_T_64BIT
+       def_bool 64BIT
+
+config 64BIT
+       def_bool n
+
+config BIG_ENDIAN
+       def_bool n
+
+config NO_DMA
+       def_bool y
+
+config GENERIC_CSUM
+       def_bool y
+
+config GENERIC_HWEIGHT
+       def_bool y
+
+config NO_IOPORT_MAP
+       def_bool y
+
+config RWSEM_GENERIC_SPINLOCK
+	bool
+	default y
+
+source init/Kconfig
+
+source net/Kconfig
+
+source drivers/base/Kconfig
+
+source drivers/virtio/Kconfig
+
+source drivers/block/Kconfig
+
+source fs/Kconfig
+
+source mm/Kconfig
+
+source kernel/Kconfig.preempt
+
+source kernel/Kconfig.locks
+
+source kernel/Kconfig.hz
+
+source security/Kconfig
+
+source crypto/Kconfig
+
+source lib/Kconfig
+
+source lib/Kconfig.debug
+
diff --git a/arch/lkl/auto.conf b/arch/lkl/auto.conf
new file mode 100644
index 0000000..4bfd65a
--- /dev/null
+++ b/arch/lkl/auto.conf
@@ -0,0 +1 @@
+export OUTPUT_FORMAT=$(shell $(LD) -r -print-output-format)
diff --git a/arch/lkl/defconfig b/arch/lkl/defconfig
new file mode 100644
index 0000000..90f385d
--- /dev/null
+++ b/arch/lkl/defconfig
@@ -0,0 +1,35 @@
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_USELIB is not set
+# CONFIG_SYSFS_SYSCALL is not set
+CONFIG_KALLSYMS_ALL=y
+# CONFIG_BASE_FULL is not set
+# CONFIG_FUTEX is not set
+# CONFIG_EPOLL is not set
+# CONFIG_SIGNALFD is not set
+# CONFIG_TIMERFD is not set
+# CONFIG_EVENTFD is not set
+# CONFIG_AIO is not set
+# CONFIG_ADVISE_SYSCALLS is not set
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_UEVENT_HELPER is not set
+# CONFIG_FW_LOADER is not set
+CONFIG_VIRTIO_MMIO=y
+CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
+CONFIG_VIRTIO_BLK=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_CRYPTO_ANSI_CPRNG=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_REDUCED=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_SLUB_DEBUG_ON=y
diff --git a/arch/lkl/include/asm/Kbuild b/arch/lkl/include/asm/Kbuild
new file mode 100644
index 0000000..55acf3f
--- /dev/null
+++ b/arch/lkl/include/asm/Kbuild
@@ -0,0 +1,77 @@
+generic-y += atomic.h
+generic-y += barrier.h
+generic-y += bitops.h
+generic-y += bug.h
+generic-y += bugs.h
+generic-y += cache.h
+generic-y += cacheflush.h
+generic-y += checksum.h
+generic-y += cmpxchg-local.h
+generic-y += cmpxchg.h
+generic-y += cputime.h
+generic-y += current.h
+generic-y += delay.h
+generic-y += device.h
+generic-y += div64.h
+generic-y += dma.h
+generic-y += emergency-restart.h
+generic-y += errno.h
+generic-y += exec.h
+generic-y += ftrace.h
+generic-y += futex.h
+generic-y += hardirq.h
+generic-y += hw_irq.h
+generic-y += ioctl.h
+generic-y += ipcbuf.h
+generic-y += irq_regs.h
+generic-y += irqflags.h
+generic-y += irq_work.h
+generic-y += kdebug.h
+generic-y += kmap_types.h
+generic-y += linkage.h
+generic-y += local.h
+generic-y += local64.h
+generic-y += mcs_spinlock.h
+generic-y += mmu.h
+generic-y += mmu_context.h
+generic-y += module.h
+generic-y += msgbuf.h
+generic-y += page.h
+generic-y += param.h
+generic-y += parport.h
+generic-y += pci.h
+generic-y += percpu.h
+generic-y += pgalloc.h
+generic-y += poll.h
+generic-y += preempt.h
+generic-y += resource.h
+generic-y += rwsem.h
+generic-y += scatterlist.h
+generic-y += seccomp.h
+generic-y += sections.h
+generic-y += segment.h
+generic-y += sembuf.h
+generic-y += serial.h
+generic-y += shmbuf.h
+generic-y += siginfo.h
+generic-y += signal.h
+generic-y += simd.h
+generic-y += sizes.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += stat.h
+generic-y += statfs.h
+generic-y += string.h
+generic-y += swab.h
+generic-y += switch_to.h
+generic-y += termbits.h
+generic-y += termios.h
+generic-y += time.h
+generic-y += timex.h
+generic-y += tlb.h
+generic-y += tlbflush.h
+generic-y += topology.h
+generic-y += trace_clock.h
+generic-y += uaccess.h
+generic-y += unaligned.h
+generic-y += word-at-a-time.h
diff --git a/arch/lkl/include/asm/bitsperlong.h b/arch/lkl/include/asm/bitsperlong.h
new file mode 100644
index 0000000..282b081
--- /dev/null
+++ b/arch/lkl/include/asm/bitsperlong.h
@@ -0,0 +1,11 @@
+#ifndef __LKL_BITSPERLONG_H
+#define __LKL_BITSPERLONG_H
+
+#include <uapi/asm/bitsperlong.h>
+
+#define BITS_PER_LONG __BITS_PER_LONG
+
+#define BITS_PER_LONG_LONG 64
+
+#endif
+
diff --git a/arch/lkl/include/asm/byteorder.h b/arch/lkl/include/asm/byteorder.h
new file mode 100644
index 0000000..19a5f0e
--- /dev/null
+++ b/arch/lkl/include/asm/byteorder.h
@@ -0,0 +1,10 @@
+#ifndef _ASM_LKL_BYTEORDER_H
+#define _ASM_LKL_BYTEORDER_H
+
+#if defined(CONFIG_BIG_ENDIAN)
+#include <linux/byteorder/big_endian.h>
+#else
+#include <linux/byteorder/little_endian.h>
+#endif
+
+#endif /* _ASM_LKL_BYTEORDER_H */
diff --git a/arch/lkl/include/asm/dma-mapping.h b/arch/lkl/include/asm/dma-mapping.h
new file mode 100644
index 0000000..a2e0bd9
--- /dev/null
+++ b/arch/lkl/include/asm/dma-mapping.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_LKL_DMA_MAPPING_H
+#define _ASM_LKL_DMA_MAPPING_H
+
+#include <asm-generic/dma-mapping-broken.h>
+
+#endif
diff --git a/arch/lkl/include/asm/elf.h b/arch/lkl/include/asm/elf.h
new file mode 100644
index 0000000..cada3ab
--- /dev/null
+++ b/arch/lkl/include/asm/elf.h
@@ -0,0 +1,13 @@
+#ifndef _ASM_LKL_ELF_H
+#define _ASM_LKL_ELF_H
+
+#define elf_check_arch(x) 0
+
+#ifdef CONFIG_64BIT
+#define ELF_CLASS ELFCLASS64
+#else
+#define ELF_CLASS ELFCLASS32
+#endif
+
+#endif
+
diff --git a/arch/lkl/include/asm/mutex.h b/arch/lkl/include/asm/mutex.h
new file mode 100644
index 0000000..77c2c53
--- /dev/null
+++ b/arch/lkl/include/asm/mutex.h
@@ -0,0 +1,7 @@
+#ifndef _ASM_LKL_MUTEX_H
+#define _ASM_LKL_MUTEX_H
+
+#include <asm-generic/mutex-dec.h>
+
+#endif
+
diff --git a/arch/lkl/include/asm/processor.h b/arch/lkl/include/asm/processor.h
new file mode 100644
index 0000000..7f6bdb4
--- /dev/null
+++ b/arch/lkl/include/asm/processor.h
@@ -0,0 +1,53 @@
+#ifndef _ASM_LKL_PROCESSOR_H
+#define _ASM_LKL_PROCESSOR_H
+
+struct task_struct;
+
+#define cpu_relax() barrier()
+
+#define current_text_addr() ({ __label__ _l; _l: &&_l; })
+
+static inline unsigned long thread_saved_pc(struct task_struct *tsk)
+{
+	return 0;
+}
+
+static inline void release_thread(struct task_struct *dead_task)
+{
+}
+
+static inline void prepare_to_copy(struct task_struct *tsk)
+{
+}
+
+static inline unsigned long get_wchan(struct task_struct *p)
+{
+	return 0;
+}
+
+static inline void flush_thread(void)
+{
+}
+
+static inline void exit_thread(void)
+{
+}
+
+static inline void trap_init(void)
+{
+}
+
+struct thread_struct { };
+
+#define INIT_THREAD { }
+
+#define task_pt_regs(tsk) (struct pt_regs *)(NULL)
+
+/* We don't have strict user/kernel spaces */
+#define TASK_SIZE ((unsigned long)-1)
+#define TASK_UNMAPPED_BASE	0
+
+#define KSTK_EIP(tsk)	(0)
+#define KSTK_ESP(tsk)	(0)
+
+#endif
diff --git a/arch/lkl/include/asm/ptrace.h b/arch/lkl/include/asm/ptrace.h
new file mode 100644
index 0000000..f3c27e7
--- /dev/null
+++ b/arch/lkl/include/asm/ptrace.h
@@ -0,0 +1,23 @@
+#ifndef _ASM_LKL_PTRACE_H
+#define _ASM_LKL_PTRACE_H
+
+struct task_struct;
+
+#define user_mode(regs) 0
+#define kernel_mode(regs) 1
+#define profile_pc(regs) 0
+#define instruction_pointer(regs) 0
+#define user_stack_pointer(regs) 0
+
+static inline long arch_ptrace(struct task_struct *child,
+			       long request, unsigned long addr,
+			       unsigned long data)
+{
+	return -EINVAL;
+}
+
+static inline void ptrace_disable(struct task_struct *child)
+{
+}
+
+#endif
diff --git a/arch/lkl/include/asm/vmlinux.lds.h b/arch/lkl/include/asm/vmlinux.lds.h
new file mode 100644
index 0000000..392c94a
--- /dev/null
+++ b/arch/lkl/include/asm/vmlinux.lds.h
@@ -0,0 +1,15 @@
+#ifndef _LKL_VMLINUX_LDS_H
+#define _LKL_VMLINUX_LDS_H
+
+#ifdef __MINGW32__
+#define VMLINUX_SYMBOL(sym) _##sym
+#define RODATA_SECTION .rdata
+#endif
+
+#include <asm-generic/vmlinux.lds.h>
+
+#ifndef RODATA_SECTION
+#define RODATA_SECTION .rodata
+#endif
+
+#endif
diff --git a/arch/lkl/include/uapi/asm/Kbuild b/arch/lkl/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..cfa727b
--- /dev/null
+++ b/arch/lkl/include/uapi/asm/Kbuild
@@ -0,0 +1,38 @@
+# UAPI Header export list
+include include/uapi/asm-generic/Kbuild.asm
+
+generic-y += auxvec.h
+generic-y += byteorder.h
+generic-y += elf.h
+generic-y += errno.h
+generic-y += fcntl.h
+generic-y += ioctl.h
+generic-y += ioctls.h
+generic-y += ipcbuf.h
+generic-y += kvm_para.h
+generic-y += mman.h
+generic-y += msgbuf.h
+generic-y += param.h
+generic-y += poll.h
+generic-y += posix_types.h
+generic-y += ptrace.h
+generic-y += resource.h
+generic-y += sembuf.h
+generic-y += setup.h
+generic-y += shmbuf.h
+generic-y += shmparam.h
+generic-y += siginfo.h
+generic-y += signal.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += stat.h
+generic-y += statfs.h
+generic-y += swab.h
+generic-y += termbits.h
+generic-y += termios.h
+generic-y += timex.h
+generic-y += types.h
+generic-y += unistd.h
+
+# no header-y since we need special user headers handling
+# see arch/lkl/script/headers.py
diff --git a/arch/lkl/include/uapi/asm/bitsperlong.h b/arch/lkl/include/uapi/asm/bitsperlong.h
new file mode 100644
index 0000000..12b522d
--- /dev/null
+++ b/arch/lkl/include/uapi/asm/bitsperlong.h
@@ -0,0 +1,12 @@
+#ifndef _ASM_UAPI_LKL_AUTOCONF_H
+#define _ASM_UAPI_LKL_AUTOCONF_H
+
+#ifdef CONFIG_64BIT
+#define __BITS_PER_LONG 64
+#else
+#define __BITS_PER_LONG 32
+#endif
+
+#define __ARCH_WANT_STAT64
+
+#endif /* _ASM_UAPI_LKL_TARGET_H */
diff --git a/arch/lkl/include/uapi/asm/sigcontext.h b/arch/lkl/include/uapi/asm/sigcontext.h
new file mode 100644
index 0000000..99b2d53
--- /dev/null
+++ b/arch/lkl/include/uapi/asm/sigcontext.h
@@ -0,0 +1,14 @@
+#ifndef _ASM_UAPI_LKL_SIGCONTEXT_H
+#define _ASM_UAPI_LKL_SIGCONTEXT_H
+
+#include <asm/ptrace.h>
+
+struct pt_regs {
+};
+
+struct sigcontext {
+	struct pt_regs regs;
+	unsigned long oldmask;
+};
+
+#endif
diff --git a/arch/lkl/kernel/asm-offsets.c b/arch/lkl/kernel/asm-offsets.c
new file mode 100644
index 0000000..9e26311
--- /dev/null
+++ b/arch/lkl/kernel/asm-offsets.c
@@ -0,0 +1 @@
+/* Dummy asm-offsets.c file. Required by kbuild and ready to be used - hint! */
diff --git a/arch/lkl/kernel/misc.c b/arch/lkl/kernel/misc.c
new file mode 100644
index 0000000..44d4736
--- /dev/null
+++ b/arch/lkl/kernel/misc.c
@@ -0,0 +1,57 @@
+#include <linux/kallsyms.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <asm/ptrace.h>
+#include <asm/host_ops.h>
+
+void dump_stack(void)
+{
+	unsigned long dummy;
+	unsigned long *stack = &dummy;
+	unsigned long addr;
+
+	pr_info("Call Trace:\n");
+	while (((long)stack & (THREAD_SIZE - 1)) != 0) {
+		addr = *stack;
+		if (__kernel_text_address(addr)) {
+			pr_info("%p:  [<%08lx>]", stack, addr);
+			print_symbol(KERN_CONT " %s", addr);
+			pr_cont("\n");
+		}
+		stack++;
+	}
+	pr_info("\n");
+}
+
+void show_regs(struct pt_regs *regs)
+{
+}
+
+#ifdef CONFIG_PROC_FS
+static void *cpuinfo_start(struct seq_file *m, loff_t *pos)
+{
+	return NULL;
+}
+
+static void *cpuinfo_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return NULL;
+}
+
+static void cpuinfo_stop(struct seq_file *m, void *v)
+{
+}
+
+static int show_cpuinfo(struct seq_file *m, void *v)
+{
+	return 0;
+}
+
+const struct seq_operations cpuinfo_op = {
+	.start	= cpuinfo_start,
+	.next	= cpuinfo_next,
+	.stop	= cpuinfo_stop,
+	.show	= show_cpuinfo,
+};
+#endif
diff --git a/arch/lkl/kernel/vmlinux.lds.S b/arch/lkl/kernel/vmlinux.lds.S
new file mode 100644
index 0000000..cf96922
--- /dev/null
+++ b/arch/lkl/kernel/vmlinux.lds.S
@@ -0,0 +1,45 @@
+#include <asm/vmlinux.lds.h>
+#include <asm/thread_info.h>
+#include <asm/page.h>
+#include <asm/cache.h>
+
+OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
+
+VMLINUX_SYMBOL(jiffies) = VMLINUX_SYMBOL(jiffies_64);
+
+SECTIONS
+{
+	VMLINUX_SYMBOL(__init_begin) = .;
+	HEAD_TEXT_SECTION
+	INIT_TEXT_SECTION(PAGE_SIZE)
+	INIT_DATA_SECTION(16)
+	PERCPU_SECTION(L1_CACHE_BYTES)
+	VMLINUX_SYMBOL(__init_end) = .;
+
+	VMLINUX_SYMBOL(_stext) = .;
+	VMLINUX_SYMBOL(_text) = . ;
+	VMLINUX_SYMBOL(text) = . ;
+	.text      :
+	{
+		TEXT_TEXT
+		SCHED_TEXT
+		LOCK_TEXT
+	}
+	VMLINUX_SYMBOL(_etext) = .;
+
+	VMLINUX_SYMBOL(_sdata) = .;
+	RO_DATA_SECTION(PAGE_SIZE)
+	RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
+	VMLINUX_SYMBOL(_edata) = .;
+
+	EXCEPTION_TABLE(16)
+	NOTES
+
+	BSS_SECTION(0, 0, 0)
+	VMLINUX_SYMBOL(_end) = .;
+
+	STABS_DEBUG
+	DWARF_DEBUG
+
+	DISCARDS
+}
-- 
2.1.0
