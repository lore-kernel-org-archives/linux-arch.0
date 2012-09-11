Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:61467 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758556Ab2IKQr3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 11 Sep 2012 12:47:29 -0400
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 1/3] mm: thp: Fix the pmd_clear() arguments in pmdp_get_and_clear()
Date: Tue, 11 Sep 2012 17:47:14 +0100
Message-ID: <1347382036-18455-2-git-send-email-will.deacon@arm.com>
In-Reply-To: <1347382036-18455-1-git-send-email-will.deacon@arm.com>
References: <1347382036-18455-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, mhocko@suse.cz, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Steve Capper <steve.capper@arm.com>, Will Deacon <will.deacon@arm.com>
Message-ID: <20120911164714.5Nat64M3iT_uJVptaFiLbKsV5mgp_Y_6TR6QMmxaPz0@z>

From: Catalin Marinas <catalin.marinas@arm.com>

The CONFIG_TRANSPARENT_HUGEPAGE implementation of pmdp_get_and_clear()
calls pmd_clear() with 3 arguments instead of 1.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/pgtable.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index ff4947b..f7e0206 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -87,7 +87,7 @@ static inline pmd_t pmdp_get_and_clear(struct mm_struct *mm,
 				       pmd_t *pmdp)
 {
 	pmd_t pmd = *pmdp;
-	pmd_clear(mm, address, pmdp);
+	pmd_clear(pmdp);
 	return pmd;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-- 
1.7.4.1

