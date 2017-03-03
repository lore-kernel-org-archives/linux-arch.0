From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH 1/2] uapi: introduce __kernel_uapi_size_t
Date: Fri, 3 Mar 2017 03:59:30 +0300
Message-ID: <20170303005930.GA10283@altlinux.org>
References: <20170226010156.GA28831@altlinux.org> <CAK8P3a0YX3RGAqWN0mwUJtBsqUX0C+QRtJLrT_UA=wX6Z+q0DA@mail.gmail.com> <20170302001853.GA27097@altlinux.org> <D0D3BAFB-0556-4DBB-898C-A42719BA07BE@zytor.com> <20170302003356.GD27132@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from vmicros1.altlinux.org ([194.107.17.57]:50800 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdCCBtL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2017 20:49:11 -0500
Content-Disposition: inline
In-Reply-To: <20170302003356.GD27132@altlinux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

__kernel_uapi_size_t is a pure UAPI type, in defined(__KERNEL__) code
it's always the same as __kernel_size_t.

It's also the same as __kernel_size_t on all architectures except x32
where sizeof(size_t) < sizeof(__kernel_size_t).

__kernel_uapi_size_t can be used as a size_t replacement in UAPI
headers, e.g. in cases when size_t might differ from __kernel_size_t.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/uapi/asm-generic/posix_types.h      | 10 ++++++++++
 arch/x86/include/uapi/asm/posix_types_x32.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/include/uapi/asm-generic/posix_types.h b/include/uapi/asm-generic/posix_types.h
index fe74fcc..e93c324 100644
--- a/include/uapi/asm-generic/posix_types.h
+++ b/include/uapi/asm-generic/posix_types.h
@@ -74,6 +74,16 @@ typedef __kernel_long_t	__kernel_ptrdiff_t;
 #endif
 #endif
 
+/*
+ * __kernel_uapi_size_t is a pure UAPI type, in defined(__KERNEL__) code
+ * it's always the same as __kernel_size_t.
+ * __kernel_uapi_size_t can be used as a size_t replacement in UAPI headers,
+ * e.g. in cases when size_t might differ from __kernel_size_t.
+ */
+#ifndef __kernel_uapi_size_t
+typedef __kernel_size_t __kernel_uapi_size_t;
+#endif
+
 #ifndef __kernel_fsid_t
 typedef struct {
 	int	val[2];
diff --git a/arch/x86/include/uapi/asm/posix_types_x32.h b/arch/x86/include/uapi/asm/posix_types_x32.h
index 85f9bda..0e36e67 100644
--- a/arch/x86/include/uapi/asm/posix_types_x32.h
+++ b/arch/x86/include/uapi/asm/posix_types_x32.h
@@ -14,6 +14,9 @@ typedef long long __kernel_long_t;
 typedef unsigned long long __kernel_ulong_t;
 #define __kernel_long_t __kernel_long_t
 
+typedef unsigned int __kernel_uapi_size_t;
+#define __kernel_uapi_size_t __kernel_uapi_size_t
+
 #include <asm/posix_types_64.h>
 
 #endif /* _ASM_X86_POSIX_TYPES_X32_H */
-- 
ldv
