From: Kyle McMartin <kyle-pfcGkIkfWfAsA/PxXw9srA@public.gmane.org>
Subject: [PATCH 1/2] kallsyms: restructure print_fn_descriptor_symbol
Date: Fri, 18 Apr 2008 03:48:56 -0400
Message-ID: <20080418074856.GC16276@phobos.i.cabal.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org

Factor out the function descriptor access from the print_symbol
call.

Signed-off-by: Kyle McMartin <kyle-pfcGkIkfWfAsA/PxXw9srA@public.gmane.org>
---
 include/linux/kallsyms.h |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 82de2fb..6734a3f 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -83,17 +83,21 @@ __attribute__((format(printf,1,2)));
 static inline void __check_printsym_format(const char *fmt, ...)
 {
 }
+
 /* ia64 and ppc64 use function descriptors, which contain the real address */
 #if defined(CONFIG_IA64) || defined(CONFIG_PPC64)
-#define print_fn_descriptor_symbol(fmt, addr)		\
-do {						\
-	unsigned long *__faddr = (unsigned long*) addr;		\
-	print_symbol(fmt, __faddr[0]);		\
-} while (0)
+#define get_func_addr(x)	({				\
+					unsigned long *addr =	\
+						(unsigned long *)x;	\
+					addr[0];		\
+				})
 #else
-#define print_fn_descriptor_symbol(fmt, addr) print_symbol(fmt, addr)
+#define get_func_addr(x)	x
 #endif
 
+#define print_fn_descriptor_symbol(fmt, addr)	\
+		print_symbol(fmt, get_func_addr(addr))
+
 static inline void print_symbol(const char *fmt, unsigned long addr)
 {
 	__check_printsym_format(fmt, "");
-- 
1.5.4.5
