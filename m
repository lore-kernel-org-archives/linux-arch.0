From: Cody P Schafer <cody@linux.vnet.ibm.com>
Subject: [PATCH] bitops/find: clarify and extend documentation
Date: Fri, 25 Oct 2013 12:48:24 -0700
Message-ID: <1382730504-1772-1-git-send-email-cody@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:39689 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753020Ab3JYTtR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Oct 2013 15:49:17 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <cody@linux.vnet.ibm.com>;
	Fri, 25 Oct 2013 15:49:15 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>, Cody P Schafer <cody@linux.vnet.ibm.com>

Add return value documentation and clarify the units of the @size
parameter.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 include/asm-generic/bitops/find.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 71c7780..998d4d5 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -7,6 +7,9 @@
  * @addr: The address to base the search on
  * @offset: The bitnumber to start searching at
  * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the next set bit
+ * If no bits are set, returns @size.
  */
 extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
 		size, unsigned long offset);
@@ -18,6 +21,9 @@ extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
  * @addr: The address to base the search on
  * @offset: The bitnumber to start searching at
  * @size: The bitmap size in bits
+ *
+ * Returns the bit number of the next zero bit
+ * If no bits are zero, returns @size.
  */
 extern unsigned long find_next_zero_bit(const unsigned long *addr, unsigned
 		long size, unsigned long offset);
@@ -28,9 +34,10 @@ extern unsigned long find_next_zero_bit(const unsigned long *addr, unsigned
 /**
  * find_first_bit - find the first set bit in a memory region
  * @addr: The address to start the search at
- * @size: The maximum size to search
+ * @size: The maximum number of bits to search
  *
  * Returns the bit number of the first set bit.
+ * If no bits are set, returns @size.
  */
 extern unsigned long find_first_bit(const unsigned long *addr,
 				    unsigned long size);
@@ -38,9 +45,10 @@ extern unsigned long find_first_bit(const unsigned long *addr,
 /**
  * find_first_zero_bit - find the first cleared bit in a memory region
  * @addr: The address to start the search at
- * @size: The maximum size to search
+ * @size: The maximum number of bits to search
  *
  * Returns the bit number of the first cleared bit.
+ * If no bits are zero, returns @size.
  */
 extern unsigned long find_first_zero_bit(const unsigned long *addr,
 					 unsigned long size);
-- 
1.8.1.5
