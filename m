From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v11 13/19] h8300: Memory management
Date: Sat,  9 May 2015 00:04:33 +0900
Message-ID: <1431097479-21101-14-git-send-email-ysato@users.sourceforge.jp>
References: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:53471 "EHLO
	mail1.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114AbbEHPEz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 May 2015 11:04:55 -0400
In-Reply-To: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/mm/Makefile |   5 ++
 arch/h8300/mm/fault.c  |  57 ++++++++++++++++++++++
 arch/h8300/mm/init.c   | 128 +++++++++++++++++++++++++++++++++++++++++++++++++
 arch/h8300/mm/memory.c |  53 ++++++++++++++++++++
 4 files changed, 243 insertions(+)
 create mode 100644 arch/h8300/mm/Makefile
 create mode 100644 arch/h8300/mm/fault.c
 create mode 100644 arch/h8300/mm/init.c
 create mode 100644 arch/h8300/mm/memory.c

diff --git a/arch/h8300/mm/Makefile b/arch/h8300/mm/Makefile
new file mode 100644
index 0000000..508697f
--- /dev/null
+++ b/arch/h8300/mm/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the linux h8300-specific parts of the memory manager.
+#
+
+obj-y	 := init.o fault.o memory.o
diff --git a/arch/h8300/mm/fault.c b/arch/h8300/mm/fault.c
new file mode 100644
index 0000000..5924ff5
--- /dev/null
+++ b/arch/h8300/mm/fault.c
@@ -0,0 +1,57 @@
+/*
+ *  linux/arch/h8300/mm/fault.c
+ *
+ *  Copyright (C) 1998  D. Jeff Dionne <jeff@lineo.ca>,
+ *  Copyright (C) 2000  Lineo, Inc.  (www.lineo.com)
+ *
+ *  Based on:
+ *
+ *  linux/arch/m68knommu/mm/fault.c
+ *  linux/arch/m68k/mm/fault.c
+ *
+ *  Copyright (C) 1995  Hamish Macdonald
+ */
+
+#include <linux/mman.h>
+#include <linux/mm.h>
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+
+#include <asm/pgtable.h>
+
+void die(const char *str, struct pt_regs *fp, unsigned long err);
+
+/*
+ * This routine handles page faults.  It determines the problem, and
+ * then passes it off to one of the appropriate routines.
+ *
+ * error_code:
+ *	bit 0 == 0 means no page found, 1 means protection fault
+ *	bit 1 == 0 means read, 1 means write
+ *
+ * If this routine detects a bad access, it returns 1, otherwise it
+ * returns 0.
+ */
+asmlinkage int do_page_fault(struct pt_regs *regs, unsigned long address,
+			      unsigned long error_code)
+{
+#ifdef DEBUG
+	pr_debug("regs->sr=%#x, regs->pc=%#lx, address=%#lx, %ld\n",
+		 regs->sr, regs->pc, address, error_code);
+#endif
+
+/*
+ * Oops. The kernel tried to access some bad page. We'll have to
+ * terminate things with extreme prejudice.
+ */
+	if ((unsigned long) address < PAGE_SIZE)
+		pr_alert("Unable to handle kernel NULL pointer dereference");
+	else
+		pr_alert("Unable to handle kernel access");
+	printk(" at virtual address %08lx\n", address);
+	if (!user_mode(regs))
+		die("Oops", regs, error_code);
+	do_exit(SIGKILL);
+
+	return 1;
+}
diff --git a/arch/h8300/mm/init.c b/arch/h8300/mm/init.c
new file mode 100644
index 0000000..495a3d6
--- /dev/null
+++ b/arch/h8300/mm/init.c
@@ -0,0 +1,128 @@
+/*
+ *  linux/arch/h8300/mm/init.c
+ *
+ *  Copyright (C) 1998  D. Jeff Dionne <jeff@lineo.ca>,
+ *                      Kenneth Albanowski <kjahds@kjahds.com>,
+ *  Copyright (C) 2000  Lineo, Inc.  (www.lineo.com)
+ *
+ *  Based on:
+ *
+ *  linux/arch/m68knommu/mm/init.c
+ *  linux/arch/m68k/mm/init.c
+ *
+ *  Copyright (C) 1995  Hamish Macdonald
+ *
+ *  JAN/1999 -- hacked to support ColdFire (gerg@snapgear.com)
+ *  DEC/2000 -- linux 2.4 support <davidm@snapgear.com>
+ */
+
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/ptrace.h>
+#include <linux/mman.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/init.h>
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
+#include <linux/bootmem.h>
+#include <linux/gfp.h>
+
+#include <asm/setup.h>
+#include <asm/segment.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/sections.h>
+
+/*
+ * BAD_PAGE is the page that is used for page faults when linux
+ * is out-of-memory. Older versions of linux just did a
+ * do_exit(), but using this instead means there is less risk
+ * for a process dying in kernel mode, possibly leaving a inode
+ * unused etc..
+ *
+ * BAD_PAGETABLE is the accompanying page-table: it is initialized
+ * to point to BAD_PAGE entries.
+ *
+ * ZERO_PAGE is a special page that is used for zero-initialized
+ * data and COW.
+ */
+static unsigned long empty_bad_page_table;
+static unsigned long empty_bad_page;
+unsigned long empty_zero_page;
+
+/*
+ * paging_init() continues the virtual memory environment setup which
+ * was begun by the code in arch/head.S.
+ * The parameters are pointers to where to stick the starting and ending
+ * addresses of available kernel virtual memory.
+ */
+void __init paging_init(void)
+{
+	/*
+	 * Make sure start_mem is page aligned,  otherwise bootmem and
+	 * page_alloc get different views og the world.
+	 */
+	unsigned long start_mem = PAGE_ALIGN(memory_start);
+	unsigned long end_mem   = memory_end & PAGE_MASK;
+
+	pr_debug("start_mem is %#lx\nvirtual_end is %#lx\n",
+		 start_mem, end_mem);
+
+	/*
+	 * Initialize the bad page table and bad page to point
+	 * to a couple of allocated pages.
+	 */
+	empty_bad_page_table = (unsigned long)alloc_bootmem_pages(PAGE_SIZE);
+	empty_bad_page = (unsigned long)alloc_bootmem_pages(PAGE_SIZE);
+	empty_zero_page = (unsigned long)alloc_bootmem_pages(PAGE_SIZE);
+	memset((void *)empty_zero_page, 0, PAGE_SIZE);
+
+	/*
+	 * Set up SFC/DFC registers (user data space).
+	 */
+	set_fs(USER_DS);
+
+	pr_debug("before free_area_init\n");
+
+	pr_debug("free_area_init -> start_mem is %#lx\nvirtual_end is %#lx\n",
+		 start_mem, end_mem);
+
+	{
+		unsigned long zones_size[MAX_NR_ZONES] = {0, };
+
+		zones_size[ZONE_NORMAL] = (end_mem - PAGE_OFFSET) >> PAGE_SHIFT;
+		free_area_init(zones_size);
+	}
+}
+
+void __init mem_init(void)
+{
+	pr_devel("Mem_init: start=%lx, end=%lx\n", memory_start, memory_end);
+
+	high_memory = (void *) (memory_end & PAGE_MASK);
+	max_mapnr = MAP_NR(high_memory);
+
+	/* this will put all low memory onto the freelists */
+	free_all_bootmem();
+
+	mem_init_print_info(NULL);
+}
+
+
+#ifdef CONFIG_BLK_DEV_INITRD
+void free_initrd_mem(unsigned long start, unsigned long end)
+{
+	free_reserved_area((void *)start, (void *)end, -1, "initrd");
+}
+#endif
+
+void
+free_initmem(void)
+{
+	free_initmem_default(-1);
+}
diff --git a/arch/h8300/mm/memory.c b/arch/h8300/mm/memory.c
new file mode 100644
index 0000000..4974aa4
--- /dev/null
+++ b/arch/h8300/mm/memory.c
@@ -0,0 +1,53 @@
+/*
+ *  linux/arch/h8300/mm/memory.c
+ *
+ *  Copyright (C) 2002  Yoshinori Sato <ysato@users.sourceforge.jp>,
+ *
+ *  Based on:
+ *
+ *  linux/arch/m68knommu/mm/memory.c
+ *
+ *  Copyright (C) 1998  Kenneth Albanowski <kjahds@kjahds.com>,
+ *  Copyright (C) 1999-2002, Greg Ungerer (gerg@snapgear.com)
+ *
+ *  Based on:
+ *
+ *  linux/arch/m68k/mm/memory.c
+ *
+ *  Copyright (C) 1995  Hamish Macdonald
+ */
+
+#include <linux/mm.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include <asm/setup.h>
+#include <asm/segment.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/traps.h>
+#include <asm/io.h>
+
+void cache_clear(unsigned long paddr, int len)
+{
+}
+
+
+void cache_push(unsigned long paddr, int len)
+{
+}
+
+void cache_push_v(unsigned long vaddr, int len)
+{
+}
+
+/*
+ * Map some physical address range into the kernel address space.
+ */
+
+unsigned long kernel_map(unsigned long paddr, unsigned long size,
+			 int nocacheflag, unsigned long *memavailp)
+{
+	return paddr;
+}
-- 
2.1.4
