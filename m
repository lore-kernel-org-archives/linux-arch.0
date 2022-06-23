Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A72C43334
	for <linux-arch@archiver.kernel.org>; Thu, 23 Jun 2022 02:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiFWCun (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 22 Jun 2022 22:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiFWCum (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 22:50:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DBD13DC4
        for <linux-arch@vger.kernel.org>; Wed, 22 Jun 2022 19:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 737AE61D42
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 02:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88831C34114;
        Thu, 23 Jun 2022 02:50:38 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Fix the !THP build
Date:   Thu, 23 Jun 2022 10:52:00 +0800
Message-Id: <20220623025200.1824399-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fix the !THP build by making pmd_pfn() available in all configurations.
Because pmd_pfn() is used in mm/page_vma_mapped.c whether or not THP is
configured.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/pgtable.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 5dc84d8f18d6..d9e86cfa53e2 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -426,6 +426,11 @@ static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 
 #define kern_addr_valid(addr)	(1)
 
+static inline unsigned long pmd_pfn(pmd_t pmd)
+{
+	return (pmd_val(pmd) & _PFN_MASK) >> _PFN_SHIFT;
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
 /* We don't have hardware dirty/accessed bits, generic_pmdp_establish is fine.*/
@@ -497,11 +502,6 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pmd;
 }
 
-static inline unsigned long pmd_pfn(pmd_t pmd)
-{
-	return (pmd_val(pmd) & _PFN_MASK) >> _PFN_SHIFT;
-}
-
 static inline struct page *pmd_page(pmd_t pmd)
 {
 	if (pmd_trans_huge(pmd))
-- 
2.27.0

