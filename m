Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51015 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752371AbYBGI0T (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Feb 2008 03:26:19 -0500
Message-Id: <200802070815.m178F0Cg024035@imap1.linux-foundation.org>
Subject: [patch 116/208] Use BOOTMEM_EXCLUSIVE for kdump
From: akpm@linux-foundation.org
Date: Thu, 07 Feb 2008 00:15:19 -0800
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, bwalle@suse.de, ebiederm@xmission.com, lethal@linux-sh.org, linux-arch@vger.kernel.org, vgoyal@in.ibm.com

From: Bernhard Walle <bwalle@suse.de>

Use the BOOTMEM_EXCLUSIVE, introduced in the previous patch, to avoid
conflicts while reserving the memory for the kdump capture kernel
(crashkernel=).

Signed-off-by: Bernhard Walle <bwalle@suse.de>
Cc: <linux-arch@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@in.ibm.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/sh/kernel/setup.c     |   29 +++++++++++++++++-----------
 arch/x86/kernel/setup_64.c |   36 ++++++++++++++++++++---------------
 2 files changed, 39 insertions(+), 26 deletions(-)

diff -puN arch/sh/kernel/setup.c~use-bootmem_exclusive-for-kdump arch/sh/kernel/setup.c
--- a/arch/sh/kernel/setup.c~use-bootmem_exclusive-for-kdump
+++ a/arch/sh/kernel/setup.c
@@ -140,19 +140,26 @@ static void __init reserve_crashkernel(v
 	ret = parse_crashkernel(boot_command_line, free_mem,
 			&crash_size, &crash_base);
 	if (ret == 0 && crash_size) {
-		if (crash_base > 0) {
-			printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
-					"for crashkernel (System RAM: %ldMB)\n",
-					(unsigned long)(crash_size >> 20),
-					(unsigned long)(crash_base >> 20),
-					(unsigned long)(free_mem >> 20));
-			crashk_res.start = crash_base;
-			crashk_res.end   = crash_base + crash_size - 1;
-			reserve_bootmem(crash_base, crash_size,
-					BOOTMEM_DEFAULT);
-		} else
+		if (crash_base <= 0) {
 			printk(KERN_INFO "crashkernel reservation failed - "
 					"you have to specify a base address\n");
+			return;
+		}
+
+		if (reserve_bootmem(crash_base, crash_size,
+					BOOTMEM_EXCLUSIVE) < 0) {
+			printk(KERN_INFO "crashkernel reservation failed - "
+					"memory is in use\n");
+			return;
+		}
+
+		printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
+				"for crashkernel (System RAM: %ldMB)\n",
+				(unsigned long)(crash_size >> 20),
+				(unsigned long)(crash_base >> 20),
+				(unsigned long)(free_mem >> 20));
+		crashk_res.start = crash_base;
+		crashk_res.end   = crash_base + crash_size - 1;
 	}
 }
 #else
diff -puN arch/x86/kernel/setup_64.c~use-bootmem_exclusive-for-kdump arch/x86/kernel/setup_64.c
--- a/arch/x86/kernel/setup_64.c~use-bootmem_exclusive-for-kdump
+++ a/arch/x86/kernel/setup_64.c
@@ -220,29 +220,35 @@ static inline void copy_edd(void)
 #ifdef CONFIG_KEXEC
 static void __init reserve_crashkernel(void)
 {
-	unsigned long long free_mem;
+	unsigned long long total_mem;
 	unsigned long long crash_size, crash_base;
 	int ret;
 
-	free_mem =
-		((unsigned long long)max_low_pfn - min_low_pfn) << PAGE_SHIFT;
+	total_mem = ((unsigned long long)max_low_pfn - min_low_pfn) << PAGE_SHIFT;
 
-	ret = parse_crashkernel(boot_command_line, free_mem,
+	ret = parse_crashkernel(boot_command_line, total_mem,
 			&crash_size, &crash_base);
 	if (ret == 0 && crash_size) {
-		if (crash_base > 0) {
-			printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
-					"for crashkernel (System RAM: %ldMB)\n",
-					(unsigned long)(crash_size >> 20),
-					(unsigned long)(crash_base >> 20),
-					(unsigned long)(free_mem >> 20));
-			crashk_res.start = crash_base;
-			crashk_res.end   = crash_base + crash_size - 1;
-			reserve_bootmem(crash_base, crash_size,
-					BOOTMEM_DEFAULT);
-		} else
+		if (crash_base <= 0) {
 			printk(KERN_INFO "crashkernel reservation failed - "
 					"you have to specify a base address\n");
+			return;
+		}
+
+		if (reserve_bootmem(crash_base, crash_size,
+					BOOTMEM_EXCLUSIVE) < 0) {
+			printk(KERN_INFO "crashkernel reservation failed - "
+					"memory is in use\n");
+			return;
+		}
+
+		printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
+				"for crashkernel (System RAM: %ldMB)\n",
+				(unsigned long)(crash_size >> 20),
+				(unsigned long)(crash_base >> 20),
+				(unsigned long)(total_mem >> 20));
+		crashk_res.start = crash_base;
+		crashk_res.end   = crash_base + crash_size - 1;
 	}
 }
 #else
_
