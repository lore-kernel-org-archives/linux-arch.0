From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 2/9] move count_zeroes.h out of asm-generic
Date: Fri, 28 Aug 2015 09:27:15 +0200
Message-ID: <1440746842-19029-3-git-send-email-hch@lst.de>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org>
In-Reply-To: <1440746842-19029-1-git-send-email-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org>
List-Help: <mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=subscribe>
Sender: drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
Errors-To: drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
To: arnd-r2nGTMty4D4@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mitake-uo9agqpHHEbPUJYwFPjUlCGn5s73+xxf@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oded.gabbay-5C7GfCeVMHo@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eli-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org, james_p_freyensee-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, drbd-dev-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org, herbert-lOAM2aK0SrRLBo1qDEOMRrpzq4S04n8Q@public.gmane.org
List-Id: linux-arch.vger.kernel.org

This header contains a few helpers currenly only used by the mpi
implementation, and not default implementation of architecture code.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 include/asm-generic/bitops/count_zeros.h | 57 --------------------------------
 include/linux/count_zeros.h              | 57 ++++++++++++++++++++++++++++++++
 lib/mpi/longlong.h                       |  2 +-
 lib/mpi/mpicoder.c                       |  2 +-
 4 files changed, 59 insertions(+), 59 deletions(-)
 delete mode 100644 include/asm-generic/bitops/count_zeros.h
 create mode 100644 include/linux/count_zeros.h

diff --git a/include/asm-generic/bitops/count_zeros.h b/include/asm-generic/bitops/count_zeros.h
deleted file mode 100644
index 97520d2..0000000
--- a/include/asm-generic/bitops/count_zeros.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/* Count leading and trailing zeros functions
- *
- * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public Licence
- * as published by the Free Software Foundation; either version
- * 2 of the Licence, or (at your option) any later version.
- */
-
-#ifndef _ASM_GENERIC_BITOPS_COUNT_ZEROS_H_
-#define _ASM_GENERIC_BITOPS_COUNT_ZEROS_H_
-
-#include <asm/bitops.h>
-
-/**
- * count_leading_zeros - Count the number of zeros from the MSB back
- * @x: The value
- *
- * Count the number of leading zeros from the MSB going towards the LSB in @x.
- *
- * If the MSB of @x is set, the result is 0.
- * If only the LSB of @x is set, then the result is BITS_PER_LONG-1.
- * If @x is 0 then the result is COUNT_LEADING_ZEROS_0.
- */
-static inline int count_leading_zeros(unsigned long x)
-{
-	if (sizeof(x) == 4)
-		return BITS_PER_LONG - fls(x);
-	else
-		return BITS_PER_LONG - fls64(x);
-}
-
-#define COUNT_LEADING_ZEROS_0 BITS_PER_LONG
-
-/**
- * count_trailing_zeros - Count the number of zeros from the LSB forwards
- * @x: The value
- *
- * Count the number of trailing zeros from the LSB going towards the MSB in @x.
- *
- * If the LSB of @x is set, the result is 0.
- * If only the MSB of @x is set, then the result is BITS_PER_LONG-1.
- * If @x is 0 then the result is COUNT_TRAILING_ZEROS_0.
- */
-static inline int count_trailing_zeros(unsigned long x)
-{
-#define COUNT_TRAILING_ZEROS_0 (-1)
-
-	if (sizeof(x) == 4)
-		return ffs(x);
-	else
-		return (x != 0) ? __ffs(x) : COUNT_TRAILING_ZEROS_0;
-}
-
-#endif /* _ASM_GENERIC_BITOPS_COUNT_ZEROS_H_ */
diff --git a/include/linux/count_zeros.h b/include/linux/count_zeros.h
new file mode 100644
index 0000000..363da78
--- /dev/null
+++ b/include/linux/count_zeros.h
@@ -0,0 +1,57 @@
+/* Count leading and trailing zeros functions
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#ifndef _LINUX_BITOPS_COUNT_ZEROS_H_
+#define _LINUX_BITOPS_COUNT_ZEROS_H_
+
+#include <asm/bitops.h>
+
+/**
+ * count_leading_zeros - Count the number of zeros from the MSB back
+ * @x: The value
+ *
+ * Count the number of leading zeros from the MSB going towards the LSB in @x.
+ *
+ * If the MSB of @x is set, the result is 0.
+ * If only the LSB of @x is set, then the result is BITS_PER_LONG-1.
+ * If @x is 0 then the result is COUNT_LEADING_ZEROS_0.
+ */
+static inline int count_leading_zeros(unsigned long x)
+{
+	if (sizeof(x) == 4)
+		return BITS_PER_LONG - fls(x);
+	else
+		return BITS_PER_LONG - fls64(x);
+}
+
+#define COUNT_LEADING_ZEROS_0 BITS_PER_LONG
+
+/**
+ * count_trailing_zeros - Count the number of zeros from the LSB forwards
+ * @x: The value
+ *
+ * Count the number of trailing zeros from the LSB going towards the MSB in @x.
+ *
+ * If the LSB of @x is set, the result is 0.
+ * If only the MSB of @x is set, then the result is BITS_PER_LONG-1.
+ * If @x is 0 then the result is COUNT_TRAILING_ZEROS_0.
+ */
+static inline int count_trailing_zeros(unsigned long x)
+{
+#define COUNT_TRAILING_ZEROS_0 (-1)
+
+	if (sizeof(x) == 4)
+		return ffs(x);
+	else
+		return (x != 0) ? __ffs(x) : COUNT_TRAILING_ZEROS_0;
+}
+
+#endif /* _LINUX_BITOPS_COUNT_ZEROS_H_ */
diff --git a/lib/mpi/longlong.h b/lib/mpi/longlong.h
index a89d041..b90e255 100644
--- a/lib/mpi/longlong.h
+++ b/lib/mpi/longlong.h
@@ -19,7 +19,7 @@
  * the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
  * MA 02111-1307, USA. */
 
-#include <asm-generic/bitops/count_zeros.h>
+#include <linux/count_zeros.h>
 
 /* You have to define the following before including this file:
  *
diff --git a/lib/mpi/mpicoder.c b/lib/mpi/mpicoder.c
index bc0a1da..9e1ec99 100644
--- a/lib/mpi/mpicoder.c
+++ b/lib/mpi/mpicoder.c
@@ -19,7 +19,7 @@
  */
 
 #include <linux/bitops.h>
-#include <asm-generic/bitops/count_zeros.h>
+#include <linux/count_zeros.h>
 #include "mpi-internal.h"
 
 #define MAX_EXTERN_MPI_BITS 16384
-- 
1.9.1
