Return-Path: <SRS0=aRn0=2U=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbfL3IYW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Dec 2019 03:24:22 -0500
From: guoren@kernel.org
Subject: [PATCH 5/5] csky/mm: Fixup export invalid_pte_table symbol
Date: Mon, 30 Dec 2019 16:23:31 +0800
Message-ID: <20191230082331.30976-5-guoren@kernel.org>
In-Reply-To: <20191230082331.30976-1-guoren@kernel.org>
References: <20191230082331.30976-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-csky@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, Guo Ren <ren_guo@c-sky.com>, Mo Qihui <qihui.mo@verisilicon.com>, Zhange Jian <zhang_jian5@dahuatech.com>
Message-ID: <20191230082331.R2ypsQnde39NQL4_dAhlntuFH8ClYLWBa1qsZ4zzeLE@z>

From: Guo Ren <ren_guo@c-sky.com>

There is no present bit in csky pmd hardware, so we need to prepare invalid_pte_table
for empty pmd entry and the functions (pmd_none & pmd_present) in pgtable.h need
invalid_pte_talbe to get result. If a module use these functions, we need export the
symbol for it.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Mo Qihui <qihui.mo@verisilicon.com>
Cc: Zhange Jian <zhang_jian5@dahuatech.com>
---
 arch/csky/mm/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index 322eb7bd7962..dbb4b2dfe4b7 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -31,6 +31,7 @@
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
+EXPORT_SYMBOL(invalid_pte_table);
 unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 						__page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
-- 
2.17.0
