From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 18/27] openrisc: Use generic tlb.h
Date: Wed, 14 May 2014 20:59:50 +0200
Message-ID: <1400093999-18703-19-git-send-email-richard@nod.at>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
In-Reply-To: <1400093999-18703-1-git-send-email-richard@nod.at>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, "David S. Miller" <davem@davemloft.net>, linux@lists.openrisc.net, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

As everything we need is now in generic tlb.h
we can drop our own one.

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux@lists.openrisc.net
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/openrisc/include/asm/Kbuild |  1 +
 arch/openrisc/include/asm/tlb.h  | 34 ----------------------------------
 2 files changed, 1 insertion(+), 34 deletions(-)
 delete mode 100644 arch/openrisc/include/asm/tlb.h

diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 480af0d..abe411f 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -63,6 +63,7 @@ generic-y += swab.h
 generic-y += switch_to.h
 generic-y += termbits.h
 generic-y += termios.h
+generic-y += tlb.h
 generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += types.h
diff --git a/arch/openrisc/include/asm/tlb.h b/arch/openrisc/include/asm/tlb.h
deleted file mode 100644
index fa4376a..0000000
--- a/arch/openrisc/include/asm/tlb.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * OpenRISC Linux
- *
- * Linux architectural port borrowing liberally from similar works of
- * others.  All original copyrights apply as per the original source
- * declaration.
- *
- * OpenRISC implementation:
- * Copyright (C) 2003 Matjaz Breskvar <phoenix@bsemi.com>
- * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
- * et al.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef __ASM_OPENRISC_TLB_H__
-#define __ASM_OPENRISC_TLB_H__
-
-/*
- * or32 doesn't need any special per-pte or
- * per-vma handling..
- */
-#define tlb_start_vma(tlb, vma) do { } while (0)
-#define tlb_end_vma(tlb, vma) do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
-
-#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
-#include <linux/pagemap.h>
-#include <asm-generic/tlb.h>
-
-#endif /* __ASM_OPENRISC_TLB_H__ */
-- 
1.8.4.2
