Received: from va-2-115.ptr.blmpb.com (va-2-115.ptr.blmpb.com [209.127.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0503BC687
	for <linux-arch@vger.kernel.org>; Wed,  1 Jul 2026 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896998; cv=none; b=e2rudArs9ZtZy0zA9jKP/SIegivZjOrfMMF70/Fb+pBDkHAFd+fz7YsBDP5Vyilp+ydgDeigKwerkC3b9nb85HfW7JmAIwxMiba3ys3rVi9FU4t0yYzmlGroeM4RxpIXoejaNL9d6bIcDE6lrQf964MzqsdkBddfjuiXRwg0qMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896998; c=relaxed/simple;
	bh=6PQr6hjZt18km66iWZUyICj/bb1vK9HVYPVvLyKpg/0=;
	h=Subject:To:Cc:From:Date:Content-Type:Message-Id:Mime-Version:
	 In-Reply-To:References; b=Q6zDsmzSsSPhUC2umvxaGo9GwgWyx0/05bDlluavvHfbqGopmwcHVYdaRdZdMr2BV6yDXJpTarwrtb9mzHHjHa5SIlBDXBQDB2W9ac8xoYfbTgyXBndA2K8JtcJeVZtwaC0SQgN9r7jBGTofu8U5rnZWg1m4TbCAmH5AzGIqeVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CyELo4zu; arc=none smtp.client-ip=209.127.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CyELo4zu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782896987; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Qr6nwqCt7/yTOu+m9nVzSsxkIglWb+obVZHYhyWIf1Y=;
 b=CyELo4zux+0yoAuXHXovojmzaBzNWwwK7W763PJqdQwYlgEFoDN5oY3puIEyZt4ZglB00z
 ruVy2UDJVfIqfU5X32L5uOG+8GHF77JXAN+aKnUgLXfNbOCQf9jqjUIz7KqpLLbW/2ajkF
 xOU/oUswAHWFmjD3b993XoVuc2AyV6d3De+Qvikf/6mevkJVUtjo/Z6mYzJzAfAfscBTl0
 T6ZemKWY32fltNTKsUZe1p1Rx0fg6YmvdNMchZvjZpcmE465nbRfl/kuk7yPe2jhNBegoY
 xbqn73xTXCXgcYUAO2NFVCIKLDCUIsq2TxYHp/SsINhrQnmghI2E2p1V/WNQ4A==
Subject: [PATCH v5 7/8] x86/string: extend memcpy_flushcache() fixed-size fastpaths
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 7bit
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Wed,  1 Jul 2026 17:05:52 +0800
X-Lms-Return-Path: <lba+26a44d959+8ca77b+vger.kernel.org+lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Message-Id: <20260701090553.62691-8-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260701090553.62691-1-lizhe.67@bytedance.com>
References: <20260701090553.62691-1-lizhe.67@bytedance.com>

The new x86 memcpy_nt() helper in this series maps to
memcpy_flushcache(), and the ZONE_DEVICE fast path uses that primitive
for constant-sized struct page template copies.

memcpy_flushcache() currently inlines only the 4, 8, and 16-byte
cases. Larger constant-sized copies fall back to __memcpy_flushcache()
even when the destination is naturally aligned. Extend the inline
movnti coverage to 32, 48, 64, 80, and 96 bytes so the struct
page-sized copies used by that path can stay on the inline
non-temporal store path instead of dropping into the out-of-line
helper.

Factor the store sequences into 8/16/32/64-byte helpers, keep the
existing 4/8/16-byte cases handled directly in memcpy_flushcache(),
issue the stores in ascending address order, and leave all other sizes
on __memcpy_flushcache().

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 arch/x86/include/asm/string_64.h | 80 +++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 6f36abedc56a..95ef2d481418 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -4,6 +4,7 @@
 
 #ifdef __KERNEL__
 #include <linux/jump_label.h>
+#include <linux/align.h>
 
 /* Written 2002 by Andi Kleen */
 
@@ -82,8 +83,81 @@ int strcmp(const char *cs, const char *ct);
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE 1
 void __memcpy_flushcache(void *dst, const void *src, size_t cnt);
-static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
+
+static __always_inline void memcpy_flushcache_8(void *dst, const void *src)
+{
+	asm volatile("movntiq %1, %0"
+		     : "=m"(*(u64 *)dst)
+		     : "r"(*(const u64 *)src)
+		     : "memory");
+}
+
+static __always_inline void memcpy_flushcache_16(void *dst,
+						 const void *src)
+{
+	memcpy_flushcache_8(dst, src);
+	memcpy_flushcache_8(dst + 8, src + 8);
+}
+
+static __always_inline void memcpy_flushcache_32(void *dst,
+						 const void *src)
+{
+	memcpy_flushcache_16(dst, src);
+	memcpy_flushcache_16(dst + 16, src + 16);
+}
+
+static __always_inline void memcpy_flushcache_64(void *dst,
+						 const void *src)
 {
+	memcpy_flushcache_32(dst, src);
+	memcpy_flushcache_32(dst + 32, src + 32);
+}
+
+/*
+ * Keep the additional aligned fixed-size cases on the inline movnti path.
+ * Leave the existing 4/8/16-byte cases handled directly in
+ * memcpy_flushcache() so their code generation stays unchanged.
+ */
+static __always_inline int memcpy_flushcache_large(void *dst,
+						   const void *src,
+						   size_t cnt)
+{
+	char *dptr = dst;
+	const char *sptr = src;
+
+	if (!IS_ALIGNED((unsigned long)dst, 8))
+		return 0;
+
+	switch (cnt) {
+	case 32:
+		memcpy_flushcache_32(dptr, sptr);
+		return 1;
+	case 48:
+		memcpy_flushcache_32(dptr, sptr);
+		memcpy_flushcache_16(dptr + 32, sptr + 32);
+		return 1;
+	case 64:
+		memcpy_flushcache_64(dptr, sptr);
+		return 1;
+	case 80:
+		memcpy_flushcache_64(dptr, sptr);
+		memcpy_flushcache_16(dptr + 64, sptr + 64);
+		return 1;
+	case 96:
+		memcpy_flushcache_64(dptr, sptr);
+		memcpy_flushcache_32(dptr + 64, sptr + 64);
+		return 1;
+	}
+
+	return 0;
+}
+
+static __always_inline void memcpy_flushcache(void *dst, const void *src,
+					      size_t cnt)
+{
+	if (!cnt)
+		return;
+
 	if (__builtin_constant_p(cnt)) {
 		switch (cnt) {
 			case 4:
@@ -97,7 +171,11 @@ static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t
 				asm ("movntiq %1, %0" : "=m"(*(u64 *)(dst + 8)) : "r"(*(u64 *)(src + 8)));
 				return;
 		}
+
+		if (memcpy_flushcache_large(dst, src, cnt))
+			return;
 	}
+
 	__memcpy_flushcache(dst, src, cnt);
 }
 
-- 
2.20.1
