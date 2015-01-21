Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:37326 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200AbbAUQwg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jan 2015 11:52:36 -0500
From: Andrey Ryabinin <a.ryabinin@samsung.com>
Subject: [PATCH v9 15/17] kernel: add support for .init_array.* constructors
Date: Wed, 21 Jan 2015 19:51:43 +0300
Message-ID: <1421859105-25253-16-git-send-email-a.ryabinin@samsung.com>
In-reply-to: <1421859105-25253-1-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1421859105-25253-1-git-send-email-a.ryabinin@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrey Ryabinin <a.ryabinin@samsung.com>, Dmitry Vyukov <dvyukov@google.com>, Konstantin Serebryany <kcc@google.com>, Dmitry Chernenkov <dmitryc@google.com>, Andrey Konovalov <adech.fo@gmail.com>, Yuri Gribov <tetra2005@gmail.com>, Konstantin Khlebnikov <koct9i@gmail.com>, Sasha Levin <sasha.levin@oracle.com>, Christoph Lameter <cl@linux.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@intel.com>, Andi Kleen <andi@firstfloor.org>, x86@kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>
Message-ID: <20150121165143.4UDUu9eipy9KWdoiQO8RglADl0KJr_jieP6cFwTPaj0@z>

KASan uses constructors for initializing redzones for global
variables. Actually KASan doesn't need priorities for constructors,
so they were removed from GCC 5.0, but GCC 4.9.2 still generates
constructors with priorities.

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
2.2.1

