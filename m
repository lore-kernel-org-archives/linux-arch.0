Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834F83D667C;
	Tue, 21 Apr 2026 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776655; cv=none; b=ntBRrih/HJ4j2AM1q5U4Io3IQHHiOZsH3yiiv7sVb0nFBVdxGZGOE9iwhJUO6GO+DrFP5uxcR0Qt0VadplTynNUAuzTATspR9S1rXiKx49wQam2SK8yxtMKwdsVLYi3KZm8gkKWQvTeW4+D7BC09y7aL3uA0ZA9hu4aZ68y0Y84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776655; c=relaxed/simple;
	bh=RRwAlN6IpmxPkOxgImIXnsn9WxAITqIcBSOxnOP0Inw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cY/1A/l1lb7uhqil8YdPEwDMLFMQFLiVx54ZCFqtlgiTlUzSLSbvj8RxGYi/5QgrdP/lSSbDEUuiFgJM0wyUmAhukepv5PoO1F7QA45bFF6AsG/4vG+XxFqPG0POuY75+LrUPZXrrgMFW6UxkVFKshwDfn2uB2EquyZ39QS95Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=q/yQRJi9; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="q/yQRJi9"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sP1CI1tiE4B2LkT6grmHSXCoIHlmRgNWy3C/pf6exgs=;
	b=q/yQRJi94rwlOdzpdMSa8Gpx0gZRBFAM5eRJUXpa4A98HIzpdFzrk/POC+DJleoVsjJL9PGTJ
	AY1ocQ5p3c1SYtN3MKERP46scvmIsPjfP48jn22TdfBELKdM7gmESGmA9xVYwMRgC8zpbLKOpFk
	Lk2BZyiDPdKlYPtLzT3Y8eU=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4g0MpM1CzVz1K99C;
	Tue, 21 Apr 2026 20:57:47 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 0ABA440562;
	Tue, 21 Apr 2026 21:04:07 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Apr
 2026 21:04:05 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>,
	<arnd@arndb.de>, <akpm@linux-foundation.org>, <ruanjinjie@huawei.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <david.laight.linux@gmail.com>,
	<nathan@kernel.org>, <cp0613@linux.alibaba.com>
Subject: [PATCH v5 2/3] bitops: Define generic __bitrev8/16/32 for reuse
Date: Tue, 21 Apr 2026 21:07:51 +0800
Message-ID: <20260421130752.607500-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421130752.607500-1-ruanjinjie@huawei.com>
References: <20260421130752.607500-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Define generic __bitrev8/16/32 using the implementation
in <linux/bitrev.h>, so they can be reused in <asm/bitrev.h>,
such as RISCV.

Reviewed-by: Yury Norov <ynorov@nvidia.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/asm-generic/bitops/__bitrev.h | 25 +++++++++++++++++++++++++
 include/linux/bitrev.h                | 20 ++++----------------
 2 files changed, 29 insertions(+), 16 deletions(-)
 create mode 100644 include/asm-generic/bitops/__bitrev.h

diff --git a/include/asm-generic/bitops/__bitrev.h b/include/asm-generic/bitops/__bitrev.h
new file mode 100644
index 000000000000..f06af929678d
--- /dev/null
+++ b/include/asm-generic/bitops/__bitrev.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_BITOPS___BITREV_H_
+#define _ASM_GENERIC_BITOPS___BITREV_H_
+
+#ifdef CONFIG_GENERIC_BITREVERSE
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
+#endif /* CONFIG_GENERIC_BITREVERSE */
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
-- 
2.34.1

