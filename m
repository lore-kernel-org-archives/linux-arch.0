Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9EE3D647A;
	Tue, 21 Apr 2026 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776658; cv=none; b=AxWlkvc2q/F3Y5er4t7I3E018NNey7QPqQ5D/DJjk6soh1kuaqGVnza8QwqTIO/4sV8iJJdYKAjYtnt7E21JXWug0vyacGJWMdLJCKKUHk/rycVwLYVKp0Hs4PQpi49g3oLyQpZ8CcSVQ6cQWvtd8zleO/yOp1c/p0UT+rf+vqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776658; c=relaxed/simple;
	bh=Bf/AhHeVs+Mz693A7hDBd/4LAGXIKwEt5koD61JfULc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPUAYZ+wPJ0fohXTfP5gFgDp4gTuHyTIOgwXgEtmn0EQ6D3sGAiNqq7PKyCZNrnaRLxXCYub+pzRX+yjpyzkRpKdq/n2gKWWJkfH+f3Ew2nCEkN/YhRBxYMglGiMFCv68hy4FlLRWMppW78LMjX5KtfZgN95JjlXg6ETehQ5P2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TVuwBa/P; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TVuwBa/P"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Og64l9mq/6QYoXZ5oj3+y+6KjT13Ec3Oh9cGPi7dA2E=;
	b=TVuwBa/PyuGmFd8O96VXi5OJ5B6jwR6sQuoE6Nlnw0hqzh/R/cnWX+CVtNLDx3JpaPWOPssRf
	c7YvnOZWTu/JDlZhsTSAbOyHH7ewUCbDwEDhjPVaMuU/3ZOShVnoeu5UTs0l0/hojvKEUnYgj/q
	bIjOKd/I+ApqoGdjqPkOtTs=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4g0Mnw4v8ZzcZyv;
	Tue, 21 Apr 2026 20:57:24 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 06BF840537;
	Tue, 21 Apr 2026 21:04:06 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Apr
 2026 21:04:04 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>,
	<arnd@arndb.de>, <akpm@linux-foundation.org>, <ruanjinjie@huawei.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <david.laight.linux@gmail.com>,
	<nathan@kernel.org>, <cp0613@linux.alibaba.com>
Subject: [PATCH v5 1/3] lib/bitrev: Introduce GENERIC_BITREVERSE and cleanup Kconfig
Date: Tue, 21 Apr 2026 21:07:50 +0800
Message-ID: <20260421130752.607500-2-ruanjinjie@huawei.com>
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

Currently, the bit reversal lookup table is controlled by
!HAVE_ARCH_BITREVERSE. This makes it difficult for architectures to
provide a hardware-accelerated implementation while still falling
back to the generic table for specific configurations.

Introduce CONFIG_GENERIC_BITREVERSE to explicitly manage the generic
lookup table implementation. By using 'def_bool !HAVE_ARCH_BITREVERSE'
with a dependency on 'BITREVERSE', we ensure that:

1. The table is only compiled when needed.
2. The .config is not polluted with useless options when BITREVERSE
   is disabled.
3. Avoids bloating the .data section for architectures that have
   full hardware bit-reverse support and don't need the table.

Update lib/bitrev.c to use CONFIG_GENERIC_BITREVERSE instead of
checking the absence of HAVE_ARCH_BITREVERSE. This provides a
cleaner interface for architectures like RISC-V that may want to
selectively use the generic implementation as a fallback.

Suggested-by: David Laight <David.Laight@ACULAB.COM>
Suggested-by: Yury Norov <ynorov@nvidia.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 lib/Kconfig  | 18 ++++++++++++++++++
 lib/bitrev.c |  4 ++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 0f2fb9610647..e3f9719a4d6f 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -62,6 +62,24 @@ config HAVE_ARCH_BITREVERSE
 	  This option enables the use of hardware bit-reversal instructions on
 	  architectures which support such operations.
 
+config GENERIC_BITREVERSE
+	def_bool !HAVE_ARCH_BITREVERSE
+	depends on BITREVERSE
+	help
+	  This option provides the standard software-based bit reversal
+	  implementation using a lookup table.
+
+	  Architecture-specific implementations (HAVE_ARCH_BITREVERSE)
+	  and this generic version are not necessarily mutually exclusive
+	  at the configuration level, but selecting this ensures that
+	  the generic `bitrev8/16/32` functions are available when the
+	  CPU does not provide native instructions (like RISC-V's ZBKB
+	  extension).
+
+	  If you are an architecture maintainer and your CPU has native
+	  bit-reversal instructions, you should select HAVE_ARCH_BITREVERSE
+	  to skip this table-based implementation.
+
 config ARCH_HAS_STRNCPY_FROM_USER
 	bool
 
diff --git a/lib/bitrev.c b/lib/bitrev.c
index 81b56e0a7f32..3a53ff67aeba 100644
--- a/lib/bitrev.c
+++ b/lib/bitrev.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#ifndef CONFIG_HAVE_ARCH_BITREVERSE
+#ifdef CONFIG_GENERIC_BITREVERSE
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/bitrev.h>
@@ -44,4 +44,4 @@ const u8 byte_rev_table[256] = {
 };
 EXPORT_SYMBOL_GPL(byte_rev_table);
 
-#endif /* CONFIG_HAVE_ARCH_BITREVERSE */
+#endif /* CONFIG_GENERIC_BITREVERSE */
-- 
2.34.1

