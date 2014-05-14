Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:62422 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbaENTII (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 May 2014 15:08:08 -0400
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 15/27] microblaze: Use generic tlb.h
Date: Wed, 14 May 2014 20:59:47 +0200
Message-ID: <1400093999-18703-16-git-send-email-richard@nod.at>
In-Reply-To: <1400093999-18703-1-git-send-email-richard@nod.at>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Michal Simek <monstr@monstr.eu>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20140514185947.VSqetWjpTxGj7l71_OPZlHlraSaSm1JduFHBYziSpqw@z>

As everything we need is now in generic tlb.h
we can drop our own one.

Cc: Michal Simek <monstr@monstr.eu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/microblaze/include/asm/Kbuild |  1 +
 arch/microblaze/include/asm/tlb.h  | 25 -------------------------
 2 files changed, 1 insertion(+), 25 deletions(-)
 delete mode 100644 arch/microblaze/include/asm/tlb.h

diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index c98ed95..7908c58 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -7,4 +7,5 @@ generic-y += hash.h
 generic-y += mcs_spinlock.h
 generic-y += preempt.h
 generic-y += syscalls.h
+generic-y += tlb.h
 generic-y += trace_clock.h
diff --git a/arch/microblaze/include/asm/tlb.h b/arch/microblaze/include/asm/tlb.h
deleted file mode 100644
index 8aa9781..0000000
--- a/arch/microblaze/include/asm/tlb.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * Copyright (C) 2008-2009 Michal Simek <monstr@monstr.eu>
- * Copyright (C) 2008-2009 PetaLogix
- * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_MICROBLAZE_TLB_H
-#define _ASM_MICROBLAZE_TLB_H
-
-#define tlb_flush(tlb)	flush_tlb_mm((tlb)->mm)
-
-#include <linux/pagemap.h>
-#include <asm-generic/tlb.h>
-
-#ifdef CONFIG_MMU
-#define tlb_start_vma(tlb, vma)		do { } while (0)
-#define tlb_end_vma(tlb, vma)		do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
-#endif
-
-#endif /* _ASM_MICROBLAZE_TLB_H */
-- 
1.8.4.2

