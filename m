Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F256621C16A;
	Mon, 20 Apr 2026 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690543; cv=none; b=VwV/CH4a3vbKuj+8yPhkq1Qin5HMVmE8OXcS87Jmqco/4eqsLCBgXi0R2qvfICcSWMDwLDD/JE36AeoUUk02d+d2HGyZ6o1pE496vkuf38XLNHdb7PpuGD1kisdIwXADd+d8nONGSWcm+APU/K0Ie8apjMfhBl6YawG5y+B5y40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690543; c=relaxed/simple;
	bh=UIKnft8O394zkjnmKo2IYzjCkfOHlH+71ZW2b71vaOw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8bQlPmMk63RUpAlBAMFbrZT4a04wnMmh4GwuT3cPMuwiLlq2MTx0uOyXZDKiq4J+RBGT2iaTZQLcR52Iae9FyFBak8LFdM8bcBbU6Dk9pSpa77mdZvG4kKpyk1+DI9kfkTkZhmcZn779R8vl2MgtsUiUdY8xMrpZ/J49q3WqRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Vsg810go; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Vsg810go"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DFbmAPqwPcFXVgLwaWjAULa2pVm3nZeyQS+csN0SFyg=;
	b=Vsg810go5/uY5fcB54QAZY5w5rhYPxMhMfh3S8rovJClEd2JYHloZ2F8PAtIDT8/8ma/vEO9K
	uoVxxfnxphm6elJaRRno8kJ9w6OxZky0YjGTTHiKaX4uvWPkA5JqEdADkI+vy5Fl/cH+J7G4t+D
	MltE6k7uRZJfUjRSt8WicLs=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fzlyJ0RJJzKm4w;
	Mon, 20 Apr 2026 21:02:32 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C3ED40571;
	Mon, 20 Apr 2026 21:08:55 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Apr
 2026 21:08:54 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>,
	<arnd@arndb.de>, <akpm@linux-foundation.org>, <ruanjinjie@huawei.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <david.laight.linux@gmail.com>,
	<nathan@kernel.org>, <cp0613@linux.alibaba.com>
Subject: [PATCH v4 2/2] arch/riscv: Add bitrev.h file to support rev8 and brev8
Date: Mon, 20 Apr 2026 21:12:52 +0800
Message-ID: <20260420131252.179729-3-ruanjinjie@huawei.com>
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

The RISC-V Bit-manipulation Extension for Cryptography (Zbkb) provides
the 'brev8' instruction, which reverses the bits within each byte.
Combined with the 'rev8' instruction (from Zbb or Zbkb), which reverses
the byte order of a register, we can efficiently implement 16-bit,
32-bit, and (on RV64) 64-bit bit reversal.

This is significantly faster than the default software table-lookup
implementation in lib/bitrev.c, as it replaces memory accesses and
multiple arithmetic operations with just two or three hardware
instructions.

Select HAVE_ARCH_BITREVERSE as well as NEED_BYTE_REVERSE_TABLE, and
provide <asm/bitrev.h> to utilize these instructions when the Zbkb
extension is available at runtime via the alternatives mechanism.

Link: https://docs.riscv.org/reference/isa/unpriv/b-st-ext.html
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/riscv/Kconfig              |  2 ++
 arch/riscv/include/asm/bitrev.h | 51 +++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 arch/riscv/include/asm/bitrev.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 90c531e6abf5..465545200379 100644
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
@@ -207,6 +208,7 @@ config RISCV
 	select LOCK_MM_AND_FIND_VMA
 	select MMU_GATHER_RCU_TABLE_FREE if SMP && MMU
 	select MODULES_USE_ELF_RELA if MODULES
+	select NEED_BYTE_REVERSE_TABLE
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_IRQ
diff --git a/arch/riscv/include/asm/bitrev.h b/arch/riscv/include/asm/bitrev.h
new file mode 100644
index 000000000000..4b9b8d34cc3b
--- /dev/null
+++ b/arch/riscv/include/asm/bitrev.h
@@ -0,0 +1,51 @@
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
+	unsigned long result;
+
+	if (!riscv_has_extension_likely(RISCV_ISA_EXT_ZBKB))
+		return generic___bitrev32(x);
+
+	asm volatile(
+		".option push\n"
+		".option arch,+zbkb\n"
+		"rev8 %0, %1\n"
+		"brev8 %0, %0\n"
+		".option pop"
+		: "=r" (result) : "r" ((long)x)
+	);
+
+	return result >> (__riscv_xlen - 32);
+}
+
+static __always_inline __attribute_const__ u16 __arch_bitrev16(u16 x)
+{
+	return __arch_bitrev32(x) >> 16;
+}
+
+static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
+{
+	unsigned long result;
+
+	if (!riscv_has_extension_likely(RISCV_ISA_EXT_ZBKB))
+		return generic___bitrev8(x);
+
+	asm volatile(
+		".option push\n"
+		".option arch,+zbkb\n"
+		"brev8 %0, %1\n"
+		".option pop"
+		: "=r" (result) : "r" ((long)x)
+	);
+
+	return result;
+}
+#endif
-- 
2.34.1

