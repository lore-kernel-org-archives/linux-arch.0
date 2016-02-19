Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50888 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425150AbcBSNqO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Feb 2016 08:46:14 -0500
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFC v2 4/7] asm/sections: add a generic push_section_tbl()
Date: Fri, 19 Feb 2016 05:45:56 -0800
Message-ID: <1455889559-9428-5-git-send-email-mcgrof@kernel.org>
In-Reply-To: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, ming.lei@canonical.com, gregkh@linuxfoundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, benh@kernel.crashing.org, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, masami.hiramatsu.pt@hitachi.com, andriy.shevchenko@linux.intel.com, dwmw2@infradead.org, xen-devel@lists.xensource.com, "Luis R. Rodriguez" <mcgrof@kernel.org>
Message-ID: <20160219134556.Y_e19DQoeArZdnfbpM1PKdd3CLVRSs3T_5kAfg0Qkz8@z>

With a generic linker tables solution in place we
need a general asm solution for declaring entries
with asm. The first easy target is to cover the C
asm declarations, guard the header file for now
and define a first generic entry push_section_tbl()
to be used later for custom linker table annotations.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 include/asm-generic/sections.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index af0254c09424..f5ea98bd85d2 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -3,8 +3,10 @@
 
 /* References to section boundaries */
 
+#ifndef __ASSEMBLY__
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/sections.h>
 
 /*
  * Usage guidelines:
@@ -128,4 +130,12 @@ static inline bool init_section_intersects(void *virt, size_t size)
 	return memory_intersects(__init_begin, __init_end, virt, size);
 }
 
+/*
+ * Some architectures do not like the "\t" at the end (s39), we should be
+ * able to generalize this further, but so far this covers most architectures.
+ */
+#define push_section_tbl(section, name, level, flags)			\
+	".pushsection " SECTION_TBL(section,name,level) ",  \"" #flags "\"\n\t"
+#endif
+
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
-- 
2.7.0

