Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58580 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394Ab1B0QCC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 27 Feb 2011 11:02:02 -0500
From: Guan Xuetao <epip@hera.kernel.org>
Subject: [PATCH 11/17] unicore32 upgrade to v2.6.38-rc5: add one more paramter for pte_alloc_map call
Date: Sun, 27 Feb 2011 15:59:39 +0000
Message-ID: <1719ac5c8ece25521c6a85c21d1ca4a7f508be34.1298821856.git.epip@hera.kernel.org>
In-Reply-To: <cover.1298821856.git.epip@hera.kernel.org>
References: <cover.1298821856.git.epip@hera.kernel.org>
In-Reply-To: <cover.1298821856.git.epip@hera.kernel.org>
References: <cover.1298821856.git.epip@hera.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: GuanXuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, greg@kroah.com
Message-ID: <20110227155939.Kq5El46SBY1w6vucrBEbUk1NPtIUUan1Y1duJb5tmOU@z>

From: GuanXuetao <gxt@mprc.pku.edu.cn>

Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
---
 arch/unicore32/mm/pgd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/unicore32/mm/pgd.c b/arch/unicore32/mm/pgd.c
index 632cef7..08b8d42 100644
--- a/arch/unicore32/mm/pgd.c
+++ b/arch/unicore32/mm/pgd.c
@@ -54,7 +54,7 @@ pgd_t *get_pgd_slow(struct mm_struct *mm)
 		if (!new_pmd)
 			goto no_pmd;
 
-		new_pte = pte_alloc_map(mm, new_pmd, 0);
+		new_pte = pte_alloc_map(mm, NULL, new_pmd, 0);
 		if (!new_pte)
 			goto no_pte;
 
-- 
1.7.4.1

