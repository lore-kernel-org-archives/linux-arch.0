Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393471AbfBNP7v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Feb 2019 10:59:51 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EFgr7C104080
        for <linux-arch@vger.kernel.org>; Thu, 14 Feb 2019 10:59:50 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qnavjatpj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 14 Feb 2019 10:59:49 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 14 Feb 2019 15:59:47 -0000
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 1/4] init: provide a generic free_initmem implementation
Date: Thu, 14 Feb 2019 17:59:34 +0200
In-Reply-To: <1550159977-8949-1-git-send-email-rppt@linux.ibm.com>
References: <1550159977-8949-1-git-send-email-rppt@linux.ibm.com>
Message-ID: <1550159977-8949-2-git-send-email-rppt@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>, Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, Mike Rapoport <rppt@linux.ibm.com>
Message-ID: <20190214155934.6VTegrg7FlAIIStgBpQgJA6_igZrsUCE7Rsb-db39gc@z>

For most architectures free_initmem just a wrapper for the same
free_initmem_default(-1) call.
Provide that as a generic implementation marked __weak.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/alpha/mm/init.c      | 6 ------
 arch/arc/mm/init.c        | 8 --------
 arch/c6x/mm/init.c        | 5 -----
 arch/h8300/mm/init.c      | 6 ------
 arch/microblaze/mm/init.c | 5 -----
 arch/nds32/mm/init.c      | 5 -----
 arch/nios2/mm/init.c      | 5 -----
 arch/openrisc/mm/init.c   | 5 -----
 arch/sh/mm/init.c         | 5 -----
 arch/unicore32/mm/init.c  | 5 -----
 arch/xtensa/mm/init.c     | 5 -----
 init/main.c               | 5 +++++
 12 files changed, 5 insertions(+), 60 deletions(-)

diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
index a42fc5c..8a8ac09 100644
--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -286,12 +286,6 @@ mem_init(void)
 	mem_init_print_info(NULL);
 }
 
-void
-free_initmem(void)
-{
-	free_initmem_default(-1);
-}
-
 #ifdef CONFIG_BLK_DEV_INITRD
 void
 free_initrd_mem(unsigned long start, unsigned long end)
diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index e1ab2d7..1d08736 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -207,14 +207,6 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 }
 
-/*
- * free_initmem: Free all the __init memory.
- */
-void __ref free_initmem(void)
-{
-	free_initmem_default(-1);
-}
-
 #ifdef CONFIG_BLK_DEV_INITRD
 void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
diff --git a/arch/c6x/mm/init.c b/arch/c6x/mm/init.c
index af5ada0..ca1c182 100644
--- a/arch/c6x/mm/init.c
+++ b/arch/c6x/mm/init.c
@@ -73,8 +73,3 @@ void __init free_initrd_mem(unsigned long start, unsigned long end)
 	free_reserved_area((void *)start, (void *)end, -1, "initrd");
 }
 #endif
-
-void __init free_initmem(void)
-{
-	free_initmem_default(-1);
-}
diff --git a/arch/h8300/mm/init.c b/arch/h8300/mm/init.c
index 6519252..fabf9e3 100644
--- a/arch/h8300/mm/init.c
+++ b/arch/h8300/mm/init.c
@@ -108,9 +108,3 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 	free_reserved_area((void *)start, (void *)end, -1, "initrd");
 }
 #endif
-
-void
-free_initmem(void)
-{
-	free_initmem_default(-1);
-}
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index b17fd8a..4d6fa630 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -193,11 +193,6 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 }
 #endif
 
-void free_initmem(void)
-{
-	free_initmem_default(-1);
-}
-
 void __init mem_init(void)
 {
 	high_memory = (void *)__va(memory_start + lowmem_size - 1);
diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
index 253f79f..8a1563e 100644
--- a/arch/nds32/mm/init.c
+++ b/arch/nds32/mm/init.c
@@ -244,11 +244,6 @@ void __init mem_init(void)
 	return;
 }
 
-void free_initmem(void)
-{
-	free_initmem_default(-1);
-}
-
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index 16cea57..362a7a7 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -89,11 +89,6 @@ void __init free_initrd_mem(unsigned long start, unsigned long end)
 }
 #endif
 
-void __ref free_initmem(void)
-{
-	free_initmem_default(-1);
-}
-
 #define __page_aligned(order) __aligned(PAGE_SIZE << (order))
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned(PGD_ORDER);
 pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned(PTE_ORDER);
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index d157310..bf3a160 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -227,8 +227,3 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 	free_reserved_area((void *)start, (void *)end, -1, "initrd");
 }
 #endif
-
-void free_initmem(void)
-{
-	free_initmem_default(-1);
-}
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index a8e5c0e..bc59332 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -405,11 +405,6 @@ void __init mem_init(void)
 	mem_init_done = 1;
 }
 
-void free_initmem(void)
-{
-	free_initmem_default(-1);
-}
-
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index 85ef2c6..3aed4d5 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -312,11 +312,6 @@ void __init mem_init(void)
 	}
 }
 
-void free_initmem(void)
-{
-	free_initmem_default(-1);
-}
-
 #ifdef CONFIG_BLK_DEV_INITRD
 
 static int keep_initrd;
diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index d498610..b51746f 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -216,11 +216,6 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 }
 #endif
 
-void free_initmem(void)
-{
-	free_initmem_default(-1);
-}
-
 static void __init parse_memmap_one(char *p)
 {
 	char *oldp;
diff --git a/init/main.c b/init/main.c
index c86a1c8..38d69e0 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1047,6 +1047,11 @@ static inline void mark_readonly(void)
 }
 #endif
 
+void __weak free_initmem(void)
+{
+	free_initmem_default(-1);
+}
+
 static int __ref kernel_init(void *unused)
 {
 	int ret;
-- 
2.7.4
