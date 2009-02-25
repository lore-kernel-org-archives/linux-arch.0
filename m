From: Justin Chen <jchen@hpdst41.cup.hp.com>
Subject: [PATCH 05/15] bitops: Change the bitmap index from int to unsigned long [cris]
Date: Tue, 24 Feb 2009 20:49:03 -0800 (PST)
Message-ID: <200902250449.UAA12761@hpdst41.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:21213 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbZBYErA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Feb 2009 23:47:00 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: bjorn.helgaas@hp.com, jesper.nilsson@axis.com, justin.chen@hp.com, linux-kernel@vger.kernel.org, starvik@axis.com

Change the index to unsigned long in all bitops for [cris]

Signed-off-by: Justin Chen <justin.chen@hp.com>
Reviewed-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/cris/include/asm/bitops.h |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
diff -Nru a/arch/cris/include/asm/bitops.h b/arch/cris/include/asm/bitops.h
--- a/arch/cris/include/asm/bitops.h	2009-02-13 15:31:30.000000000 -0800
+++ b/arch/cris/include/asm/bitops.h	2009-02-15 18:19:39.771556647 -0800
@@ -70,7 +70,8 @@
  * It also implies a memory barrier.
  */
 
-static inline int test_and_set_bit(int nr, volatile unsigned long *addr)
+static inline int
+test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned int mask, retval;
 	unsigned long flags;
@@ -100,7 +101,8 @@
  * It also implies a memory barrier.
  */
 
-static inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
+static inline int
+test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned int mask, retval;
 	unsigned long flags;
@@ -124,7 +126,8 @@
  * It also implies a memory barrier.
  */
 
-static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
+static inline int
+test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned int mask, retval;
 	unsigned long flags;
