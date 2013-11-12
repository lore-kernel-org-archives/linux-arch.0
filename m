From: Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 01/11] Add generic fixmap.h
Date: Tue, 12 Nov 2013 08:22:15 -0500
Message-ID: <1384262545-20875-2-git-send-email-msalter@redhat.com>
References: <1384262545-20875-1-git-send-email-msalter@redhat.com>
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384262545-20875-1-git-send-email-msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Richard Kuo <rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Many architectures provide an asm/fixmap.h which defines support for
compile-time 'special' virtual mappings which need to be made before
paging_init() has run. This suport is also used for early ioremap
on x86. Much of this support is identical across the architectures.
This patch consolidates all of the common bits into asm-generic/fixmap.h
which is intended to be included from arch/*/include/asm/fixmap.h.

Signed-off-by: Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CC: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
CC: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
CC: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
CC: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
CC: Richard Kuo <rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
CC: linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
CC: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
CC: linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
CC: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
CC: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org
CC: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
CC: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
CC: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
CC: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
CC: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
---
 include/asm-generic/fixmap.h | 107 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 include/asm-generic/fixmap.h

diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
new file mode 100644
index 0000000..8d453db
--- /dev/null
+++ b/include/asm-generic/fixmap.h
@@ -0,0 +1,107 @@
+/*
+ * fixmap.h: compile-time virtual memory allocation
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1998 Ingo Molnar
+ *
+ * Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
+ * x86_32 and x86_64 integration by Gustavo F. Padovan, February 2009
+ */
+
+#ifndef __ASM_GENERIC_FIXMAP_H
+#define __ASM_GENERIC_FIXMAP_H
+
+#define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
+#define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
+
+#ifndef __ASSEMBLY__
+extern void __this_fixmap_does_not_exist(void);
+
+/*
+ * 'index to address' translation. If anyone tries to use the idx
+ * directly without translation, we catch the bug with a NULL-deference
+ * kernel oops. Illegal ranges of incoming indices are caught too.
+ */
+static __always_inline unsigned long fix_to_virt(const unsigned int idx)
+{
+	/*
+	 * this branch gets completely eliminated after inlining,
+	 * except when someone tries to use fixaddr indices in an
+	 * illegal way. (such as mixing up address types or using
+	 * out-of-range indices).
+	 *
+	 * If it doesn't get removed, the linker will complain
+	 * loudly with a reasonably clear error message..
+	 */
+	if (idx >= __end_of_fixed_addresses)
+		__this_fixmap_does_not_exist();
+
+	return __fix_to_virt(idx);
+}
+
+static inline unsigned long virt_to_fix(const unsigned long vaddr)
+{
+	BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
+	return __virt_to_fix(vaddr);
+}
+
+/*
+ * Provide some reasonable defaults for page flags.
+ * Not all architectures use all of these different types and some
+ * architectures use different names.
+ */
+#ifndef FIXMAP_PAGE_NORMAL
+#define FIXMAP_PAGE_NORMAL PAGE_KERNEL
+#endif
+#ifndef FIXMAP_PAGE_NOCACHE
+#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE
+#endif
+#ifndef FIXMAP_PAGE_IO
+#define FIXMAP_PAGE_IO PAGE_KERNEL_IO
+#endif
+#ifndef FIXMAP_PAGE_CLEAR
+#define FIXMAP_PAGE_CLEAR __pgprot(0)
+#endif
+
+#ifndef set_fixmap
+#define set_fixmap(idx, phys)				\
+	__set_fixmap(idx, phys, FIXMAP_PAGE_NORMAL)
+#endif
+
+#ifndef clear_fixmap
+#define clear_fixmap(idx)			\
+	__set_fixmap(idx, 0, FIXMAP_PAGE_CLEAR)
+#endif
+
+/* Return an pointer with offset calculated */
+#define __set_fixmap_offset(idx, phys, flags)		      \
+({							      \
+	unsigned long addr;				      \
+	__set_fixmap(idx, phys, flags);			      \
+	addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1)); \
+	addr;						      \
+})
+
+#define set_fixmap_offset(idx, phys) \
+	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL)
+
+/*
+ * Some hardware wants to get fixmapped without caching.
+ */
+#define set_fixmap_nocache(idx, phys) \
+	__set_fixmap(idx, phys, FIXMAP_PAGE_NOCACHE)
+
+#define set_fixmap_offset_nocache(idx, phys) \
+	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NOCACHE)
+
+/*
+ * Some fixmaps are for IO
+ */
+#define set_fixmap_io(idx, phys) \
+	__set_fixmap(idx, phys, FIXMAP_PAGE_IO)
+
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_GENERIC_FIXMAP_H */
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-metag" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
