From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 02/10] microblaze: Remove architecture tlb.h and use generic one
Date: Wed, 12 Feb 2020 09:57:59 +0100
Message-ID: <1243cf3b894f81b728011621b2fd3d40b8935e99.1581497860.git.michal.simek@xilinx.com>
References: <cover.1581497860.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42907 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgBLI6P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 03:58:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id k11so1178597wrd.9
        for <linux-arch@vger.kernel.org>; Wed, 12 Feb 2020 00:58:13 -0800 (PST)
In-Reply-To: <cover.1581497860.git.michal.simek@xilinx.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc: Stefan Asserhall <stefan.asserhall@xilinx.com>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Nick Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org

There is no reason to have this empty file if it is just link to
asm-generic/tlb.h.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
---

 arch/microblaze/include/asm/Kbuild |  1 +
 arch/microblaze/include/asm/tlb.h  | 17 -----------------
 2 files changed, 1 insertion(+), 17 deletions(-)
 delete mode 100644 arch/microblaze/include/asm/tlb.h

diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index e5c9170a07fc..7ae427f73105 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -31,6 +31,7 @@ generic-y += preempt.h
 generic-y += serial.h
 generic-y += shmparam.h
 generic-y += syscalls.h
+generic-y += tlb.h
 generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += vga.h
diff --git a/arch/microblaze/include/asm/tlb.h b/arch/microblaze/include/asm/tlb.h
deleted file mode 100644
index 628a78ee0a72..000000000000
--- a/arch/microblaze/include/asm/tlb.h
+++ /dev/null
@@ -1,17 +0,0 @@
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
-#include <linux/pagemap.h>
-#include <asm-generic/tlb.h>
-
-#endif /* _ASM_MICROBLAZE_TLB_H */
-- 
2.25.0
