From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] locking/qrwlock: include asm/byteorder.h as needed
Date: Fri,  2 Feb 2018 16:40:44 +0100
Message-ID: <20180202154104.1522809-1-arnd@arndb.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:53832 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeBBPlv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Feb 2018 10:41:51 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>, Babu Moger <babu.moger@oracle.com>, Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Moving the qrwlock struct definition into a header file introduced
a subtle bug on all little-endian machines, where some files in some
configurations would see the fields in an incorrect order.  This was
found by building with an LTO enabled compiler that warns every time we
try to link together files with incompatible data structures.

A second patch changes linux/kconfig.h to always define the symbols,
but this seems to be the root cause of most of the issues, so I'd suggest
we do both.

On a current linux-next kernel, I verified that this header is
responsible for all type mismatches as a result from the endianess
confusion.

Cc: stable@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: e0d02285f16e ("locking/qrwlock: Use 'struct qrwlock' instead of 'struct __qrwlock'")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/qrwlock_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/qrwlock_types.h b/include/asm-generic/qrwlock_types.h
index 137ecdd16daa..c36f1d5a2572 100644
--- a/include/asm-generic/qrwlock_types.h
+++ b/include/asm-generic/qrwlock_types.h
@@ -3,6 +3,7 @@
 #define __ASM_GENERIC_QRWLOCK_TYPES_H
 
 #include <linux/types.h>
+#include <asm/byteorder.h>
 #include <asm/spinlock_types.h>
 
 /*
-- 
2.9.0
