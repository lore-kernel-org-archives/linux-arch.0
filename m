From: Nicolas Kaiser <nikai@nikai.net>
Subject: [PATCH] thp: unbalanced parenthesis
Date: Sat, 7 May 2011 20:55:49 +0200
Message-ID: <20110507205549.6bb0f49f@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from webhosting01.bon.m2soft.com ([195.38.20.32]:52682 "EHLO
	webhosting01.bon.m2soft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755983Ab1EGS5K (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 May 2011 14:57:10 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
Untested.

 include/asm-generic/pgtable.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index b4bfe33..b80daee 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -88,7 +88,7 @@ static inline pmd_t pmdp_get_and_clear(struct mm_struct *mm,
 	pmd_t pmd = *pmdp;
 	pmd_clear(mm, address, pmdp);
 	return pmd;
-})
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
-- 
1.7.5.rc3
