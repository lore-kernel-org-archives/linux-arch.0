Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbeJDAkd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Oct 2018 20:40:33 -0400
From: James Morse <james.morse@arm.com>
Subject: [PATCH] asm-generic/pgtable-nop?d.h: define folded with a value for use in C
Date: Wed,  3 Oct 2018 18:50:52 +0100
Message-ID: <20181003175052.31917-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20181003175052.c5wsw-adHPkSLr0wKc1RMItpkvKn2BJFA2rDn3RzF_g@z>

It turns out "if (__is_defined(__PAGETABLE_PMD_FOLDED))" isn't equivalent
to "#ifdef __PAGETABLE_PMD_FOLDED". (who knew!)

kconfig.h's __is_defined() expects a define of the form
"#define CONFIG_BOOGER 1". But these nop?d headers just have
"#define __PAGETABLE_PMD_FOLDED".

This means ____is_defined()'s triplet passed to __take_second_arg() is
'empty-string, 1 0' in both cases, meaning these symbols can't be used
from C. (they are always false).

asm-generic gets away with this as its using the pre-processor's
defined() macro on this, not the C __is_defined().

Add the expected '1'.

Signed-off-by: James Morse <james.morse@arm.com>
CC: Mark Rutland <mark.rutland@arm.com>
---
This fixes an issue with patches queued for arm64. Can it go via the arm64 tree?
Link: lore.kernel.org/r/0f9a3abc-4890-faf5-ee7e-18434641b858@arm.com



 include/asm-generic/pgtable-nopmd.h | 2 +-
 include/asm-generic/pgtable-nopud.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index f35f6e8149e4..fcb4769a075a 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -8,7 +8,7 @@
 
 struct mm_struct;
 
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED	1
 
 /*
  * Having the pmd type consist of a pud gets the size right, and allows
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index e950b9c50f34..d300dbcddaf3 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -9,7 +9,7 @@
 #else
 #include <asm-generic/pgtable-nop4d.h>
 
-#define __PAGETABLE_PUD_FOLDED
+#define __PAGETABLE_PUD_FOLDED	1
 
 /*
  * Having the pud type consist of a p4d gets the size right, and allows
-- 
2.19.0
