Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35903 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfBSIQt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2019 03:16:49 -0500
Date: Tue, 19 Feb 2019 09:16:46 +0100
From: Hugo Lefeuvre <hle@owl.eu.com>
Subject: [PATCH] powerpc: iomap: add missing const to ioread addr argument
Message-ID: <20190219081646.GB2294@behemoth.owl.eu.com.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190219081646.KgjrYbgG7G5WKlg9nhdDmUOo_5VhmG_AgL0Llyz7A0U@z>

ioread*() signatures from include/asm-generic/iomap.h and lib/iomap.c
have been recently modified to add the missing const qualifier to the
addr parameter. This broke the powerpc build which still had ioread*()
definitions without the const (conflicting types).

Add const qualifier to ioread*() definitions from
arch/powerpc/kernel/iomap.c.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
 arch/powerpc/kernel/iomap.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/iomap.c b/arch/powerpc/kernel/iomap.c
index 5ac84efc6ede..9fe4fb3b08aa 100644
--- a/arch/powerpc/kernel/iomap.c
+++ b/arch/powerpc/kernel/iomap.c
@@ -15,23 +15,23 @@
  * Here comes the ppc64 implementation of the IOMAP 
  * interfaces.
  */
-unsigned int ioread8(void __iomem *addr)
+unsigned int ioread8(const void __iomem *addr)
 {
 	return readb(addr);
 }
-unsigned int ioread16(void __iomem *addr)
+unsigned int ioread16(const void __iomem *addr)
 {
 	return readw(addr);
 }
-unsigned int ioread16be(void __iomem *addr)
+unsigned int ioread16be(const void __iomem *addr)
 {
 	return readw_be(addr);
 }
-unsigned int ioread32(void __iomem *addr)
+unsigned int ioread32(const void __iomem *addr)
 {
 	return readl(addr);
 }
-unsigned int ioread32be(void __iomem *addr)
+unsigned int ioread32be(const void __iomem *addr)
 {
 	return readl_be(addr);
 }
@@ -41,27 +41,27 @@ EXPORT_SYMBOL(ioread16be);
 EXPORT_SYMBOL(ioread32);
 EXPORT_SYMBOL(ioread32be);
 #ifdef __powerpc64__
-u64 ioread64(void __iomem *addr)
+u64 ioread64(const void __iomem *addr)
 {
 	return readq(addr);
 }
-u64 ioread64_lo_hi(void __iomem *addr)
+u64 ioread64_lo_hi(const void __iomem *addr)
 {
 	return readq(addr);
 }
-u64 ioread64_hi_lo(void __iomem *addr)
+u64 ioread64_hi_lo(const void __iomem *addr)
 {
 	return readq(addr);
 }
-u64 ioread64be(void __iomem *addr)
+u64 ioread64be(const void __iomem *addr)
 {
 	return readq_be(addr);
 }
-u64 ioread64be_lo_hi(void __iomem *addr)
+u64 ioread64be_lo_hi(const void __iomem *addr)
 {
 	return readq_be(addr);
 }
-u64 ioread64be_hi_lo(void __iomem *addr)
+u64 ioread64be_hi_lo(const void __iomem *addr)
 {
 	return readq_be(addr);
 }
@@ -139,15 +139,15 @@ EXPORT_SYMBOL(iowrite64be_hi_lo);
  * FIXME! We could make these do EEH handling if we really
  * wanted. Not clear if we do.
  */
-void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread8_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	readsb(addr, dst, count);
 }
-void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread16_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	readsw(addr, dst, count);
 }
-void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread32_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	readsl(addr, dst, count);
 }
-- 
2.20.1
