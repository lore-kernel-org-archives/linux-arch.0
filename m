From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: [RFC v2][PATCH 30/35] m68k: use pte_offset_kernel() as base for pte_offset_map*()
Date: Wed, 20 May 2009 11:25:32 -0700
Message-ID: <20090520182532.2367A9B9@kernel>
References: <20090520182445.D7B49A7C@kernel>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:35511 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756736AbZETSZg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 May 2009 14:25:36 -0400
In-Reply-To: <20090520182445.D7B49A7C@kernel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>


Some architectures use pte_offset_map() as a basis for
pte_offset_kernel().  Others do the inverse.

Although arbitrary, Using pte_offset_kernel() as the base
seems a wee bit more popular and it also fits in well
with the way I'm breaking out the headers.

Instead of coding the same implementation twice, this
makes pte_offset_map{,_nested}() call pte_offset_kernel()
directly.


Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/arch/m68k/include/asm/ptemap.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/m68k/include/asm/ptemap.h~m68k-pte_offset_kernel arch/m68k/include/asm/ptemap.h
--- linux-2.6.git/arch/m68k/include/asm/ptemap.h~m68k-pte_offset_kernel	2009-04-30 15:11:10.000000000 -0700
+++ linux-2.6.git-dave/arch/m68k/include/asm/ptemap.h	2009-04-30 15:11:10.000000000 -0700
@@ -12,8 +12,8 @@
 
 #else /* !CONFIG_SUN3, Motorola */
 
-#define pte_offset_map(pmdp,address) ((pte_t *)__pmd_page(*pmdp) + (((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
-#define pte_offset_map_nested(pmdp, address) pte_offset_map(pmdp, address)
+#define pte_offset_map(pmdp,address) pte_offset_kernel(pmdp, address)
+#define pte_offset_map_nested(pmdp, address) pte_offset_kernel(pmdp, address)
 #define pte_unmap(pte)		((void)0)
 #define pte_unmap_nested(pte)	((void)0)
 
_
