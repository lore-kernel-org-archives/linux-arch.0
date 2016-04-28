Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38799 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbcD1NYU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Apr 2016 09:24:20 -0400
From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 09/20] parisc: get rid of superfluous __GFP_REPEAT
Date: Thu, 28 Apr 2016 15:23:55 +0200
Message-ID: <1461849846-27209-10-git-send-email-mhocko@kernel.org>
In-Reply-To: <1461849846-27209-1-git-send-email-mhocko@kernel.org>
References: <1461849846-27209-1-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-arch@vger.kernel.org
Message-ID: <20160428132355.cBsrd3G_F_tbBs3Uv_m7Ux_cqDbv3DBF6bHo6bdK8t0@z>

From: Michal Hocko <mhocko@suse.com>

__GFP_REPEAT has a rather weak semantic but since it has been introduced
around 2.6.12 it has been ignored for low order allocations.

pmd_alloc_one allocate PMD_ORDER which is 1. This means that this flag
has never been actually useful here because it has always been used only
for PAGE_ALLOC_COSTLY requests.

Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/parisc/include/asm/pgalloc.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
index 52c3defb40c9..f08dda3f0995 100644
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -63,8 +63,7 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmd)
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	pmd_t *pmd = (pmd_t *)__get_free_pages(GFP_KERNEL|__GFP_REPEAT,
-					       PMD_ORDER);
+	pmd_t *pmd = (pmd_t *)__get_free_pages(GFP_KERNEL, PMD_ORDER);
 	if (pmd)
 		memset(pmd, 0, PAGE_SIZE<<PMD_ORDER);
 	return pmd;
-- 
2.8.0.rc3

