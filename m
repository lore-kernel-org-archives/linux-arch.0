Return-Path: <SRS0=4doj=BL=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbgHABO4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Jul 2020 21:14:56 -0400
From: guoren@kernel.org
Subject: [PATCH 10/13] csky: Fixup warning by EXPORT_SYMBOL(kmap)
Date: Sat,  1 Aug 2020 01:14:10 +0000
Message-ID: <1596244453-98575-11-git-send-email-guoren@kernel.org>
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: guoren@kernel.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Message-ID: <20200801011410.TzWyfi4IRa-aECrqpmLBQp-x547pRK2NAWELjvbtpfg@z>

From: Guo Ren <guoren@linux.alibaba.com>

This a wrong code, and no kmap symbol for export.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/mm/highmem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/csky/mm/highmem.c b/arch/csky/mm/highmem.c
index 89ec32e..89c1080 100644
--- a/arch/csky/mm/highmem.c
+++ b/arch/csky/mm/highmem.c
@@ -19,8 +19,6 @@ void kmap_flush_tlb(unsigned long addr)
 }
 EXPORT_SYMBOL(kmap_flush_tlb);
 
-EXPORT_SYMBOL(kmap);
-
 void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
 {
 	unsigned long vaddr;
-- 
2.7.4
