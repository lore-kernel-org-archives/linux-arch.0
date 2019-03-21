Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:38005 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbfCUMtd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Mar 2019 08:49:33 -0400
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH] [RESEND] bitops/find: Fix function description argument ordering
Date: Thu, 21 Mar 2019 13:48:33 +0100
Message-Id: <20190321124833.17630-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: arnd@arndb.de, corbet@lwn.net, tglx@linutronix.de, Anna-Maria Gleixner <anna-maria@linutronix.de>

The order of the arguments in function documentation doesn't fit with
the implementation. Change the documentation so that it corresponds to
the code. This prevents to confuse people reading the documentation.

While at it fixing the line breaks between the type of an argument and
the arguments name in function declaration for better readability.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 include/asm-generic/bitops/find.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 8a1ee10014de..30f0f8d0bd79 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -6,14 +6,15 @@
 /**
  * find_next_bit - find the next set bit in a memory region
  * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
  * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
  *
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
-		size, unsigned long offset);
+extern unsigned long
+find_next_bit(const unsigned long *addr, unsigned long size,
+	      unsigned long offset);
 #endif
 
 #ifndef find_next_and_bit
@@ -21,29 +22,30 @@ extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
  * find_next_and_bit - find the next set bit in both memory regions
  * @addr1: The first address to base the search on
  * @addr2: The second address to base the search on
- * @offset: The bitnumber to start searching at
  * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
  *
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-extern unsigned long find_next_and_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long size,
-		unsigned long offset);
+extern unsigned long
+find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
+		  unsigned long size, unsigned long offset);
 #endif
 
 #ifndef find_next_zero_bit
 /**
  * find_next_zero_bit - find the next cleared bit in a memory region
  * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
  * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
  *
  * Returns the bit number of the next zero bit
  * If no bits are zero, returns @size.
  */
-extern unsigned long find_next_zero_bit(const unsigned long *addr, unsigned
-		long size, unsigned long offset);
+extern unsigned long
+find_next_zero_bit(const unsigned long *addr, unsigned long size,
+		   unsigned long offset);
 #endif
 
 #ifdef CONFIG_GENERIC_FIND_FIRST_BIT
-- 
2.20.1
