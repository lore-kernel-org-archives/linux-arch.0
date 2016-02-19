From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFC v2 4/7] asm/sections: add a generic
	push_section_tbl()
Date: Fri, 19 Feb 2016 05:45:56 -0800
Message-ID: <1455889559-9428-5-git-send-email-mcgrof@kernel.org>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc: benh@kernel.crashing.org, ming.lei@canonical.com, masami.hiramatsu.pt@hitachi.com, linux-arch@vger.kernel.org, xen-devel@lists.xensource.com, linux@arm.linux.org.uk, x86@kernel.org, anil.s.keshavamurthy@intel.com, arnd@arndb.de, rusty@rustcorp.com.au, jbaron@akamai.com, boris.ostrovsky@oracle.com, andriy.shevchenko@linux.intel.com, mcb30@ipxe.org, jgross@suse.com, ananth@in.ibm.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, luto@amacapital.net, "Luis R. Rodriguez" <mcgrof@kernel.org>, david.vrabel@citrix.com, dwmw2@infradead.org, davem@davemloft.net
List-Id: linux-arch.vger.kernel.org

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
