From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v10 12/19] h8300: miscellaneous functions
Date: Mon,  4 May 2015 19:41:55 +0900
Message-ID: <1430736122-20929-14-git-send-email-ysato@users.sourceforge.jp>
References: <1430736122-20929-2-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:58966 "EHLO
	mail1.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbbEDKmz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2015 06:42:55 -0400
In-Reply-To: <1430736122-20929-2-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/kernel/asm-offsets.c | 67 ++++++++++++++++++++++++++++++++++
 arch/h8300/kernel/dma.c         | 69 +++++++++++++++++++++++++++++++++++
 arch/h8300/kernel/h8300_ksyms.c | 34 ++++++++++++++++++
 arch/h8300/kernel/module.c      | 70 ++++++++++++++++++++++++++++++++++++
 arch/h8300/kernel/sim-console.c | 79 +++++++++++++++++++++++++++++++++++++++++
 arch/h8300/kernel/syscalls.c    | 14 ++++++++
 6 files changed, 333 insertions(+)
 create mode 100644 arch/h8300/kernel/asm-offsets.c
 create mode 100644 arch/h8300/kernel/dma.c
 create mode 100644 arch/h8300/kernel/h8300_ksyms.c
 create mode 100644 arch/h8300/kernel/module.c
 create mode 100644 arch/h8300/kernel/sim-console.c
 create mode 100644 arch/h8300/kernel/syscalls.c

diff --git a/arch/h8300/kernel/asm-offsets.c b/arch/h8300/kernel/asm-offsets.c
new file mode 100644
index 0000000..dc2d16c
--- /dev/null
+++ b/arch/h8300/kernel/asm-offsets.c
@@ -0,0 +1,67 @@
+/*
+ * This program is used to generate definitions needed by
+ * assembly language modules.
+ *
+ * We use the technique used in the OSF Mach kernel code:
+ * generate asm statements containing #defines,
+ * compile this file to assembler, and then extract the
+ * #defines from the assembly-language output.
+ */
+
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/kernel_stat.h>
+#include <linux/ptrace.h>
+#include <linux/hardirq.h>
+#include <linux/kbuild.h>
+#include <asm/irq.h>
+#include <asm/ptrace.h>
+
+int main(void)
+{
+	/* offsets into the task struct */
+	OFFSET(TASK_STATE, task_struct, state);
+	OFFSET(TASK_FLAGS, task_struct, flags);
+	OFFSET(TASK_PTRACE, task_struct, ptrace);
+	OFFSET(TASK_BLOCKED, task_struct, blocked);
+	OFFSET(TASK_THREAD, task_struct, thread);
+	OFFSET(TASK_THREAD_INFO, task_struct, stack);
+	OFFSET(TASK_MM, task_struct, mm);
+	OFFSET(TASK_ACTIVE_MM, task_struct, active_mm);
+
+	/* offsets into the irq_cpustat_t struct */
+	DEFINE(CPUSTAT_SOFTIRQ_PENDING, offsetof(irq_cpustat_t,
+						 __softirq_pending));
+
+	/* offsets into the thread struct */
+	OFFSET(THREAD_KSP, thread_struct, ksp);
+	OFFSET(THREAD_USP, thread_struct, usp);
+	OFFSET(THREAD_CCR, thread_struct, ccr);
+
+	/* offsets into the pt_regs struct */
+	DEFINE(LER0,  offsetof(struct pt_regs, er0)      - sizeof(long));
+	DEFINE(LER1,  offsetof(struct pt_regs, er1)      - sizeof(long));
+	DEFINE(LER2,  offsetof(struct pt_regs, er2)      - sizeof(long));
+	DEFINE(LER3,  offsetof(struct pt_regs, er3)      - sizeof(long));
+	DEFINE(LER4,  offsetof(struct pt_regs, er4)      - sizeof(long));
+	DEFINE(LER5,  offsetof(struct pt_regs, er5)      - sizeof(long));
+	DEFINE(LER6,  offsetof(struct pt_regs, er6)      - sizeof(long));
+	DEFINE(LORIG, offsetof(struct pt_regs, orig_er0) - sizeof(long));
+	DEFINE(LSP,   offsetof(struct pt_regs, sp)       - sizeof(long));
+	DEFINE(LCCR,  offsetof(struct pt_regs, ccr)      - sizeof(long));
+	DEFINE(LVEC,  offsetof(struct pt_regs, vector)   - sizeof(long));
+#if defined(CONFIG_CPU_H8S)
+	DEFINE(LEXR,  offsetof(struct pt_regs, exr)      - sizeof(long));
+#endif
+	DEFINE(LRET,  offsetof(struct pt_regs, pc)       - sizeof(long));
+
+	DEFINE(PT_PTRACED, PT_PTRACED);
+
+	/* offsets in thread_info structure */
+	OFFSET(TI_TASK, thread_info, task);
+	OFFSET(TI_FLAGS, thread_info, flags);
+	OFFSET(TI_CPU, thread_info, cpu);
+	OFFSET(TI_PRE, thread_info, preempt_count);
+
+	return 0;
+}
diff --git a/arch/h8300/kernel/dma.c b/arch/h8300/kernel/dma.c
new file mode 100644
index 0000000..eeb13d3
--- /dev/null
+++ b/arch/h8300/kernel/dma.c
@@ -0,0 +1,69 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/scatterlist.h>
+#include <linux/module.h>
+#include <asm/pgalloc.h>
+
+static void *dma_alloc(struct device *dev, size_t size,
+		       dma_addr_t *dma_handle, gfp_t gfp,
+		       struct dma_attrs *attrs)
+{
+	void *ret;
+
+	/* ignore region specifiers */
+	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
+
+	if (dev == NULL || (*dev->dma_mask < 0xffffffff))
+		gfp |= GFP_DMA;
+	ret = (void *)__get_free_pages(gfp, get_order(size));
+
+	if (ret != NULL) {
+		memset(ret, 0, size);
+		*dma_handle = virt_to_phys(ret);
+	}
+	return ret;
+}
+
+static void dma_free(struct device *dev, size_t size,
+		     void *vaddr, dma_addr_t dma_handle,
+		     struct dma_attrs *attrs)
+
+{
+	free_pages((unsigned long)vaddr, get_order(size));
+}
+
+static dma_addr_t map_page(struct device *dev, struct page *page,
+				  unsigned long offset, size_t size,
+				  enum dma_data_direction direction,
+				  struct dma_attrs *attrs)
+{
+	return page_to_phys(page) + offset;
+}
+
+static int map_sg(struct device *dev, struct scatterlist *sgl,
+		  int nents, enum dma_data_direction direction,
+		  struct dma_attrs *attrs)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i) {
+		sg->dma_address = sg_phys(sg);
+	}
+
+	return nents;
+}
+
+struct dma_map_ops h8300_dma_map_ops = {
+	.alloc = dma_alloc,
+	.free = dma_free,
+	.map_page = map_page,
+	.map_sg = map_sg,
+};
+EXPORT_SYMBOL(h8300_dma_map_ops);
diff --git a/arch/h8300/kernel/h8300_ksyms.c b/arch/h8300/kernel/h8300_ksyms.c
new file mode 100644
index 0000000..33bf96a
--- /dev/null
+++ b/arch/h8300/kernel/h8300_ksyms.c
@@ -0,0 +1,34 @@
+#include <linux/module.h>
+#include <linux/linkage.h>
+
+/*
+ * libgcc functions - functions that are used internally by the
+ * compiler...  (prototypes are not correct though, but that
+ * doesn't really matter since they're not versioned).
+ */
+asmlinkage long long __ashldi3(long long, int);
+asmlinkage long long __ashrdi3(long long, int);
+asmlinkage long long __lshrdi3(long long, int);
+asmlinkage long __divsi3(long, long);
+asmlinkage long __modsi3(long, long);
+asmlinkage unsigned long __umodsi3(unsigned long, unsigned long);
+asmlinkage long long __muldi3(long long, long long);
+asmlinkage long __mulsi3(long, long);
+asmlinkage long __udivsi3(long, long);
+asmlinkage void *memcpy(void *, const void *, size_t);
+asmlinkage void *memset(void *, int, size_t);
+asmlinkage long strncpy_from_user(void *to, void *from, size_t n);
+
+	/* gcc lib functions */
+EXPORT_SYMBOL(__ashldi3);
+EXPORT_SYMBOL(__ashrdi3);
+EXPORT_SYMBOL(__lshrdi3);
+EXPORT_SYMBOL(__divsi3);
+EXPORT_SYMBOL(__modsi3);
+EXPORT_SYMBOL(__umodsi3);
+EXPORT_SYMBOL(__muldi3);
+EXPORT_SYMBOL(__mulsi3);
+EXPORT_SYMBOL(__udivsi3);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(strncpy_from_user);
diff --git a/arch/h8300/kernel/module.c b/arch/h8300/kernel/module.c
new file mode 100644
index 0000000..515f6c4
--- /dev/null
+++ b/arch/h8300/kernel/module.c
@@ -0,0 +1,70 @@
+#include <linux/moduleloader.h>
+#include <linux/elf.h>
+#include <linux/vmalloc.h>
+#include <linux/fs.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+
+int apply_relocate_add(Elf32_Shdr *sechdrs,
+		       const char *strtab,
+		       unsigned int symindex,
+		       unsigned int relsec,
+		       struct module *me)
+{
+	unsigned int i;
+	Elf32_Rela *rela = (void *)sechdrs[relsec].sh_addr;
+
+	pr_debug("Applying relocate section %u to %u\n", relsec,
+	       sechdrs[relsec].sh_info);
+	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rela); i++) {
+		/* This is where to make the change */
+		uint32_t *loc =
+			(uint32_t *)(sechdrs[sechdrs[relsec].sh_info].sh_addr
+					     + rela[i].r_offset);
+		/* This is the symbol it is referring to.  Note that all
+		   undefined symbols have been resolved.  */
+		Elf32_Sym *sym = (Elf32_Sym *)sechdrs[symindex].sh_addr
+			+ ELF32_R_SYM(rela[i].r_info);
+		uint32_t v = sym->st_value + rela[i].r_addend;
+
+		switch (ELF32_R_TYPE(rela[i].r_info)) {
+		case R_H8_DIR24R8:
+			loc = (uint32_t *)((uint32_t)loc - 1);
+			*loc = (*loc & 0xff000000) | ((*loc & 0xffffff) + v);
+			break;
+		case R_H8_DIR24A8:
+			if (ELF32_R_SYM(rela[i].r_info))
+				*loc += v;
+			break;
+		case R_H8_DIR32:
+		case R_H8_DIR32A16:
+			*loc += v;
+			break;
+		case R_H8_PCREL16:
+			v -= (unsigned long)loc + 2;
+			if ((Elf32_Sword)v > 0x7fff ||
+			    (Elf32_Sword)v < -(Elf32_Sword)0x8000)
+				goto overflow;
+			else
+				*(unsigned short *)loc = v;
+			break;
+		case R_H8_PCREL8:
+			v -= (unsigned long)loc + 1;
+			if ((Elf32_Sword)v > 0x7f ||
+			    (Elf32_Sword)v < -(Elf32_Sword)0x80)
+				goto overflow;
+			else
+				*(unsigned char *)loc = v;
+			break;
+		default:
+			pr_err("module %s: Unknown relocation: %u\n",
+			       me->name, ELF32_R_TYPE(rela[i].r_info));
+			return -ENOEXEC;
+		}
+	}
+	return 0;
+ overflow:
+	pr_err("module %s: relocation offset overflow: %08x\n",
+	       me->name, rela[i].r_offset);
+	return -ENOEXEC;
+}
diff --git a/arch/h8300/kernel/sim-console.c b/arch/h8300/kernel/sim-console.c
new file mode 100644
index 0000000..a15edf0
--- /dev/null
+++ b/arch/h8300/kernel/sim-console.c
@@ -0,0 +1,79 @@
+/*
+ * arch/h8300/kernel/early_printk.c
+ *
+ *  Copyright (C) 2009 Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/console.h>
+#include <linux/tty.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+static void sim_write(struct console *co, const char *ptr,
+				 unsigned len)
+{
+	register const int fd __asm__("er0") = 1; /* stdout */
+	register const char *_ptr __asm__("er1") = ptr;
+	register const unsigned _len __asm__("er2") = len;
+
+	__asm__(".byte 0x5e,0x00,0x00,0xc7\n\t" /* jsr @0xc7 (sys_write) */
+		: : "g"(fd), "g"(_ptr), "g"(_len));
+}
+
+static struct console sim_console = {
+	.name		= "sim_console",
+	.write		= sim_write,
+	.setup		= NULL,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+};
+
+static char sim_console_buf[32];
+
+static int sim_probe(struct platform_device *pdev)
+{
+	if (sim_console.data)
+		return -EEXIST;
+
+	if (!strstr(sim_console_buf, "keep"))
+		sim_console.flags |= CON_BOOT;
+
+	register_console(&sim_console);
+	return 0;
+}
+
+static int sim_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver sim_driver = {
+	.probe		= sim_probe,
+	.remove		= sim_remove,
+	.driver		= {
+		.name	= "h8300-sim",
+		.owner	= THIS_MODULE,
+	},
+};
+
+early_platform_init_buffer("earlyprintk", &sim_driver,
+			   sim_console_buf, ARRAY_SIZE(sim_console_buf));
+
+static struct platform_device sim_console_device = {
+	.name		= "h8300-sim",
+	.id		= 0,
+};
+
+static struct platform_device *devices[] __initdata = {
+	&sim_console_device,
+};
+
+void __init sim_console_register(void)
+{
+	early_platform_add_devices(devices,
+				   ARRAY_SIZE(devices));
+}
diff --git a/arch/h8300/kernel/syscalls.c b/arch/h8300/kernel/syscalls.c
new file mode 100644
index 0000000..1f9123a
--- /dev/null
+++ b/arch/h8300/kernel/syscalls.c
@@ -0,0 +1,14 @@
+#include <linux/syscalls.h>
+#include <linux/signal.h>
+#include <linux/unistd.h>
+
+#undef __SYSCALL
+#define __SYSCALL(nr, call) [nr] = (call),
+
+#define sys_mmap2 sys_mmap_pgoff
+
+asmlinkage int sys_rt_sigreturn(void);
+
+void *_sys_call_table[__NR_syscalls] = {
+#include <asm/unistd.h>
+};
-- 
2.1.4
