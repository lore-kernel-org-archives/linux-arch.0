From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH v3 1/5] io: define several IO & PIO barrier types for the asm-generic version
Date: Wed,  4 Apr 2018 19:58:16 -0400
Message-ID: <1522886301-25955-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Getting ready to harden readX()/writeX() and inX()/outX() semantics for the
generic implementation.

Defining two set of macros as __io_br() and __io_ar() to indicate actions
to be taken before and after MMIO read.

Defining two set of macros as __io_bw() and __io_aw() to indicate actions
to be taken before and after MMIO write.

Defining two set of macros as __io_pbw() and __io_paw() to indicate actions
to be taken before and after Port IO write.

Defining two set of macros as __io_pbr() and __io_par() to indicate actions
to be taken before and after Port IO read.

If rmb() is available for the architecture, prefer rmb() as the default
implementation of __io_ar()/__io_par().

If wmb() is available for the architecture, prefer wmb() as the default
implementation of __io_bw()/__io_pbw().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 include/asm-generic/io.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index b4531e3..a3d349e 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -25,6 +25,49 @@
 #define mmiowb() do {} while (0)
 #endif
 
+#ifndef __io_br
+#define __io_br()      barrier()
+#endif
+
+#ifndef __io_ar
+#ifdef rmb
+/* prefer rmb() as the default implementation of __io_ar() if supported */
+#define __io_ar()      rmb()
+#else
+#define __io_ar()      barrier()
+#endif
+#endif
+
+#ifndef __io_bw
+#ifdef wmb
+/* prefer wmb() as the default implementation of __io_bw() if supported */
+#define __io_bw()      wmb()
+#else
+#define __io_bw()      barrier()
+#endif
+#endif
+
+#ifndef __io_aw
+#define __io_aw()      barrier()
+#endif
+
+#ifndef __io_pbw
+#define __io_pbw()     __io_bw()
+#endif
+
+#ifndef __io_paw
+#define __io_paw()     __io_aw()
+#endif
+
+#ifndef __io_pbr
+#define __io_pbr()     __io_br()
+#endif
+
+#ifndef __io_par
+#define __io_par()     __io_ar()
+#endif
+
+
 /*
  * __raw_{read,write}{b,w,l,q}() access memory in native endianness.
  *
-- 
2.7.4
