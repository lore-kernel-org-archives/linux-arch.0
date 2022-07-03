Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99C8CCA47C
	for <linux-arch@archiver.kernel.org>; Sun,  3 Jul 2022 14:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiGCOOl (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 3 Jul 2022 10:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiGCOOK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Jul 2022 10:14:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6766241;
        Sun,  3 Jul 2022 07:13:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01C69B80934;
        Sun,  3 Jul 2022 14:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5AAC341CD;
        Sun,  3 Jul 2022 14:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656857622;
        bh=KLRO24VwSLVIulcSBrEsq68hsqfeXNzy27r4Yp11+QA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKbuVa8nJocjDSLME19wodPND/eY3ci7mQaF2VF0RkS16prNJC/Rx+KipYzlLUbam
         2wQ+uslUOousId9kaRS1+QWGhkDYQywa++8rU0JKfY2gJkAckNQusF7YPzgSQ+mEk2
         QchHMdRcdcmh99r/g4QLh0PJMLUztvRFIVTVjBx7GxTSCcljhdGSAneGc/d4iCfH3x
         V90hUAAZO/8WAjzKftMl55V30VyAI73t+KTfUFTLOcxted0sWUDR5CE5N9qNy1M1IO
         zw3p8ZDEJ+vrUCctdipz2oetV89iAHqZWjZAjuJ3nUEpHTQLFqra8Nd4JSPI9MqlGS
         jfN6ddFVC5OTg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@kernel.org>,
        Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        WANG Xuerui <kernel@xen0n.name>, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        loongarch@lists.linux.dev
Subject: [PATCH 14/14] xtensa: drop definition of PGD_ORDER
Date:   Sun,  3 Jul 2022 17:12:03 +0300
Message-Id: <20220703141203.147893-15-rppt@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220703141203.147893-1-rppt@kernel.org>
References: <20220703141203.147893-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

This is the order of the page table allocation, not the order of a PGD.
Since its always hardwired to 0, simply drop it.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/xtensa/include/asm/pgalloc.h | 2 +-
 arch/xtensa/include/asm/pgtable.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/xtensa/include/asm/pgalloc.h b/arch/xtensa/include/asm/pgalloc.h
index eeb2de3a89e5..7fc0f9126dd3 100644
--- a/arch/xtensa/include/asm/pgalloc.h
+++ b/arch/xtensa/include/asm/pgalloc.h
@@ -29,7 +29,7 @@
 static inline pgd_t*
 pgd_alloc(struct mm_struct *mm)
 {
-	return (pgd_t*) __get_free_pages(GFP_KERNEL | __GFP_ZERO, PGD_ORDER);
+	return (pgd_t*) __get_free_page(GFP_KERNEL | __GFP_ZERO);
 }
 
 static inline void ptes_clear(pte_t *ptep)
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index 0a91376131c5..4bd77d2b6715 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -57,7 +57,6 @@
 #define PTRS_PER_PTE		1024
 #define PTRS_PER_PTE_SHIFT	10
 #define PTRS_PER_PGD		1024
-#define PGD_ORDER		0
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
 #define FIRST_USER_PGD_NR	(FIRST_USER_ADDRESS >> PGDIR_SHIFT)
 
-- 
2.34.1

