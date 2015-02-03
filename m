Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:47179 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966418AbbBCRnx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Feb 2015 12:43:53 -0500
From: Andrey Ryabinin <a.ryabinin@samsung.com>
Subject: [PATCH v11 17/19] kernel: add support for .init_array.* constructors
Date: Tue, 03 Feb 2015 20:43:10 +0300
Message-ID: <1422985392-28652-18-git-send-email-a.ryabinin@samsung.com>
In-reply-to: <1422985392-28652-1-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1422985392-28652-1-git-send-email-a.ryabinin@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrey Ryabinin <a.ryabinin@samsung.com>, Dmitry Vyukov <dvyukov@google.com>, Konstantin Serebryany <kcc@google.com>, Dmitry Chernenkov <dmitryc@google.com>, Andrey Konovalov <adech.fo@gmail.com>, Yuri Gribov <tetra2005@gmail.com>, Konstantin Khlebnikov <koct9i@gmail.com>, Sasha Levin <sasha.levin@oracle.com>, Christoph Lameter <cl@linux.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@intel.com>, Andi Kleen <andi@firstfloor.org>, x86@kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>
Message-ID: <20150203174310.QcNW9YDK31oYaVJyLzKfijCCs4s4HqsTf393bMxs2FM@z>

KASan uses constructors for initializing redzones for global
variables. Globals instrumentation in GCC 4.9.2 produces
constructors with priority (.init_array.00099)

Currently kernel ignores such constructors. Only constructors
with default priority supported (.init_array)

This patch adds support for constructors with priorities.
For kernel image we put pointers to constructors between
__ctors_start/__ctors_end and do_ctors() will call them
on start up.
For modules we merge .init_array.* sections into resulting .init_array.
Module code properly handles constructors in .init_array section.

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 include/asm-generic/vmlinux.lds.h | 1 +
 scripts/module-common.lds         | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index bee5d68..ac78910 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -478,6 +478,7 @@
 #define KERNEL_CTORS()	. = ALIGN(8);			   \
 			VMLINUX_SYMBOL(__ctors_start) = .; \
 			*(.ctors)			   \
+			*(SORT(.init_array.*))		   \
 			*(.init_array)			   \
 			VMLINUX_SYMBOL(__ctors_end) = .;
 #else
diff --git a/scripts/module-common.lds b/scripts/module-common.lds
index 0865b3e..01c5849 100644
--- a/scripts/module-common.lds
+++ b/scripts/module-common.lds
@@ -16,4 +16,7 @@ SECTIONS {
 	__kcrctab_unused	: { *(SORT(___kcrctab_unused+*)) }
 	__kcrctab_unused_gpl	: { *(SORT(___kcrctab_unused_gpl+*)) }
 	__kcrctab_gpl_future	: { *(SORT(___kcrctab_gpl_future+*)) }
+
+	. = ALIGN(8);
+	.init_array		: { *(SORT(.init_array.*)) *(.init_array) }
 }
-- 
2.2.2

