From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: [RFC][PATCH 27/35] m32r: use pte_offset_kernel() as base for pte_offset_map*()
Date: Fri, 01 May 2009 07:42:43 -0700
Message-ID: <20090501144243.33BDCFD4@kernel>
References: <20090501144201.D31EF417@kernel>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:57883 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761319AbZEAOmp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 1 May 2009 10:42:45 -0400
In-Reply-To: <20090501144201.D31EF417@kernel>
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

 linux-2.6.git-dave/arch/m32r/include/asm/ptemap.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff -puN arch/m32r/include/asm/ptemap.h~m32r-pte_offset_kernel arch/m32r/include/asm/ptemap.h
--- linux-2.6.git/arch/m32r/include/asm/ptemap.h~m32r-pte_offset_kernel	2009-04-30 15:11:08.000000000 -0700
+++ linux-2.6.git-dave/arch/m32r/include/asm/ptemap.h	2009-04-30 15:11:08.000000000 -0700
@@ -1,9 +1,8 @@
 #ifndef _M32R_ASM_PTEMAP_H
 #define _M32R_ASM_PTEMAP_H
 
-#define pte_offset_map(dir, address)	\
-	((pte_t *)page_address(pmd_page(*(dir))) + pte_index(address))
-#define pte_offset_map_nested(dir, address)	pte_offset_map(dir, address)
+#define pte_offset_map(dir, address)	pte_offset_kernel(dir, address)
+#define pte_offset_map_nested(dir, address)	pte_offset_kernel(dir, address)
 #define pte_unmap(pte)		do { } while (0)
 #define pte_unmap_nested(pte)	do { } while (0)
 
_
