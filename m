Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5217FC433EF
	for <linux-arch@archiver.kernel.org>; Tue,  5 Jul 2022 15:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiGEPu0 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 5 Jul 2022 11:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiGEPty (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2022 11:49:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394981D31F;
        Tue,  5 Jul 2022 08:48:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C59C861B2F;
        Tue,  5 Jul 2022 15:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A945CC385A9;
        Tue,  5 Jul 2022 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657036130;
        bh=KLRO24VwSLVIulcSBrEsq68hsqfeXNzy27r4Yp11+QA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GdrXl/xpgVVg8YOxhIc1ceTrw9pKv9FhQkwz1UEXm+27lUW9d5MgCTfJzzq4H0zxU
         DH4Zdk5p2rI3NgRROs/gqUH6QnF2naI1n3Xj9kniWdfPyWHv7EzPMQm/6vrOb3mGru
         Ns3ekv3193vDT4yBwRa3tByMpmPYaD4ycpGFe3a2dOobnrqj0IA6kyVR/aTRdWvm4r
         qWXKPvRQ0PS2iUo/8PdMtrfM8+0M4fllLxebI2/x+C5TZ73uUPPMGVw4PpKIzSklV3
         NAROaW7bpnOghvYVskifhYpquvhD20yHgMV6oyOBoGeskXT24OzJY599Idb/zgLrgY
         fvpnqRFkiizdw==
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
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        WANG Xuerui <kernel@xen0n.name>, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        loongarch@lists.linux.dev
Subject: [PATCH v2 14/15] xtensa: drop definition of PGD_ORDER
Date:   Tue,  5 Jul 2022 18:47:07 +0300
Message-Id: <20220705154708.181258-15-rppt@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220705154708.181258-1-rppt@kernel.org>
References: <20220705154708.181258-1-rppt@kernel.org>
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

