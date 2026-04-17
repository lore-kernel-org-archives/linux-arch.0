Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6231F3AE6EB;
	Fri, 17 Apr 2026 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776418047; cv=none; b=bT6DAEhO76HeBcrqYrjbd1ohJ4+0zKx2HXKEbngddspYh6J1aKbvuX7DHNBG8xIOSZ0cRvhCU8QKQdCTpVTkZTvL9s+N4e1CipzcoR7Yf7Ts2bcECiLhif3VNUQxUYqH+NMO2HL3R8/z0ZsKord1pvLQLScMXutBGX5HBboy1rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776418047; c=relaxed/simple;
	bh=MsjW0E55sgRoO1Ehj2OWcNL0gIYd1dV0t11CeVj9Y8E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+5yCAilogPMRo2+UNkB2JrkGANs9m/Cwrndq+9sM2zNMMrBwktmIhBdxucuTq/eO9Eu9Z1cDq2tA8lI17oClyxjA02j516ycSX9yw/qyDI8X4642/E77kEHFIGdwekTMjI/EWEMF4Tt+nOUM8QZC1mRsvdgzgFia9Hz4/A9b00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MGK0+RWI; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MGK0+RWI"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=28exkkb846fkQzFD/3OS2zyXjXJpiFk6w+RdpP5t20c=;
	b=MGK0+RWIqAIyPdyNOKU2y4nRUQxfXBJ3rjaH8tIsb3ZAMeVrcdklkSAxYesft8/iPYF2eakRg
	Xr7xOXaQvHJXpLVhTMasd1+1AEC7YWncvD0F5jmTPDvex/C/ZhSlaGz19IlGmFq+NyRIU8jr+Tm
	JY4AD7ypPr4np2qy51wFeBM=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fxqB41GjYz1K9D4;
	Fri, 17 Apr 2026 17:21:00 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 7AF0A4061D;
	Fri, 17 Apr 2026 17:27:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Apr
 2026 17:27:16 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>,
	<arnd@arndb.de>, <akpm@linux-foundation.org>, <ruanjinjie@huawei.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <david.laight.linux@gmail.com>,
	<nathan@kernel.org>
Subject: [PATCH v3 1/2] bitops: Define generic __bitrev8/16/32 for reuse
Date: Fri, 17 Apr 2026 17:31:01 +0800
Message-ID: <20260417093102.3812978-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417093102.3812978-1-ruanjinjie@huawei.com>
References: <20260417093102.3812978-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Define generic __bitrev8/16/32 using the implementation
in <linux/bitrev.h>, so they can be reused in <asm/bitrev.h>,
such as RISCV.

Reviewed-by: Yury Norov <ynorov@nvidia.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/asm-generic/bitops/__bitrev.h | 22 ++++++++++++++++++++++
 include/linux/bitrev.h                | 20 ++++----------------
 lib/bitrev.c                          |  3 ---
 3 files changed, 26 insertions(+), 19 deletions(-)
 create mode 100644 include/asm-generic/bitops/__bitrev.h

diff --git a/include/asm-generic/bitops/__bitrev.h b/include/asm-generic/bitops/__bitrev.h
new file mode 100644
index 000000000000..1b8c0f464d26
--- /dev/null
+++ b/include/asm-generic/bitops/__bitrev.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_BITOPS___BITREV_H_
+#define _ASM_GENERIC_BITOPS___BITREV_H_
+
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
diff --git a/lib/bitrev.c b/lib/bitrev.c
index 81b56e0a7f32..05088231f31f 100644
--- a/lib/bitrev.c
+++ b/lib/bitrev.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#ifndef CONFIG_HAVE_ARCH_BITREVERSE
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/bitrev.h>
@@ -43,5 +42,3 @@ const u8 byte_rev_table[256] = {
 	0x1f, 0x9f, 0x5f, 0xdf, 0x3f, 0xbf, 0x7f, 0xff,
 };
 EXPORT_SYMBOL_GPL(byte_rev_table);
-
-#endif /* CONFIG_HAVE_ARCH_BITREVERSE */
-- 
2.34.1

