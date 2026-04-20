Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF2E3A16AE;
	Mon, 20 Apr 2026 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690546; cv=none; b=l9t43E7z/cg6GQkITOioyHuhi8+8aPdOlUV+gPyXvbH9fofefArcjn42OuJ8YJk70l3QWOff/tYeL3USHAJCzm9L46C7d4PXpdU2kMYMRnNJOMCHVFVDwJ6MsTjuM+URzL0Aa8PK4T4J3jq7hWcSMza2Oe2ivRFZrKn02ZY+A3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690546; c=relaxed/simple;
	bh=ij1jw5QEONy1208dsNBj1kqyTfuQOVlP6QfXEhxnCxw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgNU7BRkFkVQju3hRm/WFdkZGdbZDcFYdiDc4o1uo38nSRp/Hcyi1k3mQsqecSL5Vr9hLSJrN4LuM/p79Xc5ZIWY1n0xfCQFR5ttQDcqA0pqYeS1+kpugrmdCc+XvwA1rQE0EXYi93hE1AtpbTstqbColigfgipxyn/us7OmPJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hKLSojiD; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hKLSojiD"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ipsV3XWXSwWOct2tUlbmnwA9zImNAKxGQCaaa918MtM=;
	b=hKLSojiD6b/2tSRhuW+9FwNBkjWbnZ+bA8wr0s+pXWUTLTKX8h9Mhbbjg51AtcF1/8SE9H/tI
	PXmey/Dh163E7f8Y0NX8KLtPDubDE3cbCU3137D0AkSLhG/1BKVT2p6lGonZs+TwJCw04yAAIit
	4hqrEuc6FANEiha0Rg1MkHk=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fzlyM32Jrz1K9D4;
	Mon, 20 Apr 2026 21:02:35 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id A72C440561;
	Mon, 20 Apr 2026 21:08:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Apr
 2026 21:08:53 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>,
	<arnd@arndb.de>, <akpm@linux-foundation.org>, <ruanjinjie@huawei.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <david.laight.linux@gmail.com>,
	<nathan@kernel.org>, <cp0613@linux.alibaba.com>
Subject: [PATCH v4 1/2] bitops: Define generic __bitrev8/16/32 for reuse
Date: Mon, 20 Apr 2026 21:12:51 +0800
Message-ID: <20260420131252.179729-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420131252.179729-1-ruanjinjie@huawei.com>
References: <20260420131252.179729-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Define generic __bitrev8/16/32 using the implementation
in <linux/bitrev.h>, so they can be reused in <asm/bitrev.h>,
such as RISCV.

And introduce a NEED_BYTE_REVERSE_TABLE Kconfig option, so byte_rev_table
is only compiled when !HAVE_ARCH_BITREVERSE or when an architecture (like
RISC-V) explicitly selects it as a fallback. This avoids bloating the .data
section for architectures that have full hardware bit-reverse support and
don't need the table.

Reviewed-by: Yury Norov <ynorov@nvidia.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/asm-generic/bitops/__bitrev.h | 25 +++++++++++++++++++++++++
 include/linux/bitrev.h                | 20 ++++----------------
 lib/Kconfig                           |  4 ++++
 lib/bitrev.c                          |  4 ++--
 4 files changed, 35 insertions(+), 18 deletions(-)
 create mode 100644 include/asm-generic/bitops/__bitrev.h

diff --git a/include/asm-generic/bitops/__bitrev.h b/include/asm-generic/bitops/__bitrev.h
new file mode 100644
index 000000000000..9d7d3d369364
--- /dev/null
+++ b/include/asm-generic/bitops/__bitrev.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_BITOPS___BITREV_H_
+#define _ASM_GENERIC_BITOPS___BITREV_H_
+
+#ifdef CONFIG_NEED_BYTE_REVERSE_TABLE
+#include <asm/types.h>
+
+extern u8 const byte_rev_table[256];
+static __always_inline __attribute_const__ u8 generic___bitrev8(u8 byte)
+{
+	return byte_rev_table[byte];
+}
+
+static __always_inline __attribute_const__ u16 generic___bitrev16(u16 x)
+{
+	return (generic___bitrev8(x & 0xff) << 8) | generic___bitrev8(x >> 8);
+}
+
+static __always_inline __attribute_const__ u32 generic___bitrev32(u32 x)
+{
+	return (generic___bitrev16(x & 0xffff) << 16) | generic___bitrev16(x >> 16);
+}
+#endif /* CONFIG_NEED_BYTE_REVERSE_TABLE */
+
+#endif /* _ASM_GENERIC_BITOPS___BITREV_H_ */
diff --git a/include/linux/bitrev.h b/include/linux/bitrev.h
index d35b8ec1c485..11620a70e776 100644
--- a/include/linux/bitrev.h
+++ b/include/linux/bitrev.h
@@ -12,22 +12,10 @@
 #define __bitrev8 __arch_bitrev8
 
 #else
-extern u8 const byte_rev_table[256];
-static inline u8 __bitrev8(u8 byte)
-{
-	return byte_rev_table[byte];
-}
-
-static inline u16 __bitrev16(u16 x)
-{
-	return (__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8);
-}
-
-static inline u32 __bitrev32(u32 x)
-{
-	return (__bitrev16(x & 0xffff) << 16) | __bitrev16(x >> 16);
-}
-
+#include <asm-generic/bitops/__bitrev.h>
+#define __bitrev32 generic___bitrev32
+#define __bitrev16 generic___bitrev16
+#define __bitrev8 generic___bitrev8
 #endif /* CONFIG_HAVE_ARCH_BITREVERSE */
 
 #define __bitrev8x4(x)	(__bitrev32(swab32(x)))
diff --git a/lib/Kconfig b/lib/Kconfig
index 0f2fb9610647..75cbb647b1da 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -62,6 +62,10 @@ config HAVE_ARCH_BITREVERSE
 	  This option enables the use of hardware bit-reversal instructions on
 	  architectures which support such operations.
 
+config NEED_BYTE_REVERSE_TABLE
+	bool
+	default y if !HAVE_ARCH_BITREVERSE
+
 config ARCH_HAS_STRNCPY_FROM_USER
 	bool
 
diff --git a/lib/bitrev.c b/lib/bitrev.c
index 81b56e0a7f32..d9d5ee00229c 100644
--- a/lib/bitrev.c
+++ b/lib/bitrev.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#ifndef CONFIG_HAVE_ARCH_BITREVERSE
+#ifdef CONFIG_NEED_BYTE_REVERSE_TABLE
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/bitrev.h>
@@ -44,4 +44,4 @@ const u8 byte_rev_table[256] = {
 };
 EXPORT_SYMBOL_GPL(byte_rev_table);
 
-#endif /* CONFIG_HAVE_ARCH_BITREVERSE */
+#endif /* CONFIG_NEED_BYTE_REVERSE_TABLE */
-- 
2.34.1

