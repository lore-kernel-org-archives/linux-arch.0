Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27731 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284AbaLXMXe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Dec 2014 07:23:34 -0500
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 08/38] asm-generic: drop unused pte_file* helpers
Date: Wed, 24 Dec 2014 14:22:16 +0200
Message-ID: <1419423766-114457-9-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1419423766-114457-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1419423766-114457-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, mingo@kernel.org, davej@redhat.com, sasha.levin@oracle.com, hughd@google.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20141224122216.poEZtpOSZlcDZzPzlujHtUVT6UGavT3b7iwZ60u9UuA@z>

All users are gone.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/pgtable.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 177d5973b132..129de9204d18 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -474,21 +474,6 @@ static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
 {
 	return pte;
 }
-
-static inline pte_t pte_file_clear_soft_dirty(pte_t pte)
-{
-       return pte;
-}
-
-static inline pte_t pte_file_mksoft_dirty(pte_t pte)
-{
-       return pte;
-}
-
-static inline int pte_file_soft_dirty(pte_t pte)
-{
-       return 0;
-}
 #endif
 
 #ifndef __HAVE_PFNMAP_TRACKING
-- 
2.1.3

