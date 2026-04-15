Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F059333A9EB;
	Wed, 15 Apr 2026 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245699; cv=none; b=f5l2KYOO2QSU4RDku0ZKSE0N6rFiecOV0Py6K1QlFaAPLmLBSMzUpwynDr74QXJu4TCzOUciOnSXwxbf/A6dj3H5m2ghdg13MZ0G8mzYcyDrwNdMEsTSwmsBYXNuOK88t/A4GaBqCSxXKQKfRxbyzMV286gY4EeeHxgA4B9jjqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245699; c=relaxed/simple;
	bh=Lx4zB3rXZt1KnEqIZM3ARJydibgzT1fTQ3kOdZvvpcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fmR44kfltzCD/FyXF+aMmv/FZODDbP496RFBPfxosjEDmWIRaoGgXuv/DxCH4OWuGYRDlQM0z2NVt5w31yyaVw7zia7HkiFA0zfU9YipvTNfK9eI/XM2lBaFwFOAmfPQackUI645LwHpO/pMMGExSEbA8Bh5HR316T8ogM6jLIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=j6aaRnnv; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="j6aaRnnv"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3rcuULcz1Pyzw1DzJpbcb1yxL1sVr10wsmtquP3Zpz8=;
	b=j6aaRnnv6WXsKn9TtPQ+OigAKw/q/Er7UQgKDehYEOaV4z9cNnz/0HVrKzK6cgWGEnmnKvgNZ
	kRt+U8ngaMdJ50nnlvx+o1pctX847IpWBGY/D5EjvJski/KKEvqbDTWngbeYFi58UueNUM6FZ9V
	HkksFiUn2wnvRwbnfjT8KLg=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fwbRX5lqBzcZyN;
	Wed, 15 Apr 2026 17:28:24 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id E29F040561;
	Wed, 15 Apr 2026 17:34:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 15 Apr
 2026 17:34:54 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>,
	<arnd@arndb.de>, <cp0613@linux.alibaba.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2 2/2] arch/riscv: Add bitrev.h file to support rev8 and brev8
Date: Wed, 15 Apr 2026 17:38:27 +0800
Message-ID: <20260415093827.2776328-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415093827.2776328-1-ruanjinjie@huawei.com>
References: <20260415093827.2776328-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)

The RISC-V Bit-manipulation Extension for Cryptography (Zbkb) provides
the 'brev8' instruction, which reverses the bits within each byte.
Combined with the 'rev8' instruction (from Zbb or Zbkb), which reverses
the byte order of a register, we can efficiently implement 16-bit,
32-bit, and (on RV64) 64-bit bit reversal.

This is significantly faster than the default software table-lookup
implementation in lib/bitrev.c, as it replaces memory accesses and
multiple arithmetic operations with just two or three hardware
instructions.

Select HAVE_ARCH_BITREVERSE and provide <asm/bitrev.h> to utilize
these instructions when the Zbkb extension is available at runtime
via the alternatives mechanism.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/bitrev.h | 41 +++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 arch/riscv/include/asm/bitrev.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 90c531e6abf5..05f2b2166a83 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -128,6 +128,7 @@ config RISCV
 	select HAS_IOPORT if MMU
 	select HAVE_ALIGNED_STRUCT_PAGE
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_BITREVERSE if RISCV_ISA_ZBKB
 	select HAVE_ARCH_HUGE_VMALLOC if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
diff --git a/arch/riscv/include/asm/bitrev.h b/arch/riscv/include/asm/bitrev.h
new file mode 100644
index 000000000000..9f205ac84796
--- /dev/null
+++ b/arch/riscv/include/asm/bitrev.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_BITREV_H
+#define __ASM_BITREV_H
+
+#include <linux/types.h>
+#include <asm/cpufeature-macros.h>
+#include <asm/hwcap.h>
+#include <asm-generic/bitops/__bitrev.h>
+
+static __always_inline __attribute_const__ u32 __arch_bitrev32(u32 x)
+{
+	unsigned long result = x;
+
+	if (!riscv_has_extension_likely(RISCV_ISA_EXT_ZBKB))
+		return generic___bitrev32(x);
+
+	asm volatile(
+		".option push\n"
+		".option arch,+zbkb\n"
+		"rev8 %0, %0\n"
+		"brev8 %0, %0\n"
+		".option pop"
+		: "+r" (result)
+	);
+
+	if (__riscv_xlen == 64)
+		return (u32)(result >> 32);
+
+	return (u32)result;
+}
+
+static __always_inline __attribute_const__ u16 __arch_bitrev16(u16 x)
+{
+	return __arch_bitrev32((u32)x) >> 16;
+}
+
+static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
+{
+	return __arch_bitrev32((u32)x) >> 24;
+}
+#endif
-- 
2.34.1

