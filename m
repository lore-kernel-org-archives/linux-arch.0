Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out-183.synserver.de ([212.40.185.183]:1138 "EHLO
	smtp-out-183.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab2KAKak (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2012 06:30:40 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] asm-generic/mmu.h: Remove unused vmlist field from mm_context_t
Date: Thu,  1 Nov 2012 11:24:23 +0100
Message-ID: <1351765467-29244-1-git-send-email-lars@metafoo.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <20121101102423.x27TOMIot1cepJhmvwtNJqgzT83Q7Utv4eTXUVSZlQ8@z>

Nothing is using the vmlist field in mm_context_t anymore. It has been removed
from the non-generic versions over 3 years ago 8feae1311 ("NOMMU: Make VMAs per
MM as for MMU-mode linux").

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/asm-generic/mmu.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/mmu.h b/include/asm-generic/mmu.h
index 4f4aa56..a67ae0a9 100644
--- a/include/asm-generic/mmu.h
+++ b/include/asm-generic/mmu.h
@@ -7,7 +7,6 @@
  */
 #ifndef __ASSEMBLY__
 typedef struct {
-	struct vm_list_struct	*vmlist;
 	unsigned long		end_brk;
 } mm_context_t;
 #endif
-- 
1.7.2.5

