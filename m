From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: [RFC v2][PATCH 05/35] avr32: create ptemap.h
Date: Wed, 20 May 2009 11:24:53 -0700
Message-ID: <20090520182453.8733E957@kernel>
References: <20090520182445.D7B49A7C@kernel>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:56627 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756300AbZETSZH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 May 2009 14:25:07 -0400
In-Reply-To: <20090520182445.D7B49A7C@kernel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>



Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/arch/avr32/include/asm/ptemap.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff -puN /dev/null arch/avr32/include/asm/ptemap.h
--- /dev/null	2008-09-02 09:40:19.000000000 -0700
+++ linux-2.6.git-dave/arch/avr32/include/asm/ptemap.h	2009-04-30 15:10:55.000000000 -0700
@@ -0,0 +1,9 @@
+#ifndef _AVR32_ASM_PTEMAP_H
+#define _AVR32_ASM_PTEMAP_H
+
+#define pte_offset_map(dir, address) pte_offset_kernel(dir, address)
+#define pte_offset_map_nested(dir, address) pte_offset_kernel(dir, address)
+#define pte_unmap(pte)		do { } while (0)
+#define pte_unmap_nested(pte)	do { } while (0)
+
+#endif /* _AVR32_ASM_PTEMAP_H */
_
