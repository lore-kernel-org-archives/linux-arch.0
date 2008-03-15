Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from theia.rz.uni-saarland.de ([134.96.7.31]:13090 "EHLO
	theia.rz.uni-saarland.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbYCORcj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 15 Mar 2008 13:32:39 -0400
Date: Sat, 15 Mar 2008 18:30:57 +0100
From: Alexander van Heukelum <heukelum@mailshack.com>
Subject: [1/3] Introduce a generic __fls implementation
Message-ID: <20080315173056.GA21659@mailshack.com>
References: <20080315172913.GA21648@mailshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080315172913.GA21648@mailshack.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <andi@firstfloor.org>, LKML <linux-kernel@vger.kernel.org>, heukelum@fastmail.fm
Message-ID: <20080315173057.-1wv3K_qeEah38p0PlHHbdt4zJikH-Dga3hkEvuM0oM@z>

Add a generic __fls implementation in the same spirit as
the generic __ffs one. It finds the last (most significant)
set bit in the given long value.

Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>
---
 include/asm-generic/bitops/__fls.h |   43 ++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-generic/bitops/__fls.h

diff --git a/include/asm-generic/bitops/__fls.h b/include/asm-generic/bitops/__fls.h
new file mode 100644
index 0000000..be24465
--- /dev/null
+++ b/include/asm-generic/bitops/__fls.h
@@ -0,0 +1,43 @@
+#ifndef _ASM_GENERIC_BITOPS___FLS_H_
+#define _ASM_GENERIC_BITOPS___FLS_H_
+
+#include <asm/types.h>
+
+/**
+ * __fls - find last (most-significant) set bit in a long word
+ * @word: the word to search
+ *
+ * Undefined if no set bit exists, so code should check against 0 first.
+ */
+static inline unsigned long __fls(unsigned long word)
+{
+	int num = BITS_PER_LONG - 1;
+
+#if BITS_PER_LONG == 64
+	if (!(word & (~0ul << 32))) {
+		num -= 32;
+		word <<= 32;
+	}
+#endif
+	if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
+		num -= 16;
+		word <<= 16;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
+		num -= 8;
+		word <<= 8;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
+		num -= 4;
+		word <<= 4;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
+		num -= 2;
+		word <<= 2;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG-1))))
+		num -= 1;
+	return num;
+}
+
+#endif /* _ASM_GENERIC_BITOPS___FLS_H_ */

