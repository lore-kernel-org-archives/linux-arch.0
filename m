From: yalin wang <yalin.wang2010@gmail.com>
Subject: [RFC] fixmap: change temp variable name
Date: Mon, 12 Oct 2015 16:08:28 +0800
Message-ID: <1444637308-23390-1-git-send-email-yalin.wang2010@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36757 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbbJLIIn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2015 04:08:43 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yalin wang <yalin.wang2010@gmail.com>

Change temp variable name addr to ____addr,
so that not conflict with the caller's variable name,
it will build error if call like this:
__set_fixmap_offset(idx, addr, flags)

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 include/asm-generic/fixmap.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 1cbb833..91ecaed 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -72,10 +72,10 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
 /* Return a pointer with offset calculated */
 #define __set_fixmap_offset(idx, phys, flags)		      \
 ({							      \
-	unsigned long addr;				      \
+	unsigned long ____addr;				      \
 	__set_fixmap(idx, phys, flags);			      \
-	addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1)); \
-	addr;						      \
+	____addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1)); \
+	____addr;						      \
 })
 
 #define set_fixmap_offset(idx, phys) \
-- 
1.9.1
