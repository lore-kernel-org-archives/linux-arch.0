Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B732AAD0
	for <linux-arch@vger.kernel.org>; Thu,  5 Feb 2026 05:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.187.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770271153; cv=none; b=rP41mUgj00LAYnZbgXgmf+9QIw5z1hcwTRRLcvb+j8ozLbd4Pz7SDwQ4OL6uguDJObWIco8HGv6LVzFArW0mk08FwfAw/yI62vuCUlNVEkfUg5zzj4KdudeHD9CJaqfXytjJ1keKrOXnQnUGpWPlwAePpx1GrdIZ1S9ZeD7OrGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770271153; c=relaxed/simple;
	bh=K7hRVT2qzTB73aXjB3/vk1gHy9ojyfi9yNINhaH+ois=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u4SvKrk/kSIzljd+WevRE2ffrf8lj/lZBw2F+DXhWaCuCAD6Udvc+aMmMDmb/jnKQozmmsUPJ0u/y9BwukuZODIiGPIMsifY2KMiYplF+KvlKopVxvaYwWnihXv20qartUGJzPr2ByCpZ4o6D+MWPHY6al34/oq2O3HhXhXAlCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.187.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTP id 6155wmpX012551;
	Thu, 5 Feb 2026 13:58:48 +0800 (+08)
	(envelope-from minachou@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Feb
 2026 13:58:48 +0800
From: Hui Min Mina Chou <minachou@andestech.com>
To: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <alex@ghiti.fr>, <arnd@arndb.de>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>
CC: <tim609@andestech.com>, <ben717@andestech.com>, <minachou@andestech.com>,
        <az70021@gmail.com>, Randolph <randolph@andestech.com>
Subject: [PATCH] riscv: Fix __kernel_off_t to 64 Bits in RV32
Date: Thu, 5 Feb 2026 13:58:00 +0800
Message-ID: <20260205055800.586458-1-minachou@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 6155wmpX012551

From: Randolph <randolph@andestech.com>

Modify the __kernel_off_t type for RV32 to 64 bits to comply with
the current glibc calling convention.

In RISC-V, off_t is 64 bits in glibc, and __kernel_off_t must match
this size. For RV32, the kernel uses the long type, which should be
changed to long long to ensure consistency.

To address the Y2038 problem, the glibc upstream for RISC-V has adopted
64-bit time_t and off_t for both RV32 and RV64 [*1].
However, no corresponding modification was made on the kernel side,
leading to test case failures in LTP’s fnctl due to size inconsistencies.
This discrepancy causes errors when glibc passes the struct flock
parameter to the kernel through fnctl().

The structure of flock are shown as below:

struct flock in glibc:
------------------------------------------------------
struct flock
  {
    short int l_type;
    short int l_whence;
    __off_t l_start;
    __off_t l_len;
    __off64_t l_start;
    __off64_t l_len;             <------  "__off64_t" in glibc is 64bit
    __pid_t l_pid;
  };
------------------------------------------------------

struct flock in kernel:
------------------------------------------------------
struct flock {
    short   l_type;
    short   l_whence;
    __kernel_off_t  l_start;
    __kernel_off_t  l_len;       <----- "__kernel_off_t" in kernel is 32bit
    __kernel_pid_t  l_pid;
    __ARCH_FLOCK_EXTRA_SYSID
    __ARCH_FLOCK_PAD
};
------------------------------------------------------

[*1]: 4e95f95966.1578824547.git.alistair.francis@wdc.com/#2360267

Signed-off-by: Randolph <randolph@andestech.com>
---
 arch/riscv/include/uapi/asm/posix_types.h | 39 +++++++++++++++++++++++
 include/uapi/asm-generic/posix_types.h    |  3 ++
 2 files changed, 42 insertions(+)
 create mode 100644 arch/riscv/include/uapi/asm/posix_types.h

diff --git a/arch/riscv/include/uapi/asm/posix_types.h b/arch/riscv/include/uapi/asm/posix_types.h
new file mode 100644
index 000000000000..91b47340bbc3
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/posix_types.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_RISCV_POSIX_TYPES_H
+#define _ASM_RISCV_POSIX_TYPES_H
+
+#include <asm/bitsperlong.h>
+
+/*
+ * In the generic flow, this file is automatically created if it does not
+ * already exist, as indicated by the line.
+ * "#include <asm-generic/posix_types.h>"
+ *
+ * If the file already exists, the automatic creation process will be skipped.
+ * Adding architecture-specific types to this file may alter the generic flow,
+ * potentially causing type conflicts during the build phase. To avoid this,
+ * define a variable to instruct the generic code to skip the re-typedef
+ * process.
+ */
+#if __BITS_PER_LONG == 32
+typedef long long		__kernel_off_t;
+#define _arch_kernel_off_t	_arch_kernel_off_t
+#endif
+
+/*
+ * The "long" type is 4 bytes in RV32 and 8 bytes in RV64.
+ *
+ * Before adding an architecture specific type:
+ * In RV32: __kernel_off_t -> __kernel_long_t -> long (4 byte)
+ * In RV64: __kernel_off_t -> __kernel_long_t -> long (8 byte)
+ *
+ * After adding architecture specific type:
+ * In RV32: __kernel_off_t -> long long (8 byte)
+ * In RV64: __kernel_off_t -> __kernel_long_t -> long (8 byte)
+ *
+ * This architecture specific type is only for RV32.
+ */
+
+#include <asm-generic/posix_types.h>
+
+#endif /* _ASM_RISCV_POSIX_TYPES_H */
diff --git a/include/uapi/asm-generic/posix_types.h b/include/uapi/asm-generic/posix_types.h
index 0a90ad92dbf3..dc5dd32f6d33 100644
--- a/include/uapi/asm-generic/posix_types.h
+++ b/include/uapi/asm-generic/posix_types.h
@@ -84,7 +84,10 @@ typedef struct {
 /*
  * anything below here should be completely generic
  */
+#ifndef _arch_kernel_off_t
 typedef __kernel_long_t	__kernel_off_t;
+#endif
+
 typedef long long	__kernel_loff_t;
 typedef unsigned long long	__kernel_uoff_t;
 typedef __kernel_long_t	__kernel_old_time_t;
-- 
2.34.1

