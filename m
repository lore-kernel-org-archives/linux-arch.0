From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 07/27] blackfin: Use generic tlb.h
Date: Wed, 14 May 2014 20:59:39 +0200
Message-ID: <1400093999-18703-8-git-send-email-richard@nod.at>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:62410 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226AbaENTIG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 May 2014 15:08:06 -0400
In-Reply-To: <1400093999-18703-1-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Steven Miao <realmz6@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, adi-buildroot-devel@lists.sourceforge.net

As everything we need is now in generic tlb.h
we can drop our own one.

Cc: Steven Miao <realmz6@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Richard Weinberger <richard@nod.at>
Cc: adi-buildroot-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/blackfin/include/asm/Kbuild |  1 +
 arch/blackfin/include/asm/tlb.h  | 22 ----------------------
 2 files changed, 1 insertion(+), 22 deletions(-)
 delete mode 100644 arch/blackfin/include/asm/tlb.h

diff --git a/arch/blackfin/include/asm/Kbuild b/arch/blackfin/include/asm/Kbuild
index 0d93b9a..d4fdbc0 100644
--- a/arch/blackfin/include/asm/Kbuild
+++ b/arch/blackfin/include/asm/Kbuild
@@ -40,6 +40,7 @@ generic-y += sockios.h
 generic-y += statfs.h
 generic-y += termbits.h
 generic-y += termios.h
+generic-y += tlb.h
 generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += types.h
diff --git a/arch/blackfin/include/asm/tlb.h b/arch/blackfin/include/asm/tlb.h
deleted file mode 100644
index a74ae08..0000000
--- a/arch/blackfin/include/asm/tlb.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Copyright 2004-2008 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-
-#ifndef _BLACKFIN_TLB_H
-#define _BLACKFIN_TLB_H
-
-#define tlb_start_vma(tlb, vma)	do { } while (0)
-#define tlb_end_vma(tlb, vma)	do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address)	do { } while (0)
-
-/*
- * .. because we flush the whole mm when it
- * fills up.
- */
-#define tlb_flush(tlb)		flush_tlb_mm((tlb)->mm)
-
-#include <asm-generic/tlb.h>
-
-#endif				/* _BLACKFIN_TLB_H */
-- 
1.8.4.2
